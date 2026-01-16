#! /bin/bash

# View sub-package Python - For example: pip install "unstructured[xlsx]"
python3 - <<EOF
import importlib.metadata
print(importlib.metadata.metadata("unstructured").get_all("Provides-Extra"))
EOF