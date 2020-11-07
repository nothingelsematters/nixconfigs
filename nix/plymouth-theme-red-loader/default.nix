self: super:

{
  plymouth-theme-red-loader = super.stdenv.mkDerivation {
    pname = "plymouth-theme-red-loader";
    version = "0.0.1";
    src = fetchTarball
      "https://github.com/adi1090x/files/blob/24366703e2ff441392eaf1839a69c23b937066f5/plymouth-themes/themes/pack_4/red_loader.tar.gz?raw=true";
    installPhase = ''
      result=$out/share/plymouth/themes/red_loader
      mkdir -p $result
      cp * $result
      echo $result > tmp
      ${self.gnused}/bin/sed -i "s/\/usr\/share\/plymouth\/themes\/red_loader/$(sed 's/\//\\\//g' tmp)/g" $result/red_loader.plymouth
      rm tmp
    '';
    meta.description = "plymouth theme theme";
  };
}
