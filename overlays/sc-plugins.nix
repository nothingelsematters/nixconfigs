self: super:

{	
	sc-plugins = super.stdenv.mkDerivation {
		name = "sc3-plugins-3.10.0-beta1";
	
		src = super.fetchgit {
			url = "https://github.com/supercollider/sc3-plugins";
			rev = "4e3530b";
			sha256="0n2n4930igc5d645y74f12gb09p1bq52ydd99av7jmvpfsbgv4r2";
			fetchSubmodules = true;
		};
	
		buildInputs = with self; [ cmake supercollider fftw libsndfile ];
		cmakeFlags = with self; [ "-DSUPERNOVA=OFF" "-DSC_PATH=${supercollider}/include/SuperCollider" "-DFFTW3F_LIBRARY=${fftw}/lib/"];
	};
}