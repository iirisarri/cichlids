#!/usr/bin/perl

use warnings;
use strict;

# annotate_tree_leaves.pl
# Iker Irisarri. University of Konstanz. Oct 2015
# Script to translate abbreviated to full taxon names in trees
# To avoid problems, taxon names were trimmed for phylip files
# Original of new taxon names can be use (after removal of 8 species and renaming of 6)

my $infile = shift;

=pod
# old taxa (species to be renamed marked with *)
my %id_to_species = (	"I11181_146"	=>	"I11181_14624_Tilapia_sparrmanii",
						"I11182_148"	=>	"I11182_14833_Steatocranus_irvinae",
						"I11183_148"	=>	"I11183_14834_Paratilapia_polleni",
						"I11184_148"	=>	"I11184_14836_Tropheus_moorii_Mpimbwe",
						"I11185_148"	=>	"I11185_14837_Tropheus_moorii_Kapampa",
						"I11186_148"	=>	"I11186_14839_Tropheus_sp_red_belly",
						"I11187_148"	=>	"I11187_14840_Heterotilapia_buttkoferi",
						"I11188_148"	=>	"I11188_14841_Tropheus_lunatus_Yungu",
						"I11189_148"	=>	"I11189_14842_Tropheus_moorii_red_moba",
						"I11190_148"	=>	"I11190_14843_Tropheus_brichardi_NW",
						"I11191_148"	=>	"I11191_14844_Tropheus_brichardi_kavalla",
						"I11192_148"	=>	"I11192_14845_Tropheus_brichardi_Mtoto",
						"I11193_148"	=>	"I11193_14846_Tropheus_annectens_NW",
						"I11194_148"	=>	"I11194_14847_Tropheus_annectens_CW",
						"I11195_148"	=>	"I11195_14848_Tropheus_annectens_SW",
						"I11196_148"	=>	"I11196_14849_Tropheus_maculatus",
						"I11197_148"	=>	"I11197_14850_Tropheus_moorii_Mpimbwe",
						"I11198_148"	=>	"I11198_14851_Tropheus_lunatus_Malagarazi",
						"I11199_148"	=>	"I11199_14852_Tropheus_lunatus_Karamba",
						"I9090_1_1_"	=>	"I9090_1_1_Astatoreochromis_alluaudi",
						"I9091_1_2_"	=>	"I9091_1_2_Benthochromis_melanoides",
						"I9092_1_3_"	=>	"I9092_1_3_Ctenochromis_benthicola",
						"I9093_1_4_"	=>	"I9093_1_4_Cyprichromis_leptosoma",
						"I9094_1_5_"	=>	"I9094_1_5_Gnathochromis_pfefferi",
						"I9095_1_6_"	=>	"I9095_1_6_Heterochromis_multidens",
						"I9096_1_7_"	=>	"I9096_1_7_Lamprologus_ocellatus",
						"I9097_1_8_"	=>	"I9097_1_8_Limnochromis_auritus",
						"I9098_1_9_"	=>	"I9098_1_9_Neolamprologus_christyi",
						"I9099_1_10"	=>	"I9099_1_10_Neolamprologus_modestus",
						"I9100_1_11"	=>	"I9100_1_11_Palaeolamprologus_toae",
						"I9101_1_12"	=>	"I9101_1_12_Astatoreochromis_alluaudi",
						"I9102_1_13"	=>	"I9102_1_13_Boulengerochromis_microlepis",
						"I9103_1_14"	=>	"I9103_1_14_Ctenochromis_benthicola",
						"I9104_1_15"	=>	"I9104_1_15_Cyprichromis_microlepidotus",
						"I9105_1_16"	=>	"I9105_1_16_Grammatotria_lemairii",
						"I9106_1_17"	=>	"I9106_1_17_Interochromis_loocki",
						"I9107_1_18"	=>	"I9107_1_18_Lamprologus_ornatipinnis",
						"I9108_1_19"	=>	"I9108_1_19_Limnotilapia_dardennii",
						"I9109_1_20"	=>	"I9109_1_20_Neolamprologus_cylindricus",
						"I9110_1_21"	=>	"I9110_1_21_Neolamprologus_multifasciatus",
						"I9111_1_22"	=>	"I9111_1_22_Parachromis_managuense",
						"I9112_1_23"	=>	"I9112_1_23_Altolamprologus_calvus",
						"I9113_1_24"	=>	"I9113_1_24_Aulonocranus_dewindtii",
						"I9114_1_25"	=>	"I9114_1_25_Boulengerochromis_microlepis",
						"I9115_1_26"	=>	"I9115_1_26_Ctenochromis_horei",
						"I9116_1_27"	=>	"I9116_1_27_Ectodus_descampsii",
						"I9117_1_28"	=>	"I9117_1_28_Greenwoodochromis_christyi",
						"I9118_1_29"	=>	"I9118_1_29_Julidochromis_dickfeldii",
						"I9119_1_30"	=>	"I9119_1_30_Lamprologus_teugelsi*",
						"I9120_1_31"	=>	"I9120_1_31_Lobochilotes_labiatus",
						"I9121_1_32"	=>	"I9121_1_32_Neolamprologus_daffodil",
						"I9122_1_33"	=>	"I9122_1_33_Neolamprologus_savoryi",
						"I9123_1_34"	=>	"I9123_1_34_Paracyprichromis_brieni",
						"I9124_1_35"	=>	"I9124_1_35_Altolamprologus_compressiceps",
						"I9125_1_36"	=>	"I9125_1_36_Bathybates_fasciatus",
						"I9126_1_37"	=>	"I9126_1_37_Callochromis_macrops",
						"I9127_1_38"	=>	"I9127_1_38_Cunningtonia_longiventralis",
						"I9128_1_39"	=>	"I9128_1_39_Enantiopus_melanogenys",
						"I9129_1_40"	=>	"I9129_1_40_Haplochromis_nubilus",
						"I9130_1_41"	=>	"I9130_1_41_Julidochromis_marlieri",
						"I9131_1_42"	=>	"I9131_1_42_Lepidiolamprologus_boulengeri",
						"I9132_1_43"	=>	"I9132_1_43_Microdontochromis_rotundiventralis",
						"I9133_1_44"	=>	"I9133_1_44_Neolamprologus_falcicula",
						"I9134_1_45"	=>	"I9134_1_45_Neolamprologus_sexfasciatus",
						"I9135_1_46"	=>	"I9135_1_46_Paretroplus_menarambo",
						"I9136_1_47"	=>	"I9136_1_47_Amphilophus_astorquii",
						"I9137_1_48"	=>	"I9137_1_48_Bathybates_graueri",
						"I9138_1_49"	=>	"I9138_1_49_Callochromis_pleurospilus",
						"I9139_1_50"	=>	"I9139_1_50_Cyathopharynx_furcifer",
						"I9140_1_51"	=>	"I9140_1_51_Eretmodus_cyanostictus",
						"I9141_1_52"	=>	"I9141_1_52_Haplotaxodon_microlepis",
						"I9142_1_53"	=>	"I9142_1_53_Julidochromis_ornatus",
						"I9143_1_54"	=>	"I9143_1_54_Lepidiolamprologus_elongatus",
						"I9144_1_55"	=>	"I9144_1_55_Microdontochromis_tenuidentatus",
						"I9145_1_56"	=>	"I9145_1_56_Neolamprologus_fasciatus",
						"I9146_1_57"	=>	"I9146_1_57_Neolamprologus_tetracanthus",
						"I9147_1_58"	=>	"I9147_1_58_Pelmatochromis_buttikoferi",
						"I9148_1_59"	=>	"I9148_1_59_Amphilophus_citrinellus",
						"I9149_1_60"	=>	"I9149_1_60_Bathybates_leo",
						"I9150_1_61"	=>	"I9150_1_61_Cardiopharynx_schoutedeni",
						"I9151_1_62"	=>	"I9151_1_62_Cyphotilapia_frontosa*",
						"I9152_1_63"	=>	"I9152_1_63_Etroplus_maculatus",
						"I9153_1_64"	=>	"I9153_1_64_Haplotaxodon_trifasciatus",
						"I9154_1_65"	=>	"I9154_1_65_Julidochromis_regani",
						"I9155_1_66"	=>	"I9155_1_66_Lepidiolamprologus_meeli",
						"I9156_1_67"	=>	"I9156_1_67_Neolamprologus_brevis",
						"I9157_1_68"	=>	"I9157_1_68_Neolamprologus_furcifer",
						"I9158_1_69"	=>	"I9158_1_69_Neolamprologus_tretocephalus",
						"I9159_1_70"	=>	"I9159_1_70_Pelvicachromis_pulcher",
						"I9160_1_71"	=>	"I9160_1_71_Amphilophus_zaliosus",
						"I9161_1_72"	=>	"I9161_1_72_Bathybates_minor",
						"I9162_1_73"	=>	"I9162_1_73_Chalinochromis_bifrenatus",
						"I9163_1_74"	=>	"I9163_1_74_Cyphotilapia_frontosa",
						"I9164_1_75"	=>	"I9164_1_75_Etroplus_suratensis",
						"I9165_1_76"	=>	"I9165_1_76_Hemichromis_cerasogaster",
						"I9166_1_77"	=>	"I9166_1_77_Lamprologus_callipterus",
						"I9167_1_78"	=>	"I9167_1_78_Lepidiolamprologus_nkambae",
						"I9168_1_79"	=>	"I9168_1_79_Neolamprologus_b_scheri",
						"I9169_1_80"	=>	"I9169_1_80_Neolamprologus_helianthus",
						"I9170_1_81"	=>	"I9170_1_81_Ophthalmotilapia_ventralis",
						"I9171_1_82"	=>	"I9171_1_82_Perissodus_microlepis",
						"I9172_1_83"	=>	"I9172_1_83_Asprotilapia_leptura",
						"I9173_1_84"	=>	"I9173_1_84_Benthochromis_horii",
						"I9174_1_85"	=>	"I9174_1_85_Chromidotilapia_guntheri",
						"I9175_1_86"	=>	"I9175_1_86_Cyprichromis_coloratus",
						"I9176_1_87"	=>	"I9176_1_87_Gnathochromis_permaxillaris",
						"I9177_1_88"	=>	"I9177_1_88_Hemichromis_sp",
						"I9178_1_89"	=>	"I9178_1_89_Lamprologus_lemairii",
						"I9179_1_90"	=>	"I9179_1_90_Lestradea_perspicax",
						"I9180_1_91"	=>	"I9180_1_91_Neolamprologus_caudopunctatus",
						"I9181_1_92"	=>	"I9181_1_92_Neolamprologus_leleupi",
						"I9182_1_93"	=>	"I9182_1_93_Oreochromis_tanganicae",
						"I9183_1_94"	=>	"I9183_1_94_Petrochromis_ephippium",
						"I9184_2_1_"	=>	"I9184_2_1_Petrochromis_sp",
						"I9185_2_2_"	=>	"I9185_2_2_Ptychochromis_oligacanthus",
						"I9186_2_3_"	=>	"I9186_2_3_Steatocranus_casuarius",
						"I9187_2_4_"	=>	"I9187_2_4_Triglachromis_otostigma",
						"I9188_2_5_"	=>	"I9188_2_5_Tropheus_moorii",
						"I9189_2_6_"	=>	"I9189_2_6_Tropheus_moorii",
						"I9190_2_7_"	=>	"I9190_2_7_Tropheus_sp",
						"I9191_2_8_"	=>	"I9191_2_8_Tylochromis_lateralis",
						"I9192_2_9_"	=>	"I9192_2_9_Orthochromis_malagarazensis*",
						"I9193_2_10"	=>	"I9193_2_10_Tropheus_moorii",
						"I9194_2_11"	=>	"I9194_2_11_Astatotilapia_stappersi",
						"I9195_2_12"	=>	"I9195_2_12_Petrochromis_sp",
						"I9196_2_13"	=>	"I9196_2_13_Reganochromis_calliurus",
						"I9197_2_14"	=>	"I9197_2_14_Tanganicodus_irsacae",
						"I9198_2_15"	=>	"I9198_2_15_Tropheus_brichardi",
						"I9199_2_16"	=>	"I9199_2_16_Tropheus_moorii",
						"I9200_2_17"	=>	"I9200_2_17_Tropheus_polli",
						"I9201_2_18"	=>	"I9201_2_18_Tropheus_sp",
						"I9202_2_19"	=>	"I9202_2_19_Tylochromis_sudanensis",
						"I9203_2_20"	=>	"I9203_2_20_Hemibates_stenosoma",
						"I9204_2_21"	=>	"I9204_2_21_Petrochromis_famula",
						"I9205_2_22"	=>	"I9205_2_22_Copadichromis_mloto",
						"I9206_2_23"	=>	"I9206_2_23_Petrochromis_famula",
						"I9207_2_24"	=>	"I9207_2_24_Petrochromis_sp",
						"I9208_2_25"	=>	"I9208_2_25_Sargochromis_mellandi*",
						"I9209_2_26"	=>	"I9209_2_26_Telmatochromis_dhonti",
						"I9210_2_27"	=>	"I9210_2_27_Tropheus_brichardi",
						"I9211_2_28"	=>	"I9211_2_28_Tropheus_moorii*",
						"I9212_2_29"	=>	"I9212_2_29_Tropheus_polli",
						"I9213_2_30"	=>	"I9213_2_30_Tropheus_sp",
						"I9214_2_31"	=>	"I9214_2_31_Variabilichromis_moorii",
						"I9215_2_32"	=>	"I9215_2_32_Hemibates_stenosoma",
						"I9216_2_33"	=>	"I9216_2_33_Eretmodus_marksmithi",
						"I9217_2_34"	=>	"I9217_2_34_Lethrinops_marginatus",
						"I9218_2_35"	=>	"I9218_2_35_Petrochromis_fasciolatus",
						"I9219_2_36"	=>	"I9219_2_36_Petrochromis_sp",
						"I9220_2_37"	=>	"I9220_2_37_Sarotherodon_galilaeus",
						"I9221_2_38"	=>	"I9221_2_38_Telmatochromis_temporalis",
						"I9222_2_39"	=>	"I9222_2_39_Tropheus_brichardi",
						"I9223_2_40"	=>	"I9223_2_40_Tropheus_moorii",
						"I9224_2_41"	=>	"I9224_2_41_Tropheus_polli",
						"I9225_2_42"	=>	"I9225_2_42_Tropheus_sp",
						"I9226_2_43"	=>	"I9226_2_43_Xenochromis_hecqui",
						"I9227_2_44"	=>	"I9227_2_44_Tylochromis_polylepis",
						"I9228_2_45"	=>	"I9228_2_45_Tanganicodus_irsacae",
						"I9229_2_46"	=>	"I9229_2_46_Astatotilapia_calliptera",
						"I9230_2_47"	=>	"I9230_2_47_Petrochromis_horii",
						"I9231_2_48"	=>	"I9231_2_48_Plecodus_sp",
						"I9232_2_49"	=>	"I9232_2_49_Simochromis_babaulti",
						"I9233_2_50"	=>	"I9233_2_50_Telmatochromis_vittatus",
						"I9234_2_51"	=>	"I9234_2_51_Tropheus_duboisi*",
						"I9235_2_52"	=>	"I9235_2_52_Tropheus_moorii",
						"I9236_2_53"	=>	"I9236_2_53_Tropheus_sp",
						"I9237_2_54"	=>	"I9237_2_54_Tropheus_sp",
						"I9238_2_55"	=>	"I9238_2_55_Xenotilapia_caudafasciata",
						"I9239_2_56"	=>	"I9239_2_56_Pseudocrenilabrus_philander",
						"I9240_2_57"	=>	"I9240_2_57_Spathodus_marlieri",
						"I9241_2_58"	=>	"I9241_2_58_Melanochromis_auratus",
						"I9242_2_59"	=>	"I9242_2_59_Petrochromis_orthognathus",
						"I9243_2_60"	=>	"I9243_2_60_Pseudocrenilabrus_nicholsi",
						"I9244_2_61"	=>	"I9244_2_61_Simochromis_diagramma",
						"I9245_2_62"	=>	"I9245_2_62_Telotrematocara_macrostoma*",
						"I9246_2_63"	=>	"I9246_2_63_Tropheus_moorii",
						"I9247_2_64"	=>	"I9247_2_64_Tropheus_moorii",
						"I9248_2_65"	=>	"I9248_2_65_Tropheus_sp",
						"I9249_2_66"	=>	"I9249_2_66_Tropheus_sp",
						"I9250_2_67"	=>	"I9250_2_67_Xenotilapia_flavipinnis",
						"I9251_2_68"	=>	"I9251_2_68_Tropheus_duboisi",
						"I9252_2_69"	=>	"I9252_2_69_Cynotilapia_afra",
						"I9253_2_70"	=>	"I9253_2_70_Haplochromis_nyereri",
						"I9254_2_71"	=>	"I9254_2_71_Petrochromis_polyodon",
						"I9255_2_72"	=>	"I9255_2_72_Pseudosimochromis_curvifrons",
						"I9256_2_73"	=>	"I9256_2_73_Simochromis_marginatus",
						"I9257_2_74"	=>	"I9257_2_74_Tilapia_nyongana",
						"I9258_2_75"	=>	"I9258_2_75_Tropheus_moorii",
						"I9259_2_76"	=>	"I9259_2_76_Tropheus_moorii",
						"I9260_2_77"	=>	"I9260_2_77_Tropheus_sp",
						"I9261_2_78"	=>	"I9261_2_78_Tropheus_sp",
						"I9262_2_79"	=>	"I9262_2_79_Xenotilapia_spiloptera",
						"I9263_2_80"	=>	"I9263_2_80_Tropheus_moorii",
						"I9264_2_81"	=>	"I9264_2_81_Copadichromis_borleyi",
						"I9265_2_82"	=>	"I9265_2_82_Astatotilapia_burtoni",
						"I9266_2_83"	=>	"I9266_2_83_Petrochromis_polyodon",
						"I9267_2_84"	=>	"I9267_2_84_Ptychochromis_grandidieri",
						"I9268_2_85"	=>	"I9268_2_85_Spathodus_erytrhodon",
						"I9269_2_86"	=>	"I9269_2_86_Tilapia_rendalli",
						"I9270_2_87"	=>	"I9270_2_87_Tropheus_moorii",
						"I9271_2_88"	=>	"I9271_2_88_Tropheus_moorii",
						"I9272_2_89"	=>	"I9272_2_89_Tropheus_sp*",
						"I9273_2_90"	=>	"I9273_2_90_Tropheus_sp",
						"I9274_2_91"	=>	"I9274_2_91_Orthochromis_uvinzae",
						"I9275_2_92"	=>	"I9275_2_92_Tropheus_moorii"
						);
