reth = import_module("github.com/kurtosis-tech/reth-package/lib/reth.star")
lighthouse = import_module("github.com/kurtosis-tech/lighthouse-package/lib/lighthouse.star")

network_params = json.decode(read_file("github.com/kurtosis-tech/geth-lighthouse-package/network_params.json"))

def run(plan):
    # Generate genesis, note EL and the CL needs the same timestamp to ensure that timestamp based forking works
    final_genesis_timestamp = reth.generate_genesis_timestamp()
    el_genesis_data = reth.generate_el_genesis_data(plan, final_genesis_timestamp, network_params)

    # Run the nodes
    el_context = reth.run(plan, el_genesis_data)
    lighthouse.run(plan, network_params, el_genesis_data, final_genesis_timestamp, el_context)

    return
