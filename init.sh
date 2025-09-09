a='https://raw.githubusercontent.com/Sable/android-platforms/refs/heads/master/android-34/android.jar'
r="https://dl.google.com/android/maven2/com/android/tools/r8/8.11.18/r8-8.11.18.jar"
# checking if all necessary packages are installed

aapt2 version 2> /dev/null || pkg in aapt2
javac --version > /dev/null || pkg in openjdk-21
apksigner version > /dev/null || pkg in apksigner
zip --version > /dev/null || pkg in zip
samu --version > /dev/null || pkg in samurai

# checking if all necessary external files are present for building

test -a android.jar || curl -L\#O $a
test -a r8.jar || curl -L\# $r -o r8.jar

create-keystore() {
	read -p "name of keystore file :" kn
	read -p "name of keystore alias :" ka
	read -p "name of keystore store and key password :" ksp
	keytool \
		-genkey -keystore ${kn}.keystore -storepass $ksp -keypass $ksp \
		-alias $ka -keyalg RSA -keysize 2048 -validity 10000
	sed "4s/x/${kn}/;5s/x/${ka}/;6s/x/${ksp}/" .template.vars.ninja > .vars.ninja
}

test -a *.keystore || create-keystore
mkdir -p hello-world/build/artifacts