=cut

#=pod

# new taxa:
# 6 species have been renamed and marked with !:
# I9119_1_30_Lamprologus_teugelsi #rename to Tropheus duboisi
# I9234_2_51_Tropheus_duboisi #rename to Petrochromis famula
# I9192_2_9_Orthochromis_malagarazensis #might be a Sargochromis
# I9208_2_25_Sargochromis_mellandi #rename to Eretmodus cyanostictus
# I9211_2_28_Tropheus_moorii #rename to Xenotilapia flavipinnis
# I9151_1_62_Cyphotilapia_frontosa #rename to Bathybates fasciatus
# 8 species have been removed:
# I9149_1_60_Bathybates_leo #remove based on genetic distance of 0
# I9121_1_32_Neolamprologus_daffodil #remove
# I9272_2_89_Tropheus_sp #remove based on genetic dist of 0
# I9269_2_86_Tilapia_rendalli #remove
# I9246_2_63_Tropheus_moorii #remove
# I9245_2_62_Telotrematocara_macrostoma #remove based on genetic distance of 0
# I9140_1_51_Eretmodus_cyanostictus #remove
# I9170_1_81_Ophthalmotilapia_ventralis # remove because it has no data

# Genomes have been added

my %id_to_species = (	"I11181_146"	=>	"I11181_14624_Tilapia_sparrmanii",
						"I11182_148"	=>	"I11182_14833_Steatocranus_irvinae",
						"I11183_148"	=>	"I11183_14834_Paratilapia_polleni",
						"I11184_148"	=>	"I11184_14836_Tropheus_moorii_Mpimbwe",
						"I11185_148"	=>	"I11185_14837_Tropheus_moorii_Kapampa",
						"I11186_148"	=>	"I11186_14839_Tropheus_sp_red_belly",
						"I11187_148"	=>	"I11187_14840_Heterotilapia_buttkoferi",
						"I11188_148"	=>	"I11188_14841_Tropheus_lunatus_Yungu",
						"I11189_148"	=>	"I11189_14842_Tropheus_moorii_red_moba",
						"I11190_148"	=>	"I11190_14843_Tropheus_brichardi_NW",
						"I11191_148"	=>	"I11191_14844_Tropheus_brichardi_kavalla",
						"I11192_148"	=>	"I11192_14845_Tropheus_brichardi_Mtoto",
						"I11193_148"	=>	"I11193_14846_Tropheus_annectens_NW",
						"I11194_148"	=>	"I11194_14847_Tropheus_annectens_CW",
						"I11195_148"	=>	"I11195_14848_Tropheus_annectens_SW",
						"I11196_148"	=>	"I11196_14849_Tropheus_maculatus",
						"I11197_148"	=>	"I11197_14850_Tropheus_moorii_Mpimbwe",
						"I11198_148"	=>	"I11198_14851_Tropheus_lunatus_Malagarazi",
						"I11199_148"	=>	"I11199_14852_Tropheus_lunatus_Karamba",
						"I9090_1_1_"	=>	"I9090_1_1_Astatoreochromis_alluaudi",
						"I9091_1_2_"	=>	"I9091_1_2_Benthochromis_melanoides",
						"I9092_1_3_"	=>	"I9092_1_3_Ctenochromis_benthicola",
						"I9093_1_4_"	=>	"I9093_1_4_Cyprichromis_leptosoma",
						"I9094_1_5_"	=>	"I9094_1_5_Gnathochromis_pfefferi",
						"I9095_1_6_"	=>	"I9095_1_6_Heterochromis_multidens",
						"I9096_1_7_"	=>	"I9096_1_7_Lamprologus_ocellatus",
						"I9097_1_8_"	=>	"I9097_1_8_Limnochromis_auritus",
						"I9098_1_9_"	=>	"I9098_1_9_Neolamprologus_christyi",
						"I9099_1_10"	=>	"I9099_1_10_Neolamprologus_modestus",
						"I9100_1_11"	=>	"I9100_1_11_Palaeolamprologus_toae",
						"I9101_1_12"	=>	"I9101_1_12_Astatoreochromis_alluaudi",
						"I9102_1_13"	=>	"I9102_1_13_Boulengerochromis_microlepis",
						"I9103_1_14"	=>	"I9103_1_14_Ctenochromis_benthicola",
						"I9104_1_15"	=>	"I9104_1_15_Cyprichromis_microlepidotus",
						"I9105_1_16"	=>	"I9105_1_16_Grammatotria_lemairii",
						"I9106_1_17"	=>	"I9106_1_17_Interochromis_loocki",
						"I9107_1_18"	=>	"I9107_1_18_Lamprologus_ornatipinnis",
						"I9108_1_19"	=>	"I9108_1_19_Limnotilapia_dardennii",
						"I9109_1_20"	=>	"I9109_1_20_Neolamprologus_cylindricus",
						"I9110_1_21"	=>	"I9110_1_21_Neolamprologus_multifasciatus",
						"I9111_1_22"	=>	"I9111_1_22_Parachromis_managuense",
						"I9112_1_23"	=>	"I9112_1_23_Altolamprologus_calvus",
						"I9113_1_24"	=>	"I9113_1_24_Aulonocranus_dewindtii",
						"I9114_1_25"	=>	"I9114_1_25_Boulengerochromis_microlepis",
						"I9115_1_26"	=>	"I9115_1_26_Ctenochromis_horei",
						"I9116_1_27"	=>	"I9116_1_27_Ectodus_descampsii",
						"I9117_1_28"	=>	"I9117_1_28_Greenwoodochromis_christyi",
						"I9118_1_29"	=>	"I9118_1_29_Julidochromis_dickfeldii",
						"I9119_1_30"	=>	"I9119_1_30_Tropheus_duboisi!",
						"I9120_1_31"	=>	"I9120_1_31_Lobochilotes_labiatus",
						#"I9121_1_32"	=>	"I9121_1_32_Neolamprologus_daffodil",
						"I9122_1_33"	=>	"I9122_1_33_Neolamprologus_savoryi",
						"I9123_1_34"	=>	"I9123_1_34_Paracyprichromis_brieni",
						"I9124_1_35"	=>	"I9124_1_35_Altolamprologus_compressiceps",
						"I9125_1_36"	=>	"I9125_1_36_Bathybates_fasciatus",
						"I9126_1_37"	=>	"I9126_1_37_Callochromis_macrops",
						"I9127_1_38"	=>	"I9127_1_38_Cunningtonia_longiventralis",
						"I9128_1_39"	=>	"I9128_1_39_Enantiopus_melanogenys",
						"I9129_1_40"	=>	"I9129_1_40_Haplochromis_nubilus",
						"I9130_1_41"	=>	"I9130_1_41_Julidochromis_marlieri",
						"I9131_1_42"	=>	"I9131_1_42_Lepidiolamprologus_boulengeri",
						"I9132_1_43"	=>	"I9132_1_43_Microdontochromis_rotundiventralis",
						"I9133_1_44"	=>	"I9133_1_44_Neolamprologus_falcicula",
						"I9134_1_45"	=>	"I9134_1_45_Neolamprologus_sexfasciatus",
						"I9135_1_46"	=>	"I9135_1_46_Paretroplus_menarambo",
						"I9136_1_47"	=>	"I9136_1_47_Amphilophus_astorquii",
						"I9137_1_48"	=>	"I9137_1_48_Bathybates_graueri",
						"I9138_1_49"	=>	"I9138_1_49_Callochromis_pleurospilus",
						"I9139_1_50"	=>	"I9139_1_50_Cyathopharynx_furcifer",
						#"I9140_1_51"	=>	"I9140_1_51_Eretmodus_cyanostictus",
						"I9141_1_52"	=>	"I9141_1_52_Haplotaxodon_microlepis",
						"I9142_1_53"	=>	"I9142_1_53_Julidochromis_ornatus",
						"I9143_1_54"	=>	"I9143_1_54_Lepidiolamprologus_elongatus",
						"I9144_1_55"	=>	"I9144_1_55_Microdontochromis_tenuidentatus",
						"I9145_1_56"	=>	"I9145_1_56_Neolamprologus_fasciatus",
						"I9146_1_57"	=>	"I9146_1_57_Neolamprologus_tetracanthus",
						"I9147_1_58"	=>	"I9147_1_58_Pelmatochromis_buttikoferi",
						"I9148_1_59"	=>	"I9148_1_59_Amphilophus_citrinellus",
						#"I9149_1_60"	=>	"I9149_1_60_Bathybates_leo",
						"I9150_1_61"	=>	"I9150_1_61_Cardiopharynx_schoutedeni",
						"I9151_1_62"	=>	"I9151_1_62_Bathybates_fasciatus!",
						"9151_1_62"		=>	"I9151_1_62_Bathybates_fasciatus!",
						"I9152_1_63"	=>	"I9152_1_63_Etroplus_maculatus",
						"I9153_1_64"	=>	"I9153_1_64_Haplotaxodon_trifasciatus",
						"I9154_1_65"	=>	"I9154_1_65_Julidochromis_regani",
						"I9155_1_66"	=>	"I9155_1_66_Lepidiolamprologus_meeli",
						"I9156_1_67"	=>	"I9156_1_67_Neolamprologus_brevis",
						"I9157_1_68"	=>	"I9157_1_68_Neolamprologus_furcifer",
						"I9158_1_69"	=>	"I9158_1_69_Neolamprologus_tretocephalus",
						"I9159_1_70"	=>	"I9159_1_70_Pelvicachromis_pulcher",
						"I9160_1_71"	=>	"I9160_1_71_Amphilophus_zaliosus",
						"I9161_1_72"	=>	"I9161_1_72_Bathybates_minor",
						"I9162_1_73"	=>	"I9162_1_73_Chalinochromis_bifrenatus",
						"I9163_1_74"	=>	"I9163_1_74_Cyphotilapia_frontosa",
						"I9164_1_75"	=>	"I9164_1_75_Etroplus_suratensis",
						"I9165_1_76"	=>	"I9165_1_76_Hemichromis_cerasogaster",
						"I9166_1_77"	=>	"I9166_1_77_Lamprologus_callipterus",
						"I9167_1_78"	=>	"I9167_1_78_Lepidiolamprologus_nkambae",
						"I9168_1_79"	=>	"I9168_1_79_Neolamprologus_b_scheri",
						"I9169_1_80"	=>	"I9169_1_80_Neolamprologus_helianthus",
						#"I9170_1_81"	=>	"I9170_1_81_Ophthalmotilapia_ventralis",
						"I9171_1_82"	=>	"I9171_1_82_Perissodus_microlepis",
						"I9172_1_83"	=>	"I9172_1_83_Asprotilapia_leptura",
						"I9173_1_84"	=>	"I9173_1_84_Benthochromis_horii",
						"I9174_1_85"	=>	"I9174_1_85_Chromidotilapia_guntheri",
						"I9175_1_86"	=>	"I9175_1_86_Cyprichromis_coloratus",
						"I9176_1_87"	=>	"I9176_1_87_Gnathochromis_permaxillaris",
						"I9177_1_88"	=>	"I9177_1_88_Hemichromis_sp",
						"I9178_1_89"	=>	"I9178_1_89_Lamprologus_lemairii",
						"I9179_1_90"	=>	"I9179_1_90_Lestradea_perspicax",
						"I9180_1_91"	=>	"I9180_1_91_Neolamprologus_caudopunctatus",
						"I9181_1_92"	=>	"I9181_1_92_Neolamprologus_leleupi",
						"I9182_1_93"	=>	"I9182_1_93_Oreochromis_tanganicae",
						"I9183_1_94"	=>	"I9183_1_94_Petrochromis_ephippium",
						"I9184_2_1_"	=>	"I9184_2_1_Petrochromis_sp",
						"I9185_2_2_"	=>	"I9185_2_2_Ptychochromis_oligacanthus",
						"I9186_2_3_"	=>	"I9186_2_3_Steatocranus_casuarius",
						"I9187_2_4_"	=>	"I9187_2_4_Triglachromis_otostigma",
						"I9188_2_5_"	=>	"I9188_2_5_Tropheus_moorii",
						"I9189_2_6_"	=>	"I9189_2_6_Tropheus_moorii",
						"I9190_2_7_"	=>	"I9190_2_7_Tropheus_sp",
						"I9191_2_8_"	=>	"I9191_2_8_Tylochromis_lateralis",
						"I9192_2_9_"	=>	"I9192_2_9_Sargochromis_mellandi!",
						"I9193_2_10"	=>	"I9193_2_10_Tropheus_moorii",
						"I9194_2_11"	=>	"I9194_2_11_Astatotilapia_stappersi",
						"I9195_2_12"	=>	"I9195_2_12_Petrochromis_sp",
						"I9196_2_13"	=>	"I9196_2_13_Reganochromis_calliurus",
						"I9197_2_14"	=>	"I9197_2_14_Tanganicodus_irsacae",
						"I9198_2_15"	=>	"I9198_2_15_Tropheus_brichardi",
						"I9199_2_16"	=>	"I9199_2_16_Tropheus_moorii",
						"I9200_2_17"	=>	"I9200_2_17_Tropheus_polli",
						"I9201_2_18"	=>	"I9201_2_18_Tropheus_sp",
						"I9202_2_19"	=>	"I9202_2_19_Tylochromis_sudanensis",
						"I9203_2_20"	=>	"I9203_2_20_Hemibates_stenosoma",
						"I9204_2_21"	=>	"I9204_2_21_Petrochromis_famula",
						"I9205_2_22"	=>	"I9205_2_22_Copadichromis_mloto",
						"I9206_2_23"	=>	"I9206_2_23_Petrochromis_famula",
						"I9207_2_24"	=>	"I9207_2_24_Petrochromis_sp",
						"I9208_2_25"	=>	"I9208_2_25_Eretmodus_cyanostictus!",
						"I9209_2_26"	=>	"I9209_2_26_Telmatochromis_dhonti",
						"I9210_2_27"	=>	"I9210_2_27_Tropheus_brichardi",
						"I9211_2_28"	=>	"I9211_2_28_Xenotilapia_flavipinnis!",
						"I9212_2_29"	=>	"I9212_2_29_Tropheus_polli",
						"I9213_2_30"	=>	"I9213_2_30_Tropheus_sp",
						"I9214_2_31"	=>	"I9214_2_31_Variabilichromis_moorii",
						"I9215_2_32"	=>	"I9215_2_32_Hemibates_stenosoma",
						"I9216_2_33"	=>	"I9216_2_33_Eretmodus_marksmithi",
						"I9217_2_34"	=>	"I9217_2_34_Lethrinops_marginatus",
						"I9218_2_35"	=>	"I9218_2_35_Petrochromis_fasciolatus",
						"I9219_2_36"	=>	"I9219_2_36_Petrochromis_sp",
						"I9220_2_37"	=>	"I9220_2_37_Sarotherodon_galilaeus",
						"I9221_2_38"	=>	"I9221_2_38_Telmatochromis_temporalis",
						"I9222_2_39"	=>	"I9222_2_39_Tropheus_brichardi",
						"I9223_2_40"	=>	"I9223_2_40_Tropheus_moorii",
						"I9224_2_41"	=>	"I9224_2_41_Tropheus_polli",
						"I9225_2_42"	=>	"I9225_2_42_Tropheus_sp",
						"I9226_2_43"	=>	"I9226_2_43_Xenochromis_hecqui",
						"I9227_2_44"	=>	"I9227_2_44_Tylochromis_polylepis",
						"I9228_2_45"	=>	"I9228_2_45_Tanganicodus_irsacae",
						"I9229_2_46"	=>	"I9229_2_46_Astatotilapia_calliptera",
						"I9230_2_47"	=>	"I9230_2_47_Petrochromis_horii",
						"I9231_2_48"	=>	"I9231_2_48_Plecodus_sp",
						"I9232_2_49"	=>	"I9232_2_49_Simochromis_babaulti",
						"I9233_2_50"	=>	"I9233_2_50_Telmatochromis_vittatus",
						"I9234_2_51"	=>	"I9234_2_51_Petrochromis_famula!",
						"I9235_2_52"	=>	"I9235_2_52_Tropheus_moorii",
						"I9236_2_53"	=>	"I9236_2_53_Tropheus_sp",
						"I9237_2_54"	=>	"I9237_2_54_Tropheus_sp",
						"I9238_2_55"	=>	"I9238_2_55_Xenotilapia_caudafasciata",
						"I9239_2_56"	=>	"I9239_2_56_Pseudocrenilabrus_philander",
						"I9240_2_57"	=>	"I9240_2_57_Spathodus_marlieri",
						"I9241_2_58"	=>	"I9241_2_58_Melanochromis_auratus",
						"I9242_2_59"	=>	"I9242_2_59_Petrochromis_orthognathus",
						"I9243_2_60"	=>	"I9243_2_60_Pseudocrenilabrus_nicholsi",
						"I9244_2_61"	=>	"I9244_2_61_Simochromis_diagramma",
						#"I9245_2_62"	=>	"I9245_2_62_Telotrematocara_macrostoma*",
						#"I9246_2_63"	=>	"I9246_2_63_Tropheus_moorii",
						"I9247_2_64"	=>	"I9247_2_64_Tropheus_moorii",
						"I9248_2_65"	=>	"I9248_2_65_Tropheus_sp",
						"I9249_2_66"	=>	"I9249_2_66_Tropheus_sp",
						"I9250_2_67"	=>	"I9250_2_67_Xenotilapia_flavipinnis",
						"I9251_2_68"	=>	"I9251_2_68_Tropheus_duboisi",
						"I9252_2_69"	=>	"I9252_2_69_Cynotilapia_afra",
						"I9253_2_70"	=>	"I9253_2_70_Haplochromis_nyereri",
						"I9254_2_71"	=>	"I9254_2_71_Petrochromis_polyodon",
						"I9255_2_72"	=>	"I9255_2_72_Pseudosimochromis_curvifrons",
						"I9256_2_73"	=>	"I9256_2_73_Simochromis_marginatus",
						"I9257_2_74"	=>	"I9257_2_74_Tilapia_nyongana",
						"I9258_2_75"	=>	"I9258_2_75_Tropheus_moorii",
						"I9259_2_76"	=>	"I9259_2_76_Tropheus_moorii",
						"I9260_2_77"	=>	"I9260_2_77_Tropheus_sp",
						"I9261_2_78"	=>	"I9261_2_78_Tropheus_sp",
						"I9262_2_79"	=>	"I9262_2_79_Xenotilapia_spiloptera",
						"I9263_2_80"	=>	"I9263_2_80_Tropheus_moorii",
						"I9264_2_81"	=>	"I9264_2_81_Copadichromis_borleyi",
						"I9265_2_82"	=>	"I9265_2_82_Astatotilapia_burtoni",
						"I9266_2_83"	=>	"I9266_2_83_Petrochromis_polyodon",
						"I9267_2_84"	=>	"I9267_2_84_Ptychochromis_grandidieri",
						"I9268_2_85"	=>	"I9268_2_85_Spathodus_erytrhodon",
						#"I9269_2_86"	=>	"I9269_2_86_Tilapia_rendalli",
						"I9270_2_87"	=>	"I9270_2_87_Tropheus_moorii",
						"I9271_2_88"	=>	"I9271_2_88_Tropheus_moorii",
						#"I9272_2_89"	=>	"I9272_2_89_Tropheus_sp*",
						"I9273_2_90"	=>	"I9273_2_90_Tropheus_sp",
						"I9274_2_91"	=>	"I9274_2_91_Orthochromis_uvinzae",
						"I9275_2_92"	=>	"I9275_2_92_Tropheus_moorii",
						"Ac_T88_LOC"	=>	"Andinoacara_coeruleopunctatus_MMalinsky",
						"Nb_T88_LOC"	=>	"Neolamprologous_brichardi_Brawand",
						"On_T88_LOC"	=>	"Oreochromis_niloticus_Brawand",
						"Ab_T88_LOC"	=>	"Astatotilapia_burtoni_Brawand",
						"Mz_T88_LOC"	=>	"Metriaclima_Zebra_Brawand",
						"Pn_T88_LOC"	=>	"Pundamilia_nyererei_Brawand",
						"Tm_T88_LOC"	=>	"Tropheus_moorii_Nakaku_SturmbauerLab",
						"Pt_T88_LOC"	=>	"Petrochromis_Trewavasae_Kekese_SturmbauerLab"
						);
#=cut
=pod

# copy of previous %hash after removal / renaming of species
# BUT contain final IDs for Tropheini and Tropheus
# WARNING! Some renamed sequences from Tropheini/Tropheus data set (suggested by Stephan) still corresponded to the "old" (wrong) species:
# ID			T37/38 (wrong)		T36 (correct)
# I9208_2_25	I9208_2_25_Sarmel	I9208_2_25_Eretmodus_cyanostictus
# I9234_2_51 	I9234_2_51_Trodub	I9234_2_51_Petrochromis_famula
# Do these samples need to be removed from T37/38? 

		
		

my %id_to_species = (	"I11181_146"	=>	"I11181_14624_Tilapia_sparrmanii",
						"I11182_148"	=>	"I11182_14833_Steatocranus_irvinae",
						"I11183_148"	=>	"I11183_14834_Paratilapia_polleni",
						"I11184_148"	=>	"I11184_14836_Trosp2_Mpimbwe1",
						"I11185_148"	=>	"I11185_14837_Tromac_Kapampa",
						"I11186_148"	=>	"I11186_14839_Tronig_redbelly",
						"I11187_148"	=>	"I11187_14840_Heterotilapia_buttkoferi",
						"I11188_148"	=>	"I11188_14841_Trolun_Yungu",
						"I11189_148"	=>	"I11189_14842_Tromoo_Moba",
						"I11190_148"	=>	"I11190_14843_Trosp3_TitchaN",
						"I11191_148"	=>	"I11191_14844_Trosp3_Kavalla",
						"I11192_148"	=>	"I11192_14845_Trosp3_Mtoto",
						"I11193_148"	=>	"I11193_14846_Troann_Kilesa",
						"I11194_148"	=>	"I11194_14847_Trosp1_Kabulu",
						"I11195_148"	=>	"I11195_14848_Trosp1_Mtoto",
						"I11196_148"	=>	"I11196_14849_Tromac_Kikoti",
						"I11197_148"	=>	"I11197_14850_Trosp2_Mpimbwe2",
						"I11198_148"	=>	"I11198_14851_Trolun_Malagarazi",
						"I11199_148"	=>	"I11199_14852_Tronig_Karamba",
						"I9090_1_1_"	=>	"I9090_1_1_Astall_1",
						"I9091_1_2_"	=>	"I9091_1_2_Benthochromis_melanoides",
						"I9092_1_3_"	=>	"I9092_1_3_Ctenochromis_benthicola",
						"I9093_1_4_"	=>	"I9093_1_4_Cyprichromis_leptosoma",
						"I9094_1_5_"	=>	"I9094_1_5_Gnapfe",
						"I9095_1_6_"	=>	"I9095_1_6_Heterochromis_multidens",
						"I9096_1_7_"	=>	"I9096_1_7_Lamprologus_ocellatus",
						"I9097_1_8_"	=>	"I9097_1_8_Limnochromis_auritus",
						"I9098_1_9_"	=>	"I9098_1_9_Neolamprologus_christyi",
						"I9099_1_10"	=>	"I9099_1_10_Neolamprologus_modestus",
						"I9100_1_11"	=>	"I9100_1_11_Palaeolamprologus_toae",
						"I9101_1_12"	=>	"I9101_1_12_Astall_2",
						"I9102_1_13"	=>	"I9102_1_13_Boulengerochromis_microlepis",
						"I9103_1_14"	=>	"I9103_1_14_Ctenochromis_benthicola",
						"I9104_1_15"	=>	"I9104_1_15_Cyprichromis_microlepidotus",
						"I9105_1_16"	=>	"I9105_1_16_Grammatotria_lemairii",
						"I9106_1_17"	=>	"I9106_1_17_Intloo",
						"I9107_1_18"	=>	"I9107_1_18_Lamprologus_ornatipinnis",
						"I9108_1_19"	=>	"I9108_1_19_Limdar",
						"I9109_1_20"	=>	"I9109_1_20_Neolamprologus_cylindricus",
						"I9110_1_21"	=>	"I9110_1_21_Neolamprologus_multifasciatus",
						"I9111_1_22"	=>	"I9111_1_22_Parachromis_managuense",
						"I9112_1_23"	=>	"I9112_1_23_Altolamprologus_calvus",
						"I9113_1_24"	=>	"I9113_1_24_Aulonocranus_dewindtii",
						"I9114_1_25"	=>	"I9114_1_25_Boulengerochromis_microlepis",
						"I9115_1_26"	=>	"I9115_1_26_Ctehor",
						"I9116_1_27"	=>	"I9116_1_27_Ectodus_descampsii",
						"I9117_1_28"	=>	"I9117_1_28_Greenwoodochromis_christyi",
						"I9118_1_29"	=>	"I9118_1_29_Julidochromis_dickfeldii",
						"I9119_1_30"	=>	"I9119_1_30_Tropheus_duboisi!",
						"I9120_1_31"	=>	"I9120_1_31_Loblab",
						#"I9121_1_32"	=>	"I9121_1_32_Neolamprologus_daffodil",
						"I9122_1_33"	=>	"I9122_1_33_Neolamprologus_savoryi",
						"I9123_1_34"	=>	"I9123_1_34_Paracyprichromis_brieni",
						"I9124_1_35"	=>	"I9124_1_35_Altolamprologus_compressiceps",
						"I9125_1_36"	=>	"I9125_1_36_Bathybates_fasciatus",
						"I9126_1_37"	=>	"I9126_1_37_Callochromis_macrops",
						"I9127_1_38"	=>	"I9127_1_38_Cunningtonia_longiventralis",
						"I9128_1_39"	=>	"I9128_1_39_Enantiopus_melanogenys",
						"I9129_1_40"	=>	"I9129_1_40_Hapnub",
						"I9130_1_41"	=>	"I9130_1_41_Julidochromis_marlieri",
						"I9131_1_42"	=>	"I9131_1_42_Lepidiolamprologus_boulengeri",
						"I9132_1_43"	=>	"I9132_1_43_Microdontochromis_rotundiventralis",
						"I9133_1_44"	=>	"I9133_1_44_Neolamprologus_falcicula",
						"I9134_1_45"	=>	"I9134_1_45_Neolamprologus_sexfasciatus",
						"I9135_1_46"	=>	"I9135_1_46_Paretroplus_menarambo",
						"I9136_1_47"	=>	"I9136_1_47_Amphilophus_astorquii",
						"I9137_1_48"	=>	"I9137_1_48_Bathybates_graueri",
						"I9138_1_49"	=>	"I9138_1_49_Callochromis_pleurospilus",
						"I9139_1_50"	=>	"I9139_1_50_Cyathopharynx_furcifer",
						#"I9140_1_51"	=>	"I9140_1_51_Eretmodus_cyanostictus",
						"I9141_1_52"	=>	"I9141_1_52_Haplotaxodon_microlepis",
						"I9142_1_53"	=>	"I9142_1_53_Julidochromis_ornatus",
						"I9143_1_54"	=>	"I9143_1_54_Lepidiolamprologus_elongatus",
						"I9144_1_55"	=>	"I9144_1_55_Microdontochromis_tenuidentatus",
						"I9145_1_56"	=>	"I9145_1_56_Neolamprologus_fasciatus",
						"I9146_1_57"	=>	"I9146_1_57_Neolamprologus_tetracanthus",
						"I9147_1_58"	=>	"I9147_1_58_Pelmatochromis_buttikoferi",
						"I9148_1_59"	=>	"I9148_1_59_Amphilophus_citrinellus",
						#"I9149_1_60"	=>	"I9149_1_60_Bathybates_leo",
						"I9150_1_61"	=>	"I9150_1_61_Cardiopharynx_schoutedeni",
						"I9151_1_62"	=>	"I9151_1_62_Bathybates_fasciatus!",
						"I9152_1_63"	=>	"I9152_1_63_Etroplus_maculatus",
						"I9153_1_64"	=>	"I9153_1_64_Haplotaxodon_trifasciatus",
						"I9154_1_65"	=>	"I9154_1_65_Julidochromis_regani",
						"I9155_1_66"	=>	"I9155_1_66_Lepidiolamprologus_meeli",
						"I9156_1_67"	=>	"I9156_1_67_Neolamprologus_brevis",
						"I9157_1_68"	=>	"I9157_1_68_Neolamprologus_furcifer",
						"I9158_1_69"	=>	"I9158_1_69_Neolamprologus_tretocephalus",
						"I9159_1_70"	=>	"I9159_1_70_Pelvicachromis_pulcher",
						"I9160_1_71"	=>	"I9160_1_71_Amphilophus_zaliosus",
						"I9161_1_72"	=>	"I9161_1_72_Bathybates_minor",
						"I9162_1_73"	=>	"I9162_1_73_Chalinochromis_bifrenatus",
						"I9163_1_74"	=>	"I9163_1_74_Cyphotilapia_frontosa",
						"I9164_1_75"	=>	"I9164_1_75_Etroplus_suratensis",
						"I9165_1_76"	=>	"I9165_1_76_Hemichromis_cerasogaster",
						"I9166_1_77"	=>	"I9166_1_77_Lamprologus_callipterus",
						"I9167_1_78"	=>	"I9167_1_78_Lepidiolamprologus_nkambae",
						"I9168_1_79"	=>	"I9168_1_79_Neolamprologus_b_scheri",
						"I9169_1_80"	=>	"I9169_1_80_Neolamprologus_helianthus",
						#"I9170_1_81"	=>	"I9170_1_81_Ophthalmotilapia_ventralis",
						"I9171_1_82"	=>	"I9171_1_82_Perissodus_microlepis",
						"I9172_1_83"	=>	"I9172_1_83_Asprotilapia_leptura",
						"I9173_1_84"	=>	"I9173_1_84_Benthochromis_horii",
						"I9174_1_85"	=>	"I9174_1_85_Chromidotilapia_guntheri",
						"I9175_1_86"	=>	"I9175_1_86_Cyprichromis_coloratus",
						"I9176_1_87"	=>	"I9176_1_87_Gnathochromis_permaxillaris",
						"I9177_1_88"	=>	"I9177_1_88_Hemichromis_sp",
						"I9178_1_89"	=>	"I9178_1_89_Lamprologus_lemairii",
						"I9179_1_90"	=>	"I9179_1_90_Lestradea_perspicax",
						"I9180_1_91"	=>	"I9180_1_91_Neolamprologus_caudopunctatus",
						"I9181_1_92"	=>	"I9181_1_92_Neolamprologus_leleupi",
						"I9182_1_93"	=>	"I9182_1_93_Oreochromis_tanganicae",
						"I9183_1_94"	=>	"I9183_1_94_Peteph",
						"I9184_2_1_"	=>	"I9184_2_1_Petmac",
						"I9185_2_2_"	=>	"I9185_2_2_Ptychochromis_oligacanthus",
						"I9186_2_3_"	=>	"I9186_2_3_Steatocranus_casuarius",
						"I9187_2_4_"	=>	"I9187_2_4_Triglachromis_otostigma",
						"I9188_2_5_"	=>	"I9188_2_5_Tromoo_Kachese",
						"I9189_2_6_"	=>	"I9189_2_6_TrospX_Ubwari",
						"I9190_2_7_"	=>	"I9190_2_7_Troann_Kavala",
						"I9191_2_8_"	=>	"I9191_2_8_Tylochromis_lateralis",
						"I9192_2_9_"	=>	"I9192_2_9_Sargochromis_mellandi!",
						"I9193_2_10"	=>	"I9193_2_10_Tromoo_Kasanga",
						"I9194_2_11"	=>	"I9194_2_11_Hapsta",
						"I9195_2_12"	=>	"I9195_2_12_Petsp3",
						"I9196_2_13"	=>	"I9196_2_13_Reganochromis_calliurus",
						"I9197_2_14"	=>	"I9197_2_14_Tanganicodus_irsacae",
						"I9198_2_15"	=>	"I9198_2_15_Trobri_Mukuruka",
						"I9199_2_16"	=>	"I9199_2_16_Tromoo_KatotoS",
						"I9200_2_17"	=>	"I9200_2_17_Troann_IkolaS",
						"I9201_2_18"	=>	"I9201_2_18_Tronig_MahaleN",
						"I9202_2_19"	=>	"I9202_2_19_Tylochromis_sudanensis",
						"I9203_2_20"	=>	"I9203_2_20_Hemibates_stenosoma",
						"I9204_2_21"	=>	"I9204_2_21_Petfam_2",
						"I9205_2_22"	=>	"I9205_2_22_Copmlo",
						"I9206_2_23"	=>	"I9206_2_23_Petfam_1",
						"I9207_2_24"	=>	"I9207_2_24_Petsp2",
						"I9208_2_25"	=>	"I9208_2_25_Eretmodus_cyanostictus!",
						"I9209_2_26"	=>	"I9209_2_26_Telmatochromis_dhonti",
						"I9210_2_27"	=>	"I9210_2_27_Trosp4_Nkondwe",
						"I9211_2_28"	=>	"I9211_2_28_Tromoo_Linangu",
						"I9212_2_29"	=>	"I9212_2_29_Troann_Mahale",
						"I9213_2_30"	=>	"I9213_2_30_Tronig_MabilibiliN",
						"I9214_2_31"	=>	"I9214_2_31_Variabilichromis_moorii",
						"I9215_2_32"	=>	"I9215_2_32_Hemibates_stenosoma",
						"I9216_2_33"	=>	"I9216_2_33_Eretmodus_marksmithi",
						"I9217_2_34"	=>	"I9217_2_34_Letmar",
						"I9218_2_35"	=>	"I9218_2_35_Petfas",
						"I9219_2_36"	=>	"I9219_2_36_Petsp1",
						"I9220_2_37"	=>	"I9220_2_37_Sarotherodon_galilaeus",
						"I9221_2_38"	=>	"I9221_2_38_Telmatochromis_temporalis",
						"I9222_2_39"	=>	"I9222_2_39_Trosp4_Ulwile",
						"I9223_2_40"	=>	"I9223_2_40_Tromoo_Livua",
						"I9224_2_41"	=>	"I9224_2_41_Troann_IsongaS",
						"I9225_2_42"	=>	"I9225_2_42_Tromoo_Namansi",
						"I9226_2_43"	=>	"I9226_2_43_Xenochromis_hecqui",
						"I9227_2_44"	=>	"I9227_2_44_Tylochromis_polylepis",
						"I9228_2_45"	=>	"I9228_2_45_Tanganicodus_irsacae",
						"I9229_2_46"	=>	"I9229_2_46_Astcal",
						"I9230_2_47"	=>	"I9230_2_47_Pethor",
						"I9231_2_48"	=>	"I9231_2_48_Plecodus_sp",
						"I9232_2_49"	=>	"I9232_2_49_Psebab",
						"I9233_2_50"	=>	"I9233_2_50_Telmatochromis_vittatus",
						"I9234_2_51"	=>	"I9234_2_51_Petrochromis_famula!",
						"I9235_2_52"	=>	"I9235_2_52_Tromoo_Mbita",
						"I9236_2_53"	=>	"I9236_2_53_Tronig_Kagongo",
						"I9237_2_54"	=>	"I9237_2_54_Tronig_IsongaS",
						"I9238_2_55"	=>	"I9238_2_55_Xenotilapia_caudafasciata",
						"I9239_2_56"	=>	"I9239_2_56_Psephi",
						"I9240_2_57"	=>	"I9240_2_57_Spathodus_marlieri",
						"I9241_2_58"	=>	"I9241_2_58_Melaur",
						"I9242_2_59"	=>	"I9242_2_59_Petort",
						"I9243_2_60"	=>	"I9243_2_60_Psenic",
						"I9244_2_61"	=>	"I9244_2_61_Simdia",
						#"I9245_2_62"	=>	"I9245_2_62_Telotrematocara_macrostoma*",
						#"I9246_2_63"	=>	"I9246_2_63_Tronig_Bemba",
						"I9247_2_64"	=>	"I9247_2_64_Tromoo_Moliro",
						"I9248_2_65"	=>	"I9248_2_65_Tronig_Kalundu",
						"I9249_2_66"	=>	"I9249_2_66_Trobri_Ujiji",
						"I9250_2_67"	=>	"I9250_2_67_Xenotilapia_flavipinnis",
						"I9251_2_68"	=>	"I9251_2_68_Trodub_Halembe",
						"I9252_2_69"	=>	"I9252_2_69_Cynafr",
						"I9253_2_70"	=>	"I9253_2_70_Hapnye",
						"I9254_2_71"	=>	"I9254_2_71_Petpol",
						"I9255_2_72"	=>	"I9255_2_72_Psecur",
						"I9256_2_73"	=>	"I9256_2_73_Psemar",
						"I9257_2_74"	=>	"I9257_2_74_Tilapia_nyongana",
						"I9258_2_75"	=>	"I9258_2_75_Tromoo_Chilanga",
						"I9259_2_76"	=>	"I9259_2_76_Tromoo_Mtosi",
						"I9260_2_77"	=>	"I9260_2_77_Tronig_Magara",
						"I9261_2_78"	=>	"I9261_2_78_Tromoo_Wampembe",
						"I9262_2_79"	=>	"I9262_2_79_Xenotilapia_spiloptera",
						"I9263_2_80"	=>	"I9263_2_80_Tromoo_Ilangi",
						"I9264_2_81"	=>	"I9264_2_81_Copbor",
						"I9265_2_82"	=>	"I9265_2_82_Hapbur",
						"I9266_2_83"	=>	"I9266_2_83_Petpol_1",
						"I9267_2_84"	=>	"I9267_2_84_Ptychochromis_grandidieri",
						"I9268_2_85"	=>	"I9268_2_85_Spathodus_erytrhodon",
						#"I9269_2_86"	=>	"I9269_2_86_Tilapia_rendalli",
						"I9270_2_87"	=>	"I9270_2_87_Tromoo_Chimba",
						"I9271_2_88"	=>	"I9271_2_88_Tromac_Murago",
						#"I9272_2_89"	=>	"I9272_2_89_Tronig_Kekese*",
						"I9273_2_90"	=>	"I9273_2_90_Tronig_Kekese",
						"I9274_2_91"	=>	"I9274_2_91_Orthochromis_uvinzae",
						"I9275_2_92"	=>	"I9275_2_92_Tromoo_Chaitika",
						"Ac_T88_LOC"	=>	"Andinoacara_coeruleopunctatus_MMalinsky",
						"Nb_T88_LOC"	=>	"Neolamprologous_brichardi_Brawand",
						"On_T88_LOC"	=>	"Oreochromis_niloticus_Brawand",
						"Ab_T88_LOC"	=>	"Astatotilapia_burtoni_Brawand",
						"Mz_T88_LOC"	=>	"Metriaclima_Zebra_Brawand",
						"Pn_T88_LOC"	=>	"Pundamilia_nyererei_Brawand",
						"Tm_T88_LOC"	=>	"Tropheus_moorii_Nakaku_SturmbauerLab",
						"Pt_T88_LOC"	=>	"Petrochromis_Trewavasae_Kekese_SturmbauerLab"
						);
=cut

						
open (IN, "<", $infile) or die "Cannot open file $infile\n";

my $tree;
my $line_count = 0;

while ( my $line =<IN> ) {
	chomp $line;
	$line_count++;
	$tree = $line;
	
	
	foreach my $key ( keys %id_to_species ) {
		
		$tree =~ s/$key/$id_to_species{$key}/g;
	 
	 	print STDERR "$key substituted by $id_to_species{$key}\n";
	
	}
	 
}
	 

# print tree

print "$tree\n";	 
	 
	 
	 
print STDERR "\n$line_count trees found and replaced\n";