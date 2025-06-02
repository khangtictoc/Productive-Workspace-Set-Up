import subprocess
import re
import argparse
from tabulate import tabulate
from concurrent.futures import ThreadPoolExecutor

# Patterns for the five resources
RESOURCE_KEYS = [
    "cpu",
    "memory",
    "ephemeral-storage",
    "hugepages-1Gi",
    "hugepages-2Mi"
]

FLAG_TO_KEY = {
    "cpu": "cpu",
    "memory": "memory",
    "ephemeral_storage": "ephemeral-storage",
    "hugepages_1gi": "hugepages-1Gi",
    "hugepages_2mi": "hugepages-2Mi"
}

def get_node_names():
    result = subprocess.run(
        ["kubectl", "get", "nodes", "-o", "name"],
        capture_output=True, text=True, check=True
    )
    # Output: node/<node-name>
    return [line.split("/")[1] for line in result.stdout.strip().splitlines()]

def get_resource_lines(node_name):
    result = subprocess.run(
        ["kubectl", "describe", "node", node_name],
        capture_output=True, text=True, check=True
    )
    lines = result.stdout.splitlines()
    resource_lines = {}
    for line in lines:
        for key in RESOURCE_KEYS:
            # Match line starting with resource key (possibly indented)
            if re.match(rf"^\s*{key}\s", line):
                resource_lines[key] = " ".join(line.split())
    return node_name, resource_lines

def parse_args():
    parser = argparse.ArgumentParser(description="Show node resource usage columns.")
    parser.add_argument('--cpu', action='store_true', help='Show CPU column')
    parser.add_argument('--memory', action='store_true', help='Show Memory column')
    parser.add_argument('--ephemeral-storage', action='store_true', help='Show Ephemeral Storage column')
    parser.add_argument('--hugepages-1gi', action='store_true', help='Show Hugepages-1Gi column')
    parser.add_argument('--hugepages-2mi', action='store_true', help='Show Hugepages-2Mi column')
    args = parser.parse_args()
    # If no flags are set, show all
    if not any(vars(args).values()):
        return RESOURCE_KEYS
    enabled = []
    if args.cpu:
        enabled.append("cpu")
    if args.memory:
        enabled.append("memory")
    if args.ephemeral_storage:
        enabled.append("ephemeral-storage")
    if args.hugepages_1gi:
        enabled.append("hugepages-1Gi")
    if args.hugepages_2mi:
        enabled.append("hugepages-2Mi")
    return enabled

def main():
    enabled_keys = parse_args()
    node_names = get_node_names()
    table = []
    headers = ["nodename"] + enabled_keys

    with ThreadPoolExecutor() as executor:
        results = list(executor.map(get_resource_lines, node_names))

    for node, resource_lines in results:
        row = [node]
        for key in enabled_keys:
            row.append(resource_lines.get(key, ""))
        table.append(row)

    print(tabulate(table, headers=headers, tablefmt="github"))

if __name__ == "__main__":
    main()