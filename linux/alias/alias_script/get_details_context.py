import json
import subprocess
from tabulate import tabulate  # Ensure you have this library installed

# Get the JSON content from the kubectl command
try:
    file_content = subprocess.check_output(
        ["kubectl", "config", "view", "--raw", "-o", "json"],
        text=True
    )
except subprocess.CalledProcessError as e:
    print(f"Error executing kubectl command: {e}")
    exit(1)

data = json.loads(file_content)

# Extract clusters information
cluster_map = {cluster["name"]: cluster["cluster"]["server"] for cluster in data["clusters"]}

# Extract contexts
header = ["NAME", "CLUSTER", "AUTHINFO", "NAMESPACE", "SERVER"]
rows = []

for context in data["contexts"]:
    name = context["name"]
    cluster = context["context"]["cluster"]
    user = context["context"]["user"]
    namespace = context["context"].get("namespace", "N/A")  # Handle missing namespace
    server = cluster_map.get(cluster, "N/A")
    
    rows.append([name, cluster, user, namespace, server])

# Format output as a table using tabulate
print(tabulate(rows, headers=header, tablefmt="plain"))