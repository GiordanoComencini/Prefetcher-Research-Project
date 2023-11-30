#include <algorithm>
#include <array>
#include <map>
#include <optional>
#include <iostream>

#include "cache.h"
#include "spt_v2.h"





spt_prefetcher::~spt_prefetcher()
{

}

spt_prefetcher::spt_prefetcher(string type) : Prefetcher(type) {
  init_knobs();
	init_stats();
}

void spt_prefetcher::invoke_prefetcher(uint64_t pc, uint64_t address, uint8_t cache_hit, uint8_t type, vector<uint64_t> &pref_addr)
{
  auto ip = pc;
  spt_prefetcher::prefetch(ip, address, pref_addr);
}

void spt_prefetcher::dump_stats() {
    std::cout << "-------- Custom final stats --------" << std::endl;
    std::cout << "Total number of elements ever stored in prediction table :" << spt_prefetcher::current_id << std::endl;
}