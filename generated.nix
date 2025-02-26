{ pkgs }: {
  esp32 = pkgs.dockerTools.pullImage {
    imageName = "espressif/idf-rust";
    imageDigest = "sha256:0548e817d6cfccf04859bb72746a3b5425428e8da68c503dd48288e6bca13084";
    sha256 = "sha256-3W4vjmrEY38RaCcbRmG5fyvV574vmxC0dE4HymnpTUc=";
    finalImageName = "espressif/idf-rust";
    finalImageTag = "all_latest";
  };
}

