#include <algorithm>
#include <array>
#include <map>
#include <optional>
#include <iostream>

#include "cache.h"
#include "sp_ghb.h"


sp_ghb_prefetcher::~sp_ghb_prefetcher()
{

}

sp_ghb_prefetcher::sp_ghb_prefetcher(string type) : Prefetcher(type) {
    init_knobs();
	init_stats();
}

void sp_ghb_prefetcher::invoke_prefetcher(uint64_t pc, uint64_t address, uint8_t cache_hit, uint8_t type, vector<uint64_t> &pref_addr)
{
    auto ip = pc;
    // type 0 correspond to a LOAD
    if(type  == 0){
        sp_ghb_prefetcher::prefetch(ip, address, pref_addr);
    }
}

void sp_ghb_prefetcher::dump_stats() {
    std::cout << "-------- Custom final stats --------" << std::endl;
    std::cout << "Total number of elements ever stored in prediction table :" << sp_ghb_prefetcher::current_ghb_id << std::endl;
}