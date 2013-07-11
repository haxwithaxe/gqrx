gnuradio_include=/usr/include/gnuradio

part_x_make(){
	if [ ! -f "$3" ] ;then
		return 1
    fi
	part=$1
	sub=$2
	file=$3
	sed -i "/gr_make_$sub[([:space:]]/ s/gr_make_$sub/gr\:\:$part$sub\:\:make/" $file
}

part_x_sptr(){
	if [ ! -f "$3" ] ;then
		return 1
    fi
	part=$1
	sub=$2
	file=$3
	sed -i "/gr_${sub}_sptr/ s/gr_${sub}_sptr/gr\:\:$part$sub\:\:sptr/" $file
}

part_x(){
	if [ ! -f "$3" ] ;then
		return 1
	fi
	echo 1 $1 2 $2 3 $3
	part=$1
	sub=$2
	file=$3
	part_x_make $part $sub $file
	part_x_sptr $part $sub $file
	sed -i "/gr_$sub[^([:space:]]\+/ s/gr_$sub/gr\:\:$part$sub/" $file
}

fix_headers_for_file(){
	file=$1
	sed -i 's/#include <gr_complex.h>/#include <gnuradio\/gr_complex.h>/' $file
	sed -i 's/#include <gr_firdes.h>/#include <gnuradio\/filter\/firdes.h>/' $file
	sed -i 's/#include <gr_io_signature.h>/#include <gnuradio\/io_signature.h>/' $file
	sed -i 's/#include <gri_fft.h>/#include <gnuradio\/fft\/fft.h>/' $file
	sed -i 's/#include <gruel\/high_res_timer.h>/#include <gnuradio\/high_res_timer.h>\/g' $file
	sed -i 's/#include <osmosdr\/osmosdr_/#include <osmosdr\/\/g' $file
	sed -i 's/#include <osmosdr\/source_c.h>/#include <osmosdr\/source.h>\/g' $file
	sed -i 's/#include <gri_/#include <gnuradio\/fft\//' $file
	sed -i 's/#include <gr_add_ff.h>/#include <gnuradio\/blocks\/add_ff.h>/' $file
	sed -i 's/#include <gr_complex_to_arg.h>/#include <gnuradio\/blocks\/complex_to_arg.h>/' $file
	sed -i 's/#include <gr_complex_to_float.h>/#include <gnuradio\/blocks\/complex_to_float.h>/' $file
	sed -i 's/#include <gr_complex_to_imag.h>/#include <gnuradio\/blocks\/complex_to_imag.h>/' $file
	sed -i 's/#include <gr_complex_to_interleaved_short.h>/#include <gnuradio\/blocks\/complex_to_interleaved_short.h>/' $file
	sed -i 's/#include <gr_complex_to_mag.h>/#include <gnuradio\/blocks\/complex_to_mag.h>/' $file
	sed -i 's/#include <gr_complex_to_mag_squared.h>/#include <gnuradio\/blocks\/complex_to_mag_squared.h>/' $file
	sed -i 's/#include <gr_complex_to_real.h>/#include <gnuradio\/blocks\/complex_to_real.h>/' $file
	sed -i 's/#include <gr_float_to_complex.h>/#include <gnuradio\/blocks\/float_to_complex.h>/' $file
	sed -i 's/#include <gr_multiply_cc.h>/#include <gnuradio\/blocks\/multiply_cc.h>/' $file
	sed -i 's/#include <gr_multiply_const_ff.h>/#include <gnuradio\/blocks\/multiply_const_ff.h>/' $file
	sed -i 's/#include <gr_multiply_ff.h>/#include <gnuradio\/blocks\/multiply_ff.h>/' $file
	sed -i 's/#include <gr_null_sink.h>/#include <gnuradio\/blocks\/null_sink.h>/' $file
	sed -i 's/#include <gr_sub_cc.h>/#include <gnuradio\/blocks\/sub_cc.h>/' $file
	sed -i 's/#include <gr_wavfile_sink.h>/#include <gnuradio\/blocks\/wavfile_sink.h>/' $file
	sed -i 's/#include <gr_wavfile_source.h>/#include <gnuradio\/blocks\/wavfile_source.h>/' $file
	sed -i 's/#include <gr_complex_to_xxx.h>/#include <gnuradio\/blocks\/complex_to_arg.h>\n#include <gnuradio\/blocks\/complex_to_float.h>\n#include <gnuradio\/blocks\/complex_to_imag.h>\n#include <gnuradio\/blocks\/complex_to_interleaved_short.h>\n#include <gnuradio\/blocks\/complex_to_mag.h>\n#include <gnuradio\/blocks\/complex_to_mag_squared.h>\n#include <gnuradio\/blocks\/complex_to_real.h>/' $file
	#sed -i 's/#include <gr_/#include <gnuradio\//' $file
}

