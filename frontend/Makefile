# 任意ターゲットを無視するルール（make add <pkg> の <pkg> を無視）
%:
	@:

# make add <パッケージ名>
add:
	fvm flutter pub add $(word 2,$(MAKECMDGOALS))

# make add-dev <パッケージ名>
add-dev:
	fvm flutter pub add $(word 2,$(MAKECMDGOALS)) -d

clean:
	fvm flutter clean

get:
	fvm flutter pub get

outdated:
	fvm flutter pub outdated

upgrade:
	fvm flutter pub upgrade