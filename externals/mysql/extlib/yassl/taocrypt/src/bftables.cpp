/*
   Copyright (C) 2000-2007 MySQL AB

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; version 2 of the License.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; see the file COPYING. If not, write to the
   Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
   MA  02110-1301  USA.
*/

/* based on Wei Dai's bfinit.cpp from CryptoPP */

#include "runtime.hpp"
#include "blowfish.hpp"


namespace TaoCrypt {

const word32 Blowfish::p_init_[Blowfish::ROUNDS+2] =
{
  608135816U, 2242054355U,  320440878U,   57701188U,
 2752067618U,  698298832U,  137296536U, 3964562569U,
 1160258022U,  953160567U, 3193202383U,  887688300U,
 3232508343U, 3380367581U, 1065670069U, 3041331479U,
 2450970073U, 2306472731U
} ;


const word32 Blowfish::s_init_[4*256] = {
 3509652390U, 2564797868U,  805139163U, 3491422135U,
 3101798381U, 1780907670U, 3128725573U, 4046225305U,
  614570311U, 3012652279U,  134345442U, 2240740374U,
 1667834072U, 1901547113U, 2757295779U, 4103290238U,
  227898511U, 1921955416U, 1904987480U, 2182433518U,
 2069144605U, 3260701109U, 2620446009U,  720527379U,
 3318853667U,  677414384U, 3393288472U, 3101374703U,
 2390351024U, 1614419982U, 1822297739U, 2954791486U,
 3608508353U, 3174124327U, 2024746970U, 1432378464U,
 3864339955U, 2857741204U, 1464375394U, 1676153920U,
 1439316330U,  715854006U, 3033291828U,  289532110U,
 2706671279U, 2087905683U, 3018724369U, 1668267050U,
  732546397U, 1947742710U, 3462151702U, 2609353502U,
 2950085171U, 1814351708U, 2050118529U,  680887927U,
  999245976U, 1800124847U, 3300911131U, 1713906067U,
 1641548236U, 4213287313U, 1216130144U, 1575780402U,
 4018429277U, 3917837745U, 3693486850U, 3949271944U,
  596196993U, 3549867205U,  258830323U, 2213823033U,
  772490370U, 2760122372U, 1774776394U, 2652871518U,
  566650946U, 4142492826U, 1728879713U, 2882767088U,
 1783734482U, 3629395816U, 2517608232U, 2874225571U,
 1861159788U,  326777828U, 3124490320U, 2130389656U,
 2716951837U,  967770486U, 1724537150U, 2185432712U,
 2364442137U, 1164943284U, 2105845187U,  998989502U,
 3765401048U, 2244026483U, 1075463327U, 1455516326U,
 1322494562U,  910128902U,  469688178U, 1117454909U,
  936433444U, 3490320968U, 3675253459U, 1240580251U,
  122909385U, 2157517691U,  634681816U, 4142456567U,
 3825094682U, 3061402683U, 2540495037U,   79693498U,
 3249098678U, 1084186820U, 1583128258U,  426386531U,
 1761308591U, 1047286709U,  322548459U,  995290223U,
 1845252383U, 2603652396U, 3431023940U, 2942221577U,
 3202600964U, 3727903485U, 1712269319U,  422464435U,
 3234572375U, 1170764815U, 3523960633U, 3117677531U,
 1434042557U,  442511882U, 3600875718U, 1076654713U,
 1738483198U, 4213154764U, 2393238008U, 3677496056U,
 1014306527U, 4251020053U,  793779912U, 2902807211U,
  842905082U, 4246964064U, 1395751752U, 1040244610U,
 2656851899U, 3396308128U,  445077038U, 3742853595U,
 3577915638U,  679411651U, 2892444358U, 2354009459U,
 1767581616U, 3150600392U, 3791627101U, 3102740896U,
  284835224U, 4246832056U, 1258075500U,  768725851U,
 2589189241U, 3069724005U, 3532540348U, 1274779536U,
 3789419226U, 2764799539U, 1660621633U, 3471099624U,
 4011903706U,  913787905U, 3497959166U,  737222580U,
 2514213453U, 2928710040U, 3937242737U, 1804850592U,
 3499020752U, 2949064160U, 2386320175U, 2390070455U,
 2415321851U, 4061277028U, 2290661394U, 2416832540U,
 1336762016U, 1754252060U, 3520065937U, 3014181293U,
  791618072U, 3188594551U, 3933548030U, 2332172193U,
 3852520463U, 3043980520U,  413987798U, 3465142937U,
 3030929376U, 4245938359U, 2093235073U, 3534596313U,
  375366246U, 2157278981U, 2479649556U,  555357303U,
 3870105701U, 2008414854U, 3344188149U, 4221384143U,
 3956125452U, 2067696032U, 3594591187U, 2921233993U,
	2428461U,  544322398U,  577241275U, 1471733935U,
  610547355U, 4027169054U, 1432588573U, 1507829418U,
 2025931657U, 3646575487U,  545086370U,   48609733U,
 2200306550U, 1653985193U,  298326376U, 1316178497U,
 3007786442U, 2064951626U,  458293330U, 2589141269U,
 3591329599U, 3164325604U,  727753846U, 2179363840U,
  146436021U, 1461446943U, 4069977195U,  705550613U,
 3059967265U, 3887724982U, 4281599278U, 3313849956U,
 1404054877U, 2845806497U,  146425753U, 1854211946U,

 1266315497U, 3048417604U, 3681880366U, 3289982499U,
 2909710000U, 1235738493U, 2632868024U, 2414719590U,
 3970600049U, 1771706367U, 1449415276U, 3266420449U,
  422970021U, 1963543593U, 2690192192U, 3826793022U,
 1062508698U, 1531092325U, 1804592342U, 2583117782U,
 2714934279U, 4024971509U, 1294809318U, 4028980673U,
 1289560198U, 2221992742U, 1669523910U,   35572830U,
  157838143U, 1052438473U, 1016535060U, 1802137761U,
 1753167236U, 1386275462U, 3080475397U, 2857371447U,
 1040679964U, 2145300060U, 2390574316U, 1461121720U,
 2956646967U, 4031777805U, 4028374788U,   33600511U,
 2920084762U, 1018524850U,  629373528U, 3691585981U,
 3515945977U, 2091462646U, 2486323059U,  586499841U,
  988145025U,  935516892U, 3367335476U, 2599673255U,
 2839830854U,  265290510U, 3972581182U, 2759138881U,
 3795373465U, 1005194799U,  847297441U,  406762289U,
 1314163512U, 1332590856U, 1866599683U, 4127851711U,
  750260880U,  613907577U, 1450815602U, 3165620655U,
 3734664991U, 3650291728U, 3012275730U, 3704569646U,
 1427272223U,  778793252U, 1343938022U, 2676280711U,
 2052605720U, 1946737175U, 3164576444U, 3914038668U,
 3967478842U, 3682934266U, 1661551462U, 3294938066U,
 4011595847U,  840292616U, 3712170807U,  616741398U,
  312560963U,  711312465U, 1351876610U,  322626781U,
 1910503582U,  271666773U, 2175563734U, 1594956187U,
   70604529U, 3617834859U, 1007753275U, 1495573769U,
 4069517037U, 2549218298U, 2663038764U,  504708206U,
 2263041392U, 3941167025U, 2249088522U, 1514023603U,
 1998579484U, 1312622330U,  694541497U, 2582060303U,
 2151582166U, 1382467621U,  776784248U, 2618340202U,
 3323268794U, 2497899128U, 2784771155U,  503983604U,
 4076293799U,  907881277U,  423175695U,  432175456U,
 1378068232U, 4145222326U, 3954048622U, 3938656102U,
 3820766613U, 2793130115U, 2977904593U,   26017576U,
 3274890735U, 3194772133U, 1700274565U, 1756076034U,
 4006520079U, 3677328699U,  720338349U, 1533947780U,
  354530856U,  688349552U, 3973924725U, 1637815568U,
  332179504U, 3949051286U,   53804574U, 2852348879U,
 3044236432U, 1282449977U, 3583942155U, 3416972820U,
 4006381244U, 1617046695U, 2628476075U, 3002303598U,
 1686838959U,  431878346U, 2686675385U, 1700445008U,
 1080580658U, 1009431731U,  832498133U, 3223435511U,
 2605976345U, 2271191193U, 2516031870U, 1648197032U,
 4164389018U, 2548247927U,  300782431U,  375919233U,
  238389289U, 3353747414U, 2531188641U, 2019080857U,
 1475708069U,  455242339U, 2609103871U,  448939670U,
 3451063019U, 1395535956U, 2413381860U, 1841049896U,
 1491858159U,  885456874U, 4264095073U, 4001119347U,
 1565136089U, 3898914787U, 1108368660U,  540939232U,
 1173283510U, 2745871338U, 3681308437U, 4207628240U,
 3343053890U, 4016749493U, 1699691293U, 1103962373U,
 3625875870U, 2256883143U, 3830138730U, 1031889488U,
 3479347698U, 1535977030U, 4236805024U, 3251091107U,
 2132092099U, 1774941330U, 1199868427U, 1452454533U,
  157007616U, 2904115357U,  342012276U,  595725824U,
 1480756522U,  206960106U,  497939518U,  591360097U,
  863170706U, 2375253569U, 3596610801U, 1814182875U,
 2094937945U, 3421402208U, 1082520231U, 3463918190U,
 2785509508U,  435703966U, 3908032597U, 1641649973U,
 2842273706U, 3305899714U, 1510255612U, 2148256476U,
 2655287854U, 3276092548U, 4258621189U,  236887753U,
 3681803219U,  274041037U, 1734335097U, 3815195456U,
 3317970021U, 1899903192U, 1026095262U, 4050517792U,
  356393447U, 2410691914U, 3873677099U, 3682840055U,

 3913112168U, 2491498743U, 4132185628U, 2489919796U,
 1091903735U, 1979897079U, 3170134830U, 3567386728U,
 3557303409U,  857797738U, 1136121015U, 1342202287U,
  507115054U, 2535736646U,  337727348U, 3213592640U,
 1301675037U, 2528481711U, 1895095763U, 1721773893U,
 3216771564U,   62756741U, 2142006736U,  835421444U,
 2531993523U, 1442658625U, 3659876326U, 2882144922U,
  676362277U, 1392781812U,  170690266U, 3921047035U,
 1759253602U, 3611846912U, 1745797284U,  664899054U,
 1329594018U, 3901205900U, 3045908486U, 2062866102U,
 2865634940U, 3543621612U, 3464012697U, 1080764994U,
  553557557U, 3656615353U, 3996768171U,  991055499U,
  499776247U, 1265440854U,  648242737U, 3940784050U,
  980351604U, 3713745714U, 1749149687U, 3396870395U,
 4211799374U, 3640570775U, 1161844396U, 3125318951U,
 1431517754U,  545492359U, 4268468663U, 3499529547U,
 1437099964U, 2702547544U, 3433638243U, 2581715763U,
 2787789398U, 1060185593U, 1593081372U, 2418618748U,
 4260947970U,   69676912U, 2159744348U,   86519011U,
 2512459080U, 3838209314U, 1220612927U, 3339683548U,
  133810670U, 1090789135U, 1078426020U, 1569222167U,
  845107691U, 3583754449U, 4072456591U, 1091646820U,
  628848692U, 1613405280U, 3757631651U,  526609435U,
  236106946U,   48312990U, 2942717905U, 3402727701U,
 1797494240U,  859738849U,  992217954U, 4005476642U,
 2243076622U, 3870952857U, 3732016268U,  765654824U,
 3490871365U, 2511836413U, 1685915746U, 3888969200U,
 1414112111U, 2273134842U, 3281911079U, 4080962846U,
  172450625U, 2569994100U,  980381355U, 4109958455U,
 2819808352U, 2716589560U, 2568741196U, 3681446669U,
 3329971472U, 1835478071U,  660984891U, 3704678404U,
 4045999559U, 3422617507U, 3040415634U, 1762651403U,
 1719377915U, 3470491036U, 2693910283U, 3642056355U,
 3138596744U, 1364962596U, 2073328063U, 1983633131U,
  926494387U, 3423689081U, 2150032023U, 4096667949U,
 1749200295U, 3328846651U,  309677260U, 2016342300U,
 1779581495U, 3079819751U,  111262694U, 1274766160U,
  443224088U,  298511866U, 1025883608U, 3806446537U,
 1145181785U,  168956806U, 3641502830U, 3584813610U,
 1689216846U, 3666258015U, 3200248200U, 1692713982U,
 2646376535U, 4042768518U, 1618508792U, 1610833997U,
 3523052358U, 4130873264U, 2001055236U, 3610705100U,
 2202168115U, 4028541809U, 2961195399U, 1006657119U,
 2006996926U, 3186142756U, 1430667929U, 3210227297U,
 1314452623U, 4074634658U, 4101304120U, 2273951170U,
 1399257539U, 3367210612U, 3027628629U, 1190975929U,
 2062231137U, 2333990788U, 2221543033U, 2438960610U,
 1181637006U,  548689776U, 2362791313U, 3372408396U,
 3104550113U, 3145860560U,  296247880U, 1970579870U,
 3078560182U, 3769228297U, 1714227617U, 3291629107U,
 3898220290U,  166772364U, 1251581989U,  493813264U,
  448347421U,  195405023U, 2709975567U,  677966185U,
 3703036547U, 1463355134U, 2715995803U, 1338867538U,
 1343315457U, 2802222074U, 2684532164U,  233230375U,
 2599980071U, 2000651841U, 3277868038U, 1638401717U,
 4028070440U, 3237316320U,    6314154U,  819756386U,
  300326615U,  590932579U, 1405279636U, 3267499572U,
 3150704214U, 2428286686U, 3959192993U, 3461946742U,
 1862657033U, 1266418056U,  963775037U, 2089974820U,
 2263052895U, 1917689273U,  448879540U, 3550394620U,
 3981727096U,  150775221U, 3627908307U, 1303187396U,
  508620638U, 2975983352U, 2726630617U, 1817252668U,
 1876281319U, 1457606340U,  908771278U, 3720792119U,
 3617206836U, 2455994898U, 1729034894U, 1080033504U,

  976866871U, 3556439503U, 2881648439U, 1522871579U,
 1555064734U, 1336096578U, 3548522304U, 2579274686U,
 3574697629U, 3205460757U, 3593280638U, 3338716283U,
 3079412587U,  564236357U, 2993598910U, 1781952180U,
 1464380207U, 3163844217U, 3332601554U, 1699332808U,
 1393555694U, 1183702653U, 3581086237U, 1288719814U,
  691649499U, 2847557200U, 2895455976U, 3193889540U,
 2717570544U, 1781354906U, 1676643554U, 2592534050U,
 3230253752U, 1126444790U, 2770207658U, 2633158820U,
 2210423226U, 2615765581U, 2414155088U, 3127139286U,
  673620729U, 2805611233U, 1269405062U, 4015350505U,
 3341807571U, 4149409754U, 1057255273U, 2012875353U,
 2162469141U, 2276492801U, 2601117357U,  993977747U,
 3918593370U, 2654263191U,  753973209U,   36408145U,
 2530585658U,   25011837U, 3520020182U, 2088578344U,
  530523599U, 2918365339U, 1524020338U, 1518925132U,
 3760827505U, 3759777254U, 1202760957U, 3985898139U,
 3906192525U,  674977740U, 4174734889U, 2031300136U,
 2019492241U, 3983892565U, 4153806404U, 3822280332U,
  352677332U, 2297720250U,   60907813U,   90501309U,
 3286998549U, 1016092578U, 2535922412U, 2839152426U,
  457141659U,  509813237U, 4120667899U,  652014361U,
 1966332200U, 2975202805U,   55981186U, 2327461051U,
  676427537U, 3255491064U, 2882294119U, 3433927263U,
 1307055953U,  942726286U,  933058658U, 2468411793U,
 3933900994U, 4215176142U, 1361170020U, 2001714738U,
 2830558078U, 3274259782U, 1222529897U, 1679025792U,
 2729314320U, 3714953764U, 1770335741U,  151462246U,
 3013232138U, 1682292957U, 1483529935U,  471910574U,
 1539241949U,  458788160U, 3436315007U, 1807016891U,
 3718408830U,  978976581U, 1043663428U, 3165965781U,
 1927990952U, 4200891579U, 2372276910U, 3208408903U,
 3533431907U, 1412390302U, 2931980059U, 4132332400U,
 1947078029U, 3881505623U, 4168226417U, 2941484381U,
 1077988104U, 1320477388U,  886195818U,   18198404U,
 3786409000U, 2509781533U,  112762804U, 3463356488U,
 1866414978U,  891333506U,   18488651U,  661792760U,
 1628790961U, 3885187036U, 3141171499U,  876946877U,
 2693282273U, 1372485963U,  791857591U, 2686433993U,
 3759982718U, 3167212022U, 3472953795U, 2716379847U,
  445679433U, 3561995674U, 3504004811U, 3574258232U,
   54117162U, 3331405415U, 2381918588U, 3769707343U,
 4154350007U, 1140177722U, 4074052095U,  668550556U,
 3214352940U,  367459370U,  261225585U, 2610173221U,
 4209349473U, 3468074219U, 3265815641U,  314222801U,
 3066103646U, 3808782860U,  282218597U, 3406013506U,
 3773591054U,  379116347U, 1285071038U,  846784868U,
 2669647154U, 3771962079U, 3550491691U, 2305946142U,
  453669953U, 1268987020U, 3317592352U, 3279303384U,
 3744833421U, 2610507566U, 3859509063U,  266596637U,
 3847019092U,  517658769U, 3462560207U, 3443424879U,
  370717030U, 4247526661U, 2224018117U, 4143653529U,
 4112773975U, 2788324899U, 2477274417U, 1456262402U,
 2901442914U, 1517677493U, 1846949527U, 2295493580U,
 3734397586U, 2176403920U, 1280348187U, 1908823572U,
 3871786941U,  846861322U, 1172426758U, 3287448474U,
 3383383037U, 1655181056U, 3139813346U,  901632758U,
 1897031941U, 2986607138U, 3066810236U, 3447102507U,
 1393639104U,  373351379U,  950779232U,  625454576U,
 3124240540U, 4148612726U, 2007998917U,  544563296U,
 2244738638U, 2330496472U, 2058025392U, 1291430526U,
  424198748U,   50039436U,   29584100U, 3605783033U,
 2429876329U, 2791104160U, 1057563949U, 3255363231U,
 3075367218U, 3463963227U, 1469046755U,  985887462U
};




} // namespace