fix_known(){
	file=$1
	sed -i 's/gr_firdes/gr\:\:filter\:\:firdes/g' $file
	sed -i 's/gr_hier_block2/gr\:\:hier_block2/g' $file
    sed -i 's/gr_top_block2/gr\:\:top_block2/g' $file
    sed -i 's/gr_top_block_make/gr\:\:top_block_make/g' $file
    sed -i 's/gr_top_block/gr\:\:top_block/g' $file
	sed -i 's/gr_complex/gr\:\:complex/g' $file
	sed -i 's/gruel::high_res_timer/gr::high_res_timer/g' $file
	sed -i 's/gr_make_complex_to_mag/gr\:\:blocks\:\:complex_to_mag\:\:make/g' $file
	sed -i 's/gr_make_complex_to_mag/gr\:\:blocks\:\:iir_filter_ffd\:\:make/g' $file
	sed -i 's/gr_make_fir_filter_ccc/gr\:\:filter\:\:fir_filter_ccc::make/g' $file
	sed -i 's/gr_make_fir_filter_fcc/gr\:\:filter\:\:fir_filter_fcc\:\:make/g' $file
	sed -i 's/gr_make_fir_filter_fff/gr\:\:filter\:\:fir_filter_fff\:\:make/g' $file
	sed -i 's/gr_make_freq_xlating_fir_filter_ccc/gr\:\:filter\:\:freq_xlating_fir_filter_ccc\:\:make/g' $file
	sed -i 's/gr_make_iir_filter_ffd/gr\:\:filter\:\:iir_filter_ffd\:\:make/g' $file
	sed -i 's/gr_make_io_signature/gr\:\:io_signature\:\:make/g' $file
	sed -i 's/gr_make_multiply_ff/gr\:\:blocks\:\:multiply_ff\:\:make/' $file
	sed -i 's/gr_make_pfb_arb_resampler_ccf/gr\:\:filter\:\:pfb_arb_resampler_ccf\:\:make/g' $file
	sed -i 's/gr_make_pfb_arb_resampler_fff/gr\:\:filter\:\:pfb_arb_resampler_fff\:\:make/g' $file
	sed -i 's/gr_make_quadrature_demod_cf/gr\:\:analog\:\:quadrature_demod_cf\:\:make/g' $file
	sed -i 's/gr_sync_block/gr\:\:sync_block/g' $file
	sed -i 's/gri_fft_complex/gr\:\:fft::fft_complex/g' $file
	sed -i 's/gri_/gr\:\:fft::/g' $file
	#sed -i 's/gr_/gr\:\:/g' $file
}

get_part(){
	echo `find $gnuradio_include/$1 -maxdepth 1 -type f -exec basename {} \; | cut -d'.' -f1 | sort | uniq`
}

fix_refs_for_file(){
	if [ -d $1 ] || [ ! -e $1 ] ;then 
		echo not file or does not exist: $1
		return 0
	fi
	file=$1
	fix_headers_for_file $file
	fix_known $file
	tops=`find $gnuradio_include -maxdepth 1 -type f -exec basename {} \; | cut -d'.' -f1 | sort | uniq`
	for t in $tops ;do
		part_x "" $t $file
	done
	parts=`find $gnuradio_include -maxdepth 1 -type d -exec basename {} \; | cut -d'.' -f1 | sort | uniq`
	for p in $parts ;do
		subs=`get_part $p`
		for s in $subs ;do
			part_x "${p}\\:\\:" $s $file
		done
	done
	fix_head_for_file $file
}

echo all args at top level $*

case "$1" in
	"start")
		echo start
		find "$2" -type f -regextype posix-extended -regex '.*\.(cc|cpp|h)' -exec sh $0 {} \;
		;;
	*)
		echo middle $1
		fix_refs_for_file $1
		;;
esac
