#!/bin/sh

keep=yes
verbose=yes

for option; do
	case "$option" in
		--keep)
			keep=yes
			;;
		--verbose)
			verbose=yes
			;;
	esac
done

EXEEXT=
DIR=/raid/huwf_dev/run/polybench-c-4.2.1-beta
VERSION=TEST
SIZE=-DMINI_DATASET
CC="gcc"
HAVE_OPENCL=no
HAVE_OPENMP=no
srcdir="."
if [ $keep = "yes" ]; then
	OUTDIR="out.$VERSION"
	mkdir -p "$OUTDIR" || exit 1
else
	if test "x$TMPDIR" = "x"; then
		TMPDIR=/tmp
	fi
	OUTDIR=`mktemp -d $TMPDIR/ppcg.XXXXXXXXXX` || exit 1
fi
CPPFLAGS="-DPOLYBENCH_USE_C99_PROTO -DPOLYBENCH_DUMP_ARRAYS"
CPPFLAGS="$CPPFLAGS $SIZE -I $DIR/utilities"
CFLAGS="-lm --std=gnu99"

echo "Running tests in folder ${OUTDIR}"

run_tests () {
	ext=$1

	ppcg_options=$2
	cc_options=$3

	if [ "x$ppcg_options" = "x" ]; then
		ppcg_option_str="none"
	else
		ppcg_option_str=$ppcg_options
	fi

	if [ "x$cc_options" = "x" ]; then
		cc_option_str="none"
	else
		cc_option_str=$cc_options
	fi

	echo Test: $ext, ppcg options: $ppcg_option_str, CC options: $cc_option_str
	cd ${OUTDIR}
	for i in `cat $DIR/utilities/benchmark_list`; do
		echo $i
		name=`basename $i`
		file=$name
		name=${name%.c}
		mkdir -p ${name}
		cp $DIR/$i ${name}
		cd ${name}
		dir=`dirname $i`
		if [ $verbose = "yes" ]; then
			echo ../../ppcg$EXEEXT -I $DIR/$dir $file \
			$CPPFLAGS	$ppcg_options
		fi
		../../ppcg$EXEEXT -I $DIR/$dir $file \
		$CPPFLAGS	$ppcg_options || exit
		cd ..
	done
}

run_tests ppcg "--target=cuda"
#run_tests ppcg "--target=c --tile"
#run_tests ppcg_live "--target=c --no-live-range-reordering --tile"


if [ $keep = "no" ]; then
	rm -r "${OUTDIR}"
fi
