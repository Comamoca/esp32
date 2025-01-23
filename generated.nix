{ pkgs }: {
  esp32 = pkgs.dockerTools.pullImage {
    imageName = "espressif/idf-rust";
    imageDigest = "sha256:96cda7593e101140c2f9591b53a473513eed19667f8ac5630304490de2e26b64";
    sha256 = "sha256-MYipDlo/kWen1V8cQebqAgjO8P/icC4HkNQeWy7wcPA=";
    finalImageName = "espressif/idf-rust";
    finalImageTag = "all_latest";
  };
}

