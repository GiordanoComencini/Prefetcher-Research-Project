#include <deque>
#include "prefetcher.h"
using namespace std;


class sp_ghb_prefetcher : public Prefetcher {

    struct ghb_entry {
        uint64_t last_cl_addr = 0;
        struct ghb_entry *next = nullptr;
        struct ghb_entry *prev = nullptr;
        int index_table_id = 0;
    };

    struct index_table_entry {
        uint64_t ip = 0;
        struct ghb_entry *ghb_entry_pointer = nullptr;

        uint64_t tag() const { return ip;}
    };

    constexpr static int GHB_SIZE = 1024; // Size of the global history buffer
    constexpr static int INDEX_TABLE_SIZE = 512; // Size of the index table
    constexpr static int NB_STRIDES_COMPUTED = 2; // When computing the stride, we look at the last NB_STRIDES_COMPUTED strides, if there are all equal, we prefetch

    ghb_entry default_ghb_entry;
    std::array<ghb_entry, GHB_SIZE> global_history_buffer = {default_ghb_entry};

    index_table_entry default_index_table_entry;
    std::array<index_table_entry, INDEX_TABLE_SIZE> index_table = {default_index_table_entry};


    int current_ghb_id = 0; 


    /// Remove an element from a linked list stored in the GHB array
    void pop_at(int id)
    {
        ghb_entry *next_ghb_entry = global_history_buffer[id].next;
        ghb_entry *prev_ghb_entry = global_history_buffer[id].prev;
        int index_table_id = global_history_buffer[id].index_table_id;

        if(next_ghb_entry != nullptr){
        next_ghb_entry->prev = prev_ghb_entry;
        }else{
        if(prev_ghb_entry != nullptr){
            prev_ghb_entry->next = nullptr;
        }else{
            index_table[index_table_id].ghb_entry_pointer = nullptr;
        }
        }

        if(prev_ghb_entry != nullptr){
        prev_ghb_entry->next = next_ghb_entry;
        }else{
        index_table[index_table_id].ghb_entry_pointer = next_ghb_entry;
        }
    }

    void insert(uint64_t ip, uint64_t cl_addr, ghb_entry *next)
    {
        int ghb_fill_id = (current_ghb_id+1) % GHB_SIZE;

        pop_at(ghb_fill_id);
        
        global_history_buffer[ghb_fill_id].last_cl_addr = cl_addr;
        global_history_buffer[ghb_fill_id].next = next;

        int index_table_fill_id = ip % INDEX_TABLE_SIZE;
        index_table[index_table_fill_id].ghb_entry_pointer = &global_history_buffer[ghb_fill_id];

        current_ghb_id++;

    }

    void insert(uint64_t ip, uint64_t cl_addr)
    {
        int ghb_fill_id = (current_ghb_id+1) % GHB_SIZE;

        pop_at(ghb_fill_id);
        
        global_history_buffer[ghb_fill_id].last_cl_addr = cl_addr;
        global_history_buffer[ghb_fill_id].next = nullptr;

        int index_table_fill_id = ip % INDEX_TABLE_SIZE;
        index_table[index_table_fill_id].ghb_entry_pointer = &global_history_buffer[ghb_fill_id];

        current_ghb_id++;

    }

    int64_t compute_stride(uint64_t cl_addr, ghb_entry *hit)
    {
        uint64_t current_addr = cl_addr;
        int64_t strides[NB_STRIDES_COMPUTED];

        ghb_entry *entry = hit;

        int i = 0;

        while((*entry).next != nullptr && i < NB_STRIDES_COMPUTED){
            int64_t stride = static_cast<int64_t>(current_addr) - static_cast<int64_t>((*entry).last_cl_addr);
            strides[i] = stride;
            current_addr = (*entry).last_cl_addr;
            entry = (*entry).next;
            i++;
        }
        if(std::all_of(strides, strides+NB_STRIDES_COMPUTED, [strides](int x){ return x==strides[0];}) && strides[0] != 0){
            return strides[0];
        }else{
            return 0;
        }
    }

    public:
        void prefetch(uint64_t ip, uint64_t cl_addr, vector<uint64_t> &pref_addr)
        {
            
            int hit_id = ip % INDEX_TABLE_SIZE;

            if(index_table[hit_id].ghb_entry_pointer != nullptr){
                ghb_entry *entry;
                entry = index_table[hit_id].ghb_entry_pointer;
                auto stride = compute_stride(cl_addr, entry);
                if(stride != 0){
                    auto pf_address = static_cast<uint64_t>(cl_addr + stride);

                    pref_addr.push_back(pf_address);
                }
                    insert(ip, cl_addr, entry);
            }else{
                insert(ip, cl_addr);
            }
        
        }
        public:
            sp_ghb_prefetcher(string type);
            ~sp_ghb_prefetcher();
            void invoke_prefetcher(uint64_t pc, uint64_t address, uint8_t cache_hit, uint8_t type, vector<uint64_t> &pref_addr);
            void dump_stats();
            void print_config() {};

        private:
            void init_knobs() {};
            void init_stats() {};


};

