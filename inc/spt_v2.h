#include <deque>
#include "prefetcher.h"
using namespace std;


class spt_prefetcher : public Prefetcher {
  struct spt_entry {
    uint64_t ip = 0;           
    uint64_t last_cl_addr = 0;
    int64_t previous_stride = 0;
    int8_t valid = 0;   

    uint64_t tag() const { return ip; }
  };

  constexpr static int SPT_SIZE = 1024;

  std::array<spt_entry, SPT_SIZE> prediction_table = {};

  int current_id = 0;

  void update(uint64_t ip, uint64_t cl_addr, int64_t stride)
  {
    for (spt_entry entry : prediction_table) {
      if (entry.tag() == ip) {
        entry.last_cl_addr = cl_addr;
        entry.previous_stride = stride;
        entry.valid = 1;
        break;
      }
    }
    
    
  }

  void insert(uint64_t ip, uint64_t cl_addr)
  {
    int fill_id = (current_id+1) % SPT_SIZE;
    
    prediction_table[fill_id].ip = ip;
    prediction_table[fill_id].last_cl_addr = cl_addr;
    prediction_table[fill_id].valid = 1;

    current_id++;

  }


public:
  void prefetch(uint64_t ip, uint64_t cl_addr, vector<uint64_t> &pref_addr)
  {
    for (spt_entry entry: prediction_table) {
      if (entry.tag() == ip) {
        // for the one single entry that matches
        int64_t stride = cl_addr - entry.last_cl_addr;
        if(entry.valid){
          if(stride != 0 && (static_cast<int64_t>(cl_addr)+stride >= 0)) {
            uint64_t pf_address = static_cast<uint64_t>(cl_addr + stride);
            // Only prefetch if address + stride goes outside of the current block
            // and stride is different from previous stride or previous stride has not been saved (zero is default value)
            if ((pf_address >> LOG2_BLOCK_SIZE) != (cl_addr >> LOG2_BLOCK_SIZE) && 
                ((stride == entry.previous_stride) || entry.previous_stride != 0) ) 
            {
              pref_addr.push_back(pf_address);
            } 
          }
        }
        update(ip, cl_addr, stride);
      } else {
        insert(ip, cl_addr);
      }
      break;
    }   
    
  }
  private:
    void init_knobs() {};
    void init_stats() {};

  public:
    spt_prefetcher(string type);
    ~spt_prefetcher();
    void invoke_prefetcher(uint64_t pc, uint64_t address, uint8_t cache_hit, uint8_t type, vector<uint64_t> &pref_addr);
    void dump_stats();
    void print_config() {};

};


