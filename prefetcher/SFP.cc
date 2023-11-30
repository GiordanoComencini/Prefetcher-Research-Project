#include <map>
#include <queue>
#include <iostream>

#include "cache.h"
#include "champsim.h"
#include "sfp.h"

// Constructor
SFP_prefetcher::SFP_prefetcher(string type) : Prefetcher(type) {
  /*
    Removed because I made them class variables (static)
    SHT = std::map<uint32_t, SHT_entry>();
    AST = std::map<uint64_t, AST_entry>();
    SHT_use_order = std::queue<uint32_t>();
  */
}
// Default constructor method
SHT_entry::SHT_entry() : valid(false) {
  for (int i = 0; i < NUM_FOOTPRINTS_USED; i++) {
    for (int j = 0; j < FOOTPRINT_SIZE; j++) {
      footprints[i][j] = false;
    }
  }
}

// Default constructor method
AST_entry::AST_entry() : SHTi(-1), fetched_by_SFP(false), active(false) {
  for (int i = 0; i < FOOTPRINT_SIZE; i++) {
    footprint[i] = false;
  }
}

//  Fetches all blocks marked in the footprint of the given SHT entry
void SFP_prefetcher::fetchPredictedFootprint(SHT_entry &entry, uint64_t addr, vector<uint64_t> &pref_addr){
  uint64_t pf_address;
  for (int i = 0; i < FOOTPRINT_SIZE; i++){
    if (entry.footprints[0][i]){
      pf_address = START_OF_SECTOR(addr) + i * BLOCK_SIZE;
      pref_addr.push_back(pf_address);  // prefetch request!
    } 
  }
}

// Index into table to check if entry is present
bool SFP_prefetcher::hasRecordedFootprint(uint64_t addr, uint64_t pc) {
  uint32_t tag = getTag(addr, pc);
  if (SHT[tag].valid == true) {
    return true;
  }
  return false;
}

void SFP_prefetcher::invalidateRecordedFootprint(uint64_t addr, uint64_t pc) {
  uint32_t tag = getTag(addr, pc);
  SHT[tag].valid = false;
}

bool SFP_prefetcher::isActive(uint64_t sector){
  if (AST[sector].active == true) {
    return true;
  }
  return false;
}

// Starts tracking the footprint for this sector.
// !! Does NOT set the flag fetched_by_SFP. It needs to be set manually
void SFP_prefetcher::activateSector(uint64_t sector, uint64_t addr, uint64_t pc) {
  AST[sector] = AST_entry();
  AST[sector].SHTi = getTag(addr, pc);
  AST[sector].active = true;
}

// Updates with a footprint for the new memory request 
void SFP_prefetcher::updateAST(uint64_t sector, uint64_t addr) {
  AST[sector].footprint[LINE_IN_SECTOR(addr)] = true;
}

// Removes sector from the AST and transfer the recorded footprint to the SHT
void SFP_prefetcher::deactivateSector(uint64_t sector) {
  uint32_t SHTi = AST[sector].SHTi;
  for (int i = 0; i < FOOTPRINT_SIZE; i++) {
    SHT[SHTi].footprints[0][i] = AST[sector].footprint[i];
  }
  SHT[SHTi].valid = true;
  // update LRU order (if SHT is full, remove least recently used element)
  if (SHT_use_order.size() >= SHT_SIZE) {
    SHT.erase(SHT_use_order.front());
    SHT_use_order.pop();
  }
  SHT_use_order.push(SHTi);
  // reset the entry to invalidate it
  AST[sector] = AST_entry();
}

//  Simply fetches the next three blocks in the sector 
void SFP_prefetcher::fetchDefaultPrediction(uint64_t addr, vector<uint64_t> &pref_addr){
  uint64_t pf_address;
  for (int i = 1; i <= RECOVERY_BLOCKS; i++){
    pf_address = START_OF_BLOCK(addr) + (i << LOG2_BLOCK_SIZE);
    pref_addr.push_back(pf_address); // Request prefetch!  
  }
}
// Recovery mechanism : fetches lines when we notice we did not fetch all the necessary ones at sector activation.
// Acts differently based on how we prefetched when we activated the sector (SPF or default)
void SFP_prefetcher::fetchRecovery(uint64_t sector, uint64_t addr, vector<uint64_t> &pref_addr) {
  if (AST[sector].fetched_by_SFP) {
    // If we used the footprint data to prefetch, we only fetch the necessary block.
    // This is equivalent to just servicing the miss, so we do nothing.
  }
  else {
    // If we originally used the default predictor, we use it again to recover
    fetchDefaultPrediction(addr, pref_addr);
  }
}

// Tag is obtained as last 20 bits of address (excluding address inside cache block and sector ) 
// concatenated with last 12 bits of program counter 
uint32_t getTag(uint64_t addr, uint64_t pc) {
  uint32_t bits_pc = (pc & 0xfff);
  uint32_t bits_address = ((addr >> (LOG2_BLOCK_SIZE + LOG2_FOOTPRINT_SIZE)) & 0xfffff) << 12; 
  return bits_address | bits_pc;
}


void SFP_prefetcher::invoke_prefetcher(uint64_t pc, uint64_t address, uint8_t cache_hit, uint8_t type, vector<uint64_t> &pref_addr)
{
  // This function is called when a tag is checked in the cache.
  // ARGUMENTS:

  // addr: the address of the packet. If this is the first-level cache, the offset bits are included. 
      // Otherwise, the offset bits are zero. If the cache was configured with “virtual_prefetch”: true, this address will be a virtual address. 
      // Otherwise, this is a physical address.
  // pc: the address of the instruction that initiated the demand. 
      // If the packet is a prefetch from another level, this value will be 0.
  // cache_hit: if this tag check is a hit, this value is nonzero. Otherwise, it is 0.
  // useful_prefetch: if this tag check hit a prior prefetch, this value is true.
  // type: the result of static_cast<std::underlying_type_t<access_type>>(v) for v in: 
      // * access_type::LOAD * access_type::RFO * access_type::PREFETCH * access_type::WRITE * access_type::TRANSLATION

  // The function should return metadata that will be stored alongside the block.

  uint64_t sector = address / (SECTOR_SIZE_blocks* BLOCK_SIZE);

  if (cache_hit) {
    if (SFP_prefetcher::isActive(sector)) {
      SFP_prefetcher::updateAST(sector, address);
    }
  }
  else {
    if (SFP_prefetcher::isActive(sector)) {
      // This means we either did not prefetch all necessary lines when activating the sector 
      // Or enough time has passed so that a previously prefetched line has been evicted from the cache
      SFP_prefetcher::fetchRecovery(sector, address, pref_addr);
      if (AST[sector].footprint[LINE_IN_SECTOR(address)] == true) {
        SFP_prefetcher::deactivateSector(sector);
        SFP_prefetcher::activateSector(sector, address, pc);
      }
    }
    else {
      SFP_prefetcher::activateSector(sector, address, pc);
      if (SFP_prefetcher::hasRecordedFootprint(address, pc)) {
        SFP_prefetcher::fetchPredictedFootprint(SHT[getTag(address, pc)], address, pref_addr);
        SFP_prefetcher::invalidateRecordedFootprint(address, pc);
        AST[sector].fetched_by_SFP = true;
      }
      else {
        SFP_prefetcher::fetchDefaultPrediction(address, pref_addr);
      }
    }
    SFP_prefetcher::updateAST(sector, address);
  }
}



void SFP_prefetcher::dump_stats() {
  std::cout << "-------- Custom final stats --------" << std::endl;
  std::cout << "Size of queue : " << SFP_prefetcher::SHT_use_order.size() << std::endl;
  std::cout << "Size of SHT : " << SFP_prefetcher::SHT.size() << std::endl;
  std::cout << "Size of AST : " << SFP_prefetcher::AST.size() << std::endl;
}
