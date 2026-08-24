class Logctl < Formula
  desc "Profile wrapper over logcli, driven by ~/logctl.toml"
  homepage "https://github.com/abhijit424515/logctl"
  url "https://github.com/abhijit424515/logctl/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "99600a76f73335bd030640169d733df180a93857c3dfbb965855b1e4041d8f69"
  license "MIT"

  depends_on "jq"
  depends_on "logcli"
  depends_on "yq"

  def install
    bin.install "logctl"
    bin.install_symlink bin/"logctl" => "lc"
  end

  def caveats
    <<~EOS
      Create your config with:
        logctl init
    EOS
  end

  test do
    ENV["LOGCTL_CONFIG"] = testpath/"c.toml"
    system bin/"logctl", "init"
    assert_equal "dev", shell_output("#{bin}/logctl profiles").strip
    assert_match "LOKI_ADDR='http://localhost:3100'", shell_output("#{bin}/lc env")
  end
end
