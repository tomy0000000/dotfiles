#!/usr/bin/env python
# Infer all affected features based on a list of changed features
#
# Usage in GitHub Actions:
#
# .github/scripts/affected-list.py 'changed_features_json' 'all_features_json'
#
# Usage in terminal:
#
# .github/scripts/affected-list.py '["macos-brew"]' "$(GITHUB_OUTPUT=/dev/null .github/scripts/all-features.sh)"

import json
import os
import sys
from collections import defaultdict


# A helper function to recursively collect all dependents of a feature
def collect_dependents(
    dependency_map: dict[str, set[str]], feature: str, visited: set[str]
) -> set[str]:
    for dependent in dependency_map[feature]:
        if dependent not in visited:
            visited.add(dependent)
            collect_dependents(dependency_map, dependent, visited)
    return visited


# Build a dependency map from all features
# Format: {feature_a: [feature_b_depends_on_a, feature_c_depends_on_a, ...]}
def parse_dependencies(all_features: dict[str, list[str]]) -> dict[str, set[str]]:
    dependency_map: dict[str, set[str]] = defaultdict(set)

    # Convert dependencies to a reverse map
    for feature, dependencies in all_features.items():
        for dep in dependencies:
            dependency_map[dep].add(feature)

    # Flatten trees of dependencies
    # E.g., if A -> B and B -> C, then A -> B,C
    flattened: dict[str, set[str]] = defaultdict(set)
    for feature in all_features:
        flattened[feature] = collect_dependents(dependency_map, feature, set())

    return flattened


def infer_dependencies(
    changed_features: list[str], dependency_map: dict[str, set[str]]
) -> list[str]:
    affected_features: set[str] = set(changed_features)
    for feature in changed_features:
        affected_features.update(dependency_map[feature])
    return sorted(affected_features)


def output_to_github_actions(affected_features: list[str]) -> None:
    github_output_path = os.getenv("GITHUB_OUTPUT")
    if github_output_path:
        with open(github_output_path, "a") as gh_out:
            gh_out.write(f"features={json.dumps(affected_features)}\n")


def main() -> None:
    # Parse input arguments
    changed_features = list(json.loads(sys.argv[1]))
    all_features = json.loads(sys.argv[2])

    # Build the dependency map
    dependency_map = parse_dependencies(all_features)

    # Infer affected features
    affected_features = infer_dependencies(changed_features, dependency_map)

    print("Affected features:")
    print(json.dumps(affected_features))

    # Output to GitHub Actions
    output_to_github_actions(affected_features)


if __name__ == "__main__":
    main()
