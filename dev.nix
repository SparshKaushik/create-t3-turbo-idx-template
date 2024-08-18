# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{pkgs, ...}: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"

  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.nodejs_20
    pkgs.bun
    pkgs.git
  ];

  # Sets environment variables in the workspace
  env = {
    EXPO_USE_FAST_RESOLVER = 1;
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "bradlc.vscode-tailwindcss"
      "Prisma.prisma"
      "esbenp.prettier-vscode"
      "christian-kohler.npm-intellisense"
      "dbaeumer.vscode-eslint"
      "Supermaven.supermaven"
      "msjsdiag.vscode-react-native"
    ];

    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        bun-install = "bun i && bun add @expo/ngrok@^4.1.0";
      };
      # Runs when the workspace is (re)started
      onStart = {
        connect-device = ''
          adb -s localhost:5554 wait-for-device
        '';
        android = ''
          npm run android -- --port 5554 --tunnel
        '';
      };
    };

    # Enable previews
    previews = {
      enable = true;
      previews = {
        # You don't need this do you ?
        # web = {
        #   command = ["npm" "run" "web" "--" "--port" "$PORT"];
        #   manager = "web";
        # };
        android = {
          # noop
          command = ["tail" "-f" "/dev/null"];
          manager = "web";
        };
      };
    };
  };
}
