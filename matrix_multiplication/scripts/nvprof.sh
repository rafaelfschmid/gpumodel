
prog=$1 # program to test
input=$2 # input to be executed
profdir=$3 # dir to be saved

parameters="--kernels MatMulKernel --metrics gld_efficiency,gst_efficiency,sm_efficiency,achieved_occupancy,inst_executed,ipc_instance,inst_per_warp,ldst_executed,warp_execution_efficiency,inst_replay_overhead,gld_transactions,gst_transactions,gld_transactions_per_request,gst_transactions_per_request,gld_throughput,gst_throughput,dram_read_transactions,dram_write_transactions,dram_read_throughput,dram_write_throughput,shared_load_transactions,shared_store_transactions,shared_load_transactions_per_request,shared_store_transactions_per_request,l1_cache_global_hit_rate,l2_read_transactions,l2_write_transactions,l2_read_throughput,l2_write_throughput,l2_l1_read_hit_rate,l2_l1_read_throughput,l1_shared_utilization,l2_utilization,stall_exec_dependency,stall_data_request,stall_other,alu_fu_utilization,ldst_fu_utilization,dram_utilization"

nvprof --csv --log-file $profdir/$prog.prof  $parameters ./$prog < $input
