# main.star
geth = import_module("github.com/siliconswampio/geth-star-package/lib/geth.star")
lighthouse = import_module("github.com/kurtosis-tech/lighthouse-package/lib/lighthouse.star")
network_params = json.decode(read_file("./network_params.json"))

def run(plan):
    # Generate genesis, note EL and the CL needs the same timestamp to ensure that timestamp based forking works
    final_genesis_timestamp = geth.generate_genesis_timestamp(plan)
    el_genesis_data = geth.generate_el_genesis_data(plan, final_genesis_timestamp, network_params)

    # NEW LINES TO ADD:
    # Run the nodes
    el_context = geth.run(plan, network_params, el_genesis_data)
    lighthouse.run(plan, network_params, el_genesis_data, final_genesis_timestamp, el_context)

    return
