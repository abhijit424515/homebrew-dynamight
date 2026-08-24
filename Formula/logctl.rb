class Logctl < Formula
  desc "Profile wrapper over logcli, driven by ~/logctl.toml"
  homepage "https://github.com/abhijit424515/logctl"
  url "https://github.com/abhijit424515/logctl/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ce5a4f4ab25c7a391b72534a23c3f9db4d248bde7263434ec81064727a9c4997"
  license "MIT"

  depends_on "logcli"

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
    assert_match "LOKI_ADDR=http://localhost:3100", shell_output("#{bin}/lc env")
  end
end
