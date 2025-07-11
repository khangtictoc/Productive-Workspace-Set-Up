def generate_git_aliases(input_file, output_file):
    """
    Reads git_aliases.txt and creates Linux shell aliases in .git_aliases_script
    Skips all shell function aliases and shell command aliases (starting with '!')
    """
    aliases = []
    skip_multiline = False

    with open(input_file, "r") as infile:
        for line in infile:
            stripped_line = line.strip()

            # Skip empty lines and comments
            if not stripped_line or stripped_line.startswith("#"):
                continue

            # If currently skipping a multi-line alias, check for the end
            if skip_multiline:
                if "};f" in stripped_line or "}; f" in stripped_line:
                    skip_multiline = False
                continue

            # Detect alias definition
            if "=" in stripped_line:
                parts = stripped_line.split("=", 1)
                alias_name = parts[0].strip()
                alias_command = parts[1].strip()

                # 🚨 Clean up leading/trailing quotes in alias_command
                if alias_command.startswith(("\"", "'")) and alias_command.endswith(("\"", "'")):
                    alias_command = alias_command[1:-1].strip()

                # 🚨 Skip all shell function aliases
                if alias_command.startswith("!f()") or "!f()" in alias_command:
                    print(f"⚠️  Skipping shell function alias: {alias_name}")
                    if alias_command.endswith("\\"):
                        skip_multiline = True
                    continue

                # 🚨 Skip all shell command aliases (starting with '!')
                if alias_command.startswith("!"):
                    print(f"⚠️  Skipping shell command alias: {alias_name}")
                    continue

                # 🚨 Skip multi-line aliases using backslash continuation
                if alias_command.endswith("\\"):
                    print(f"⚠️  Skipping multi-line alias (line continuation): {alias_name}")
                    skip_multiline = True
                    continue

                # ✅ Otherwise, process as a simple alias
                linux_alias_name = f"g{alias_name}"
                linux_alias_cmd = f"git {alias_command}"

                comment = (
                    f"# alias {linux_alias_name}: 'g' for 'git', "
                    f"'{alias_name}' for '{alias_command}'"
                )
                aliases.append(
                    f"{comment}\nalias {linux_alias_name}=\"{linux_alias_cmd}\""
                )

    # Write to output file
    with open(output_file, "w") as outfile:
        outfile.write("\n\n".join(aliases))
        outfile.write("\n")

    print(f"✅ Generated {len(aliases)} simple aliases in '{output_file}'")


# Usage
if __name__ == "__main__":
    generate_git_aliases("git_aliases.txt", ".git_aliases_temp")
