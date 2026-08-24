class Logctl < Formula
  desc "Profile wrapper over logcli, driven by ~/logctl.toml"
  homepage "https://github.com/abhijit424515/logctl"
  url "https://github.com/abhijit424515/logctl/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "8ba0ff367317d54c9637fa14c123db0c550c681ba0b835012acebb58aa82ee66"
  license "MIT"

  depends_on "jq"
  depends_on "logcli"
  depends_on "yq"

  def install
    bin.install "logctl"
    bin.install_symlink bin/"logctl" => "lc"
    pkgshare.install "logctl.example.toml"
  end

  def caveats
    <<~EOS
      Create ~/logctl.toml to define your profiles. An example config is at:
        #{opt_pkgshare}/logctl.example.toml
    EOS
  end

  test do
    (testpath/"c.toml").write <<~TOML
      default = "dev"

      [dev]
      addr = "http://localhost:3100"
    TOML
    ENV["LOGCTL_CONFIG"] = testpath/"c.toml"
    assert_equal "dev", shell_output("#{bin}/logctl profiles").strip
    assert_match "LOKI_ADDR='http://localhost:3100'", shell_output("#{bin}/lc env")
  end
end
