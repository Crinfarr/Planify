full: init web pc

web:
	haxe hxml/web.hxml

pc:
	haxe hxml/pc.hxml

init:
	@if [ $$(npm view @viz-js/viz version | grep -Po "\d+\.\d+") != "3.7" ]; then\
		echo "viz-js updated to $$(npm view @viz-js/viz version), verify breaking changes and update makefile to build";\
		exit 1;\
	fi;
	@if [ ! -s pkg/web/viz-standalone.js ]; then\
		echo "Downloading viz-standalone @latest";\
		wget -q $$(npm view @viz-js/viz dist.tarball);\
		tar -xf "viz-$$(npm view @viz-js/viz version).tgz";\
		cp package/lib/viz-standalone.js pkg/web;\
		rm -rf package "viz-$$(npm view @viz-js/viz version).tgz";\
	fi;
	git submodule init;
	git submodule update --remote;
	@if [ ! -s .haxelib/hxcpp/git/hxcpp.n ]; then\
		echo "Compiling hxcpp.n";\
		cd .haxelib/hxcpp/git/tools/hxcpp;\
		haxe compile.hxml;\
	fi;
deinit:
	git submodule deinit --all -f;
	rm pkg/web/viz-standalone.js;

reinit: deinit init