{ autoreconfHook
, fetchFromGitHub
, libevdev
, pkg-config
, rustPlatform
}:

let
  pname = "kanata";
  version = "unstable-20220718";
in
rustPlatform.buildRustPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "jtroo";
    repo = pname;
    rev = "b30ab1d056a4264f3eee5ae6dbef955696b660ee";
    sha256 = "sha256-0NRy/+GHuL7hVsn6CG2EHIwN5a5aIplFjtWDCq+otjA=";
  };

  cargoSha256 = "sha256-+DFuyrAUKj2OnP9nZpMNP33S+DwzM/xgBID8uLSg4z8=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libevdev ];
}
