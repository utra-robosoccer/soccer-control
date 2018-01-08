  function targMap = targDataMap(),

  ;%***********************
  ;% Create Parameter Map *
  ;%***********************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 1;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc paramMap
    ;%
    paramMap.nSections           = nTotSects;
    paramMap.sectIdxOffset       = sectIdxOffset;
      paramMap.sections(nTotSects) = dumSection; %prealloc
    paramMap.nTotData            = -1;
    
    ;%
    ;% Auto data (rtP)
    ;%
      section.nData     = 254;
      section.data(254)  = dumData; %prealloc
      
	  ;% rtP.PIDController_N
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtP.PIDController_N_ocgp2isrtx
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtP.PIDController_N_gvz5czyugt
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtP.PIDController_N_muxadt1ywm
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtP.PIDController_N_km0hveysh0
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 4;
	
	  ;% rtP.PIDController_N_kmncz1oq0m
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 5;
	
	  ;% rtP.PIDController_N_i1bmm4dj0f
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 6;
	
	  ;% rtP.PIDController_N_cc32kkvamp
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 7;
	
	  ;% rtP.PIDController_N_pjmn0xcg1h
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 8;
	
	  ;% rtP.PIDController_N_kgedckgdgg
	  section.data(10).logicalSrcIdx = 9;
	  section.data(10).dtTransOffset = 9;
	
	  ;% rtP.PIDController_N_o5zc13vzgl
	  section.data(11).logicalSrcIdx = 10;
	  section.data(11).dtTransOffset = 10;
	
	  ;% rtP.PIDController_N_lxx0g5lqcb
	  section.data(12).logicalSrcIdx = 11;
	  section.data(12).dtTransOffset = 11;
	
	  ;% rtP.FacetoPlaneForce_PlaB_x
	  section.data(13).logicalSrcIdx = 12;
	  section.data(13).dtTransOffset = 12;
	
	  ;% rtP.FacetoPlaneForce_PlaB_x_pqdkeb1ajt
	  section.data(14).logicalSrcIdx = 13;
	  section.data(14).dtTransOffset = 13;
	
	  ;% rtP.FacetoPlaneForce_PlaB_y
	  section.data(15).logicalSrcIdx = 14;
	  section.data(15).dtTransOffset = 14;
	
	  ;% rtP.FacetoPlaneForce_PlaB_y_ibuhuqe2qv
	  section.data(16).logicalSrcIdx = 15;
	  section.data(16).dtTransOffset = 15;
	
	  ;% rtP.FacetoPlaneForce_PlaB_z
	  section.data(17).logicalSrcIdx = 16;
	  section.data(17).dtTransOffset = 16;
	
	  ;% rtP.FacetoPlaneForce_PlaB_z_pfok1bvpl3
	  section.data(18).logicalSrcIdx = 17;
	  section.data(18).dtTransOffset = 17;
	
	  ;% rtP.PlaneCollider_b
	  section.data(19).logicalSrcIdx = 18;
	  section.data(19).dtTransOffset = 18;
	
	  ;% rtP.PlaneCollider_b_mdi3pnxzom
	  section.data(20).logicalSrcIdx = 19;
	  section.data(20).dtTransOffset = 19;
	
	  ;% rtP.PlaneCollider_coll_rad
	  section.data(21).logicalSrcIdx = 20;
	  section.data(21).dtTransOffset = 20;
	
	  ;% rtP.PlaneCollider_coll_rad_in4ezlz55k
	  section.data(22).logicalSrcIdx = 21;
	  section.data(22).dtTransOffset = 21;
	
	  ;% rtP.PlaneCollider_k
	  section.data(23).logicalSrcIdx = 22;
	  section.data(23).dtTransOffset = 22;
	
	  ;% rtP.PlaneCollider_k_mz1hpxrnd2
	  section.data(24).logicalSrcIdx = 23;
	  section.data(24).dtTransOffset = 23;
	
	  ;% rtP.PIDController5_kd
	  section.data(25).logicalSrcIdx = 24;
	  section.data(25).dtTransOffset = 24;
	
	  ;% rtP.PIDController6_kd
	  section.data(26).logicalSrcIdx = 25;
	  section.data(26).dtTransOffset = 25;
	
	  ;% rtP.PIDController1_kd
	  section.data(27).logicalSrcIdx = 26;
	  section.data(27).dtTransOffset = 26;
	
	  ;% rtP.PIDController2_kd
	  section.data(28).logicalSrcIdx = 27;
	  section.data(28).dtTransOffset = 27;
	
	  ;% rtP.PIDController3_kd
	  section.data(29).logicalSrcIdx = 28;
	  section.data(29).dtTransOffset = 28;
	
	  ;% rtP.PIDController4_kd
	  section.data(30).logicalSrcIdx = 29;
	  section.data(30).dtTransOffset = 29;
	
	  ;% rtP.PIDController11_kd
	  section.data(31).logicalSrcIdx = 30;
	  section.data(31).dtTransOffset = 30;
	
	  ;% rtP.PIDController12_kd
	  section.data(32).logicalSrcIdx = 31;
	  section.data(32).dtTransOffset = 31;
	
	  ;% rtP.PIDController7_kd
	  section.data(33).logicalSrcIdx = 32;
	  section.data(33).dtTransOffset = 32;
	
	  ;% rtP.PIDController8_kd
	  section.data(34).logicalSrcIdx = 33;
	  section.data(34).dtTransOffset = 33;
	
	  ;% rtP.PIDController9_kd
	  section.data(35).logicalSrcIdx = 34;
	  section.data(35).dtTransOffset = 34;
	
	  ;% rtP.PIDController10_kd
	  section.data(36).logicalSrcIdx = 35;
	  section.data(36).dtTransOffset = 35;
	
	  ;% rtP.PIDController1_ki
	  section.data(37).logicalSrcIdx = 36;
	  section.data(37).dtTransOffset = 36;
	
	  ;% rtP.PIDController10_ki
	  section.data(38).logicalSrcIdx = 37;
	  section.data(38).dtTransOffset = 37;
	
	  ;% rtP.PIDController11_ki
	  section.data(39).logicalSrcIdx = 38;
	  section.data(39).dtTransOffset = 38;
	
	  ;% rtP.PIDController12_ki
	  section.data(40).logicalSrcIdx = 39;
	  section.data(40).dtTransOffset = 39;
	
	  ;% rtP.PIDController2_ki
	  section.data(41).logicalSrcIdx = 40;
	  section.data(41).dtTransOffset = 40;
	
	  ;% rtP.PIDController3_ki
	  section.data(42).logicalSrcIdx = 41;
	  section.data(42).dtTransOffset = 41;
	
	  ;% rtP.PIDController4_ki
	  section.data(43).logicalSrcIdx = 42;
	  section.data(43).dtTransOffset = 42;
	
	  ;% rtP.PIDController5_ki
	  section.data(44).logicalSrcIdx = 43;
	  section.data(44).dtTransOffset = 43;
	
	  ;% rtP.PIDController6_ki
	  section.data(45).logicalSrcIdx = 44;
	  section.data(45).dtTransOffset = 44;
	
	  ;% rtP.PIDController7_ki
	  section.data(46).logicalSrcIdx = 45;
	  section.data(46).dtTransOffset = 45;
	
	  ;% rtP.PIDController8_ki
	  section.data(47).logicalSrcIdx = 46;
	  section.data(47).dtTransOffset = 46;
	
	  ;% rtP.PIDController9_ki
	  section.data(48).logicalSrcIdx = 47;
	  section.data(48).dtTransOffset = 47;
	
	  ;% rtP.PIDController5_kp
	  section.data(49).logicalSrcIdx = 48;
	  section.data(49).dtTransOffset = 48;
	
	  ;% rtP.PIDController6_kp
	  section.data(50).logicalSrcIdx = 49;
	  section.data(50).dtTransOffset = 49;
	
	  ;% rtP.PIDController1_kp
	  section.data(51).logicalSrcIdx = 50;
	  section.data(51).dtTransOffset = 50;
	
	  ;% rtP.PIDController2_kp
	  section.data(52).logicalSrcIdx = 51;
	  section.data(52).dtTransOffset = 51;
	
	  ;% rtP.PIDController3_kp
	  section.data(53).logicalSrcIdx = 52;
	  section.data(53).dtTransOffset = 52;
	
	  ;% rtP.PIDController4_kp
	  section.data(54).logicalSrcIdx = 53;
	  section.data(54).dtTransOffset = 53;
	
	  ;% rtP.PIDController11_kp
	  section.data(55).logicalSrcIdx = 54;
	  section.data(55).dtTransOffset = 54;
	
	  ;% rtP.PIDController12_kp
	  section.data(56).logicalSrcIdx = 55;
	  section.data(56).dtTransOffset = 55;
	
	  ;% rtP.PIDController7_kp
	  section.data(57).logicalSrcIdx = 56;
	  section.data(57).dtTransOffset = 56;
	
	  ;% rtP.PIDController8_kp
	  section.data(58).logicalSrcIdx = 57;
	  section.data(58).dtTransOffset = 57;
	
	  ;% rtP.PIDController9_kp
	  section.data(59).logicalSrcIdx = 58;
	  section.data(59).dtTransOffset = 58;
	
	  ;% rtP.PIDController10_kp
	  section.data(60).logicalSrcIdx = 59;
	  section.data(60).dtTransOffset = 59;
	
	  ;% rtP.Out_Y0
	  section.data(61).logicalSrcIdx = 60;
	  section.data(61).dtTransOffset = 60;
	
	  ;% rtP.DeadZone_Start
	  section.data(62).logicalSrcIdx = 61;
	  section.data(62).dtTransOffset = 61;
	
	  ;% rtP.DeadZone_End
	  section.data(63).logicalSrcIdx = 62;
	  section.data(63).dtTransOffset = 62;
	
	  ;% rtP.Gain2_Gain
	  section.data(64).logicalSrcIdx = 63;
	  section.data(64).dtTransOffset = 63;
	
	  ;% rtP.Fx_Value
	  section.data(65).logicalSrcIdx = 64;
	  section.data(65).dtTransOffset = 64;
	
	  ;% rtP.Saturation_UpperSat
	  section.data(66).logicalSrcIdx = 65;
	  section.data(66).dtTransOffset = 65;
	
	  ;% rtP.Saturation_LowerSat
	  section.data(67).logicalSrcIdx = 66;
	  section.data(67).dtTransOffset = 66;
	
	  ;% rtP.Gain_Gain
	  section.data(68).logicalSrcIdx = 67;
	  section.data(68).dtTransOffset = 67;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_tableData
	  section.data(69).logicalSrcIdx = 68;
	  section.data(69).dtTransOffset = 68;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_bp01Data
	  section.data(70).logicalSrcIdx = 69;
	  section.data(70).dtTransOffset = 74;
	
	  ;% rtP.Gain2_Gain_lic2e5igok
	  section.data(71).logicalSrcIdx = 70;
	  section.data(71).dtTransOffset = 80;
	
	  ;% rtP.Fx1_Value
	  section.data(72).logicalSrcIdx = 71;
	  section.data(72).dtTransOffset = 81;
	
	  ;% rtP.Gain_Gain_hdsj25mky2
	  section.data(73).logicalSrcIdx = 72;
	  section.data(73).dtTransOffset = 82;
	
	  ;% rtP.Fx2_Value
	  section.data(74).logicalSrcIdx = 73;
	  section.data(74).dtTransOffset = 83;
	
	  ;% rtP.Zeros_Value
	  section.data(75).logicalSrcIdx = 74;
	  section.data(75).dtTransOffset = 86;
	
	  ;% rtP.Out_Y0_bhoyctuymc
	  section.data(76).logicalSrcIdx = 75;
	  section.data(76).dtTransOffset = 98;
	
	  ;% rtP.DeadZone_Start_en5c1lcgv0
	  section.data(77).logicalSrcIdx = 76;
	  section.data(77).dtTransOffset = 99;
	
	  ;% rtP.DeadZone_End_avpkudermi
	  section.data(78).logicalSrcIdx = 77;
	  section.data(78).dtTransOffset = 100;
	
	  ;% rtP.Gain2_Gain_mn5ifakuiq
	  section.data(79).logicalSrcIdx = 78;
	  section.data(79).dtTransOffset = 101;
	
	  ;% rtP.Fx_Value_p05m1sehgg
	  section.data(80).logicalSrcIdx = 79;
	  section.data(80).dtTransOffset = 102;
	
	  ;% rtP.Saturation_UpperSat_kqi33ph2hb
	  section.data(81).logicalSrcIdx = 80;
	  section.data(81).dtTransOffset = 103;
	
	  ;% rtP.Saturation_LowerSat_cpotparo3s
	  section.data(82).logicalSrcIdx = 81;
	  section.data(82).dtTransOffset = 104;
	
	  ;% rtP.Gain_Gain_llm3adwzdf
	  section.data(83).logicalSrcIdx = 82;
	  section.data(83).dtTransOffset = 105;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_tableData_nmmyhxuaos
	  section.data(84).logicalSrcIdx = 83;
	  section.data(84).dtTransOffset = 106;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_bp01Data_lcvc0rfbjm
	  section.data(85).logicalSrcIdx = 84;
	  section.data(85).dtTransOffset = 112;
	
	  ;% rtP.Gain2_Gain_gkegxdyqw1
	  section.data(86).logicalSrcIdx = 85;
	  section.data(86).dtTransOffset = 118;
	
	  ;% rtP.Fx1_Value_prpzltwyhf
	  section.data(87).logicalSrcIdx = 86;
	  section.data(87).dtTransOffset = 119;
	
	  ;% rtP.Gain_Gain_dy0f0mjqut
	  section.data(88).logicalSrcIdx = 87;
	  section.data(88).dtTransOffset = 120;
	
	  ;% rtP.Fx2_Value_agsgqcgsmt
	  section.data(89).logicalSrcIdx = 88;
	  section.data(89).dtTransOffset = 121;
	
	  ;% rtP.Zeros_Value_jipn5jb40c
	  section.data(90).logicalSrcIdx = 89;
	  section.data(90).dtTransOffset = 124;
	
	  ;% rtP.Out_Y0_mequvw332t
	  section.data(91).logicalSrcIdx = 90;
	  section.data(91).dtTransOffset = 136;
	
	  ;% rtP.DeadZone_Start_n1ksbisye1
	  section.data(92).logicalSrcIdx = 91;
	  section.data(92).dtTransOffset = 137;
	
	  ;% rtP.DeadZone_End_f3oqlx4ghd
	  section.data(93).logicalSrcIdx = 92;
	  section.data(93).dtTransOffset = 138;
	
	  ;% rtP.Gain2_Gain_grh4ezpnl2
	  section.data(94).logicalSrcIdx = 93;
	  section.data(94).dtTransOffset = 139;
	
	  ;% rtP.Fx_Value_cpagbh5gzj
	  section.data(95).logicalSrcIdx = 94;
	  section.data(95).dtTransOffset = 140;
	
	  ;% rtP.Saturation_UpperSat_hredmmoexo
	  section.data(96).logicalSrcIdx = 95;
	  section.data(96).dtTransOffset = 141;
	
	  ;% rtP.Saturation_LowerSat_acoy4dhnv5
	  section.data(97).logicalSrcIdx = 96;
	  section.data(97).dtTransOffset = 142;
	
	  ;% rtP.Gain_Gain_k2bxwezc3j
	  section.data(98).logicalSrcIdx = 97;
	  section.data(98).dtTransOffset = 143;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_tableData_mvinfwee3d
	  section.data(99).logicalSrcIdx = 98;
	  section.data(99).dtTransOffset = 144;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_bp01Data_dppfjezugf
	  section.data(100).logicalSrcIdx = 99;
	  section.data(100).dtTransOffset = 150;
	
	  ;% rtP.Gain2_Gain_o05ffknl44
	  section.data(101).logicalSrcIdx = 100;
	  section.data(101).dtTransOffset = 156;
	
	  ;% rtP.Fx1_Value_a324s0ohlc
	  section.data(102).logicalSrcIdx = 101;
	  section.data(102).dtTransOffset = 157;
	
	  ;% rtP.Gain_Gain_kntvo4envy
	  section.data(103).logicalSrcIdx = 102;
	  section.data(103).dtTransOffset = 158;
	
	  ;% rtP.Fx2_Value_ero0tarsxl
	  section.data(104).logicalSrcIdx = 103;
	  section.data(104).dtTransOffset = 159;
	
	  ;% rtP.Zeros_Value_ffg0z2si2c
	  section.data(105).logicalSrcIdx = 104;
	  section.data(105).dtTransOffset = 162;
	
	  ;% rtP.Out_Y0_fpavrjnhbe
	  section.data(106).logicalSrcIdx = 105;
	  section.data(106).dtTransOffset = 174;
	
	  ;% rtP.DeadZone_Start_lysrfmlwpg
	  section.data(107).logicalSrcIdx = 106;
	  section.data(107).dtTransOffset = 175;
	
	  ;% rtP.DeadZone_End_fegvyxo0cd
	  section.data(108).logicalSrcIdx = 107;
	  section.data(108).dtTransOffset = 176;
	
	  ;% rtP.Gain2_Gain_ddh5uu0vw0
	  section.data(109).logicalSrcIdx = 108;
	  section.data(109).dtTransOffset = 177;
	
	  ;% rtP.Fx_Value_bta5fukrke
	  section.data(110).logicalSrcIdx = 109;
	  section.data(110).dtTransOffset = 178;
	
	  ;% rtP.Saturation_UpperSat_lzowl13efp
	  section.data(111).logicalSrcIdx = 110;
	  section.data(111).dtTransOffset = 179;
	
	  ;% rtP.Saturation_LowerSat_ppts2ikzpp
	  section.data(112).logicalSrcIdx = 111;
	  section.data(112).dtTransOffset = 180;
	
	  ;% rtP.Gain_Gain_dub0donc51
	  section.data(113).logicalSrcIdx = 112;
	  section.data(113).dtTransOffset = 181;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_tableData_i5tg4111eq
	  section.data(114).logicalSrcIdx = 113;
	  section.data(114).dtTransOffset = 182;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_bp01Data_lo4gduzmih
	  section.data(115).logicalSrcIdx = 114;
	  section.data(115).dtTransOffset = 188;
	
	  ;% rtP.Gain2_Gain_crzzv5p1oe
	  section.data(116).logicalSrcIdx = 115;
	  section.data(116).dtTransOffset = 194;
	
	  ;% rtP.Fx1_Value_dmas20mfkq
	  section.data(117).logicalSrcIdx = 116;
	  section.data(117).dtTransOffset = 195;
	
	  ;% rtP.Gain_Gain_m5pnkxuahq
	  section.data(118).logicalSrcIdx = 117;
	  section.data(118).dtTransOffset = 196;
	
	  ;% rtP.Fx2_Value_k0ypzwv3zx
	  section.data(119).logicalSrcIdx = 118;
	  section.data(119).dtTransOffset = 197;
	
	  ;% rtP.Zeros_Value_k0pe0oe5yw
	  section.data(120).logicalSrcIdx = 119;
	  section.data(120).dtTransOffset = 200;
	
	  ;% rtP.Out_Y0_e5lnmg2wfb
	  section.data(121).logicalSrcIdx = 120;
	  section.data(121).dtTransOffset = 212;
	
	  ;% rtP.DeadZone_Start_mnze00b2tt
	  section.data(122).logicalSrcIdx = 121;
	  section.data(122).dtTransOffset = 213;
	
	  ;% rtP.DeadZone_End_ldpp1ta3ih
	  section.data(123).logicalSrcIdx = 122;
	  section.data(123).dtTransOffset = 214;
	
	  ;% rtP.Gain2_Gain_brmdhvmzkh
	  section.data(124).logicalSrcIdx = 123;
	  section.data(124).dtTransOffset = 215;
	
	  ;% rtP.Fx_Value_fkydnpbhfy
	  section.data(125).logicalSrcIdx = 124;
	  section.data(125).dtTransOffset = 216;
	
	  ;% rtP.Saturation_UpperSat_aqummvbavv
	  section.data(126).logicalSrcIdx = 125;
	  section.data(126).dtTransOffset = 217;
	
	  ;% rtP.Saturation_LowerSat_dgscumiz0g
	  section.data(127).logicalSrcIdx = 126;
	  section.data(127).dtTransOffset = 218;
	
	  ;% rtP.Gain_Gain_kjnu0holyj
	  section.data(128).logicalSrcIdx = 127;
	  section.data(128).dtTransOffset = 219;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_tableData_fytvl3mpss
	  section.data(129).logicalSrcIdx = 128;
	  section.data(129).dtTransOffset = 220;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_bp01Data_lpzot4hdcx
	  section.data(130).logicalSrcIdx = 129;
	  section.data(130).dtTransOffset = 226;
	
	  ;% rtP.Gain2_Gain_iwytetebmf
	  section.data(131).logicalSrcIdx = 130;
	  section.data(131).dtTransOffset = 232;
	
	  ;% rtP.Fx1_Value_cu53kbbxqv
	  section.data(132).logicalSrcIdx = 131;
	  section.data(132).dtTransOffset = 233;
	
	  ;% rtP.Gain_Gain_e15c14nhc5
	  section.data(133).logicalSrcIdx = 132;
	  section.data(133).dtTransOffset = 234;
	
	  ;% rtP.Fx2_Value_nwstgtbesi
	  section.data(134).logicalSrcIdx = 133;
	  section.data(134).dtTransOffset = 235;
	
	  ;% rtP.Zeros_Value_mehw5fgv0w
	  section.data(135).logicalSrcIdx = 134;
	  section.data(135).dtTransOffset = 238;
	
	  ;% rtP.Out_Y0_nzza3uwkjy
	  section.data(136).logicalSrcIdx = 135;
	  section.data(136).dtTransOffset = 250;
	
	  ;% rtP.DeadZone_Start_l0412eopho
	  section.data(137).logicalSrcIdx = 136;
	  section.data(137).dtTransOffset = 251;
	
	  ;% rtP.DeadZone_End_jqsqddpxiz
	  section.data(138).logicalSrcIdx = 137;
	  section.data(138).dtTransOffset = 252;
	
	  ;% rtP.Gain2_Gain_jqj4gnlbpn
	  section.data(139).logicalSrcIdx = 138;
	  section.data(139).dtTransOffset = 253;
	
	  ;% rtP.Fx_Value_luww3w4c3z
	  section.data(140).logicalSrcIdx = 139;
	  section.data(140).dtTransOffset = 254;
	
	  ;% rtP.Saturation_UpperSat_jwf3rdgjwl
	  section.data(141).logicalSrcIdx = 140;
	  section.data(141).dtTransOffset = 255;
	
	  ;% rtP.Saturation_LowerSat_pcctcu3ube
	  section.data(142).logicalSrcIdx = 141;
	  section.data(142).dtTransOffset = 256;
	
	  ;% rtP.Gain_Gain_bf3n5ovwdb
	  section.data(143).logicalSrcIdx = 142;
	  section.data(143).dtTransOffset = 257;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_tableData_fvuqp2ngfs
	  section.data(144).logicalSrcIdx = 143;
	  section.data(144).dtTransOffset = 258;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_bp01Data_mf3ij2hosn
	  section.data(145).logicalSrcIdx = 144;
	  section.data(145).dtTransOffset = 264;
	
	  ;% rtP.Gain2_Gain_fnnyues2o4
	  section.data(146).logicalSrcIdx = 145;
	  section.data(146).dtTransOffset = 270;
	
	  ;% rtP.Fx1_Value_oaxjddcmgg
	  section.data(147).logicalSrcIdx = 146;
	  section.data(147).dtTransOffset = 271;
	
	  ;% rtP.Gain_Gain_cajav0ckso
	  section.data(148).logicalSrcIdx = 147;
	  section.data(148).dtTransOffset = 272;
	
	  ;% rtP.Fx2_Value_mwuinofpu0
	  section.data(149).logicalSrcIdx = 148;
	  section.data(149).dtTransOffset = 273;
	
	  ;% rtP.Zeros_Value_o3zutn1xla
	  section.data(150).logicalSrcIdx = 149;
	  section.data(150).dtTransOffset = 276;
	
	  ;% rtP.Out_Y0_dzwpxdjv33
	  section.data(151).logicalSrcIdx = 150;
	  section.data(151).dtTransOffset = 288;
	
	  ;% rtP.DeadZone_Start_km4hsg30ps
	  section.data(152).logicalSrcIdx = 151;
	  section.data(152).dtTransOffset = 289;
	
	  ;% rtP.DeadZone_End_ik1et40mr0
	  section.data(153).logicalSrcIdx = 152;
	  section.data(153).dtTransOffset = 290;
	
	  ;% rtP.Gain2_Gain_lpqsprse0q
	  section.data(154).logicalSrcIdx = 153;
	  section.data(154).dtTransOffset = 291;
	
	  ;% rtP.Fx_Value_lxpw1eg03z
	  section.data(155).logicalSrcIdx = 154;
	  section.data(155).dtTransOffset = 292;
	
	  ;% rtP.Saturation_UpperSat_mbyrnsc01p
	  section.data(156).logicalSrcIdx = 155;
	  section.data(156).dtTransOffset = 293;
	
	  ;% rtP.Saturation_LowerSat_bteislxo1u
	  section.data(157).logicalSrcIdx = 156;
	  section.data(157).dtTransOffset = 294;
	
	  ;% rtP.Gain_Gain_drjc3y2x5m
	  section.data(158).logicalSrcIdx = 157;
	  section.data(158).dtTransOffset = 295;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_tableData_ba511pjq4e
	  section.data(159).logicalSrcIdx = 158;
	  section.data(159).dtTransOffset = 296;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_bp01Data_pohpjji2sw
	  section.data(160).logicalSrcIdx = 159;
	  section.data(160).dtTransOffset = 302;
	
	  ;% rtP.Gain2_Gain_ibafh4loyw
	  section.data(161).logicalSrcIdx = 160;
	  section.data(161).dtTransOffset = 308;
	
	  ;% rtP.Fx1_Value_phv55ggule
	  section.data(162).logicalSrcIdx = 161;
	  section.data(162).dtTransOffset = 309;
	
	  ;% rtP.Gain_Gain_gjprn2yedg
	  section.data(163).logicalSrcIdx = 162;
	  section.data(163).dtTransOffset = 310;
	
	  ;% rtP.Fx2_Value_dyt50v1e52
	  section.data(164).logicalSrcIdx = 163;
	  section.data(164).dtTransOffset = 311;
	
	  ;% rtP.Zeros_Value_i12nrryq4h
	  section.data(165).logicalSrcIdx = 164;
	  section.data(165).dtTransOffset = 314;
	
	  ;% rtP.Out_Y0_ccosawrqu4
	  section.data(166).logicalSrcIdx = 165;
	  section.data(166).dtTransOffset = 326;
	
	  ;% rtP.DeadZone_Start_ieknili4az
	  section.data(167).logicalSrcIdx = 166;
	  section.data(167).dtTransOffset = 327;
	
	  ;% rtP.DeadZone_End_epcs5tmsng
	  section.data(168).logicalSrcIdx = 167;
	  section.data(168).dtTransOffset = 328;
	
	  ;% rtP.Gain2_Gain_n3ahddsfmq
	  section.data(169).logicalSrcIdx = 168;
	  section.data(169).dtTransOffset = 329;
	
	  ;% rtP.Fx_Value_fkihoziais
	  section.data(170).logicalSrcIdx = 169;
	  section.data(170).dtTransOffset = 330;
	
	  ;% rtP.Saturation_UpperSat_lvrj1pusns
	  section.data(171).logicalSrcIdx = 170;
	  section.data(171).dtTransOffset = 331;
	
	  ;% rtP.Saturation_LowerSat_il4t2jpstt
	  section.data(172).logicalSrcIdx = 171;
	  section.data(172).dtTransOffset = 332;
	
	  ;% rtP.Gain_Gain_o1dwjnktef
	  section.data(173).logicalSrcIdx = 172;
	  section.data(173).dtTransOffset = 333;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_tableData_orocuiv51e
	  section.data(174).logicalSrcIdx = 173;
	  section.data(174).dtTransOffset = 334;
	
	  ;% rtP.CoefficientofFrictionvsVelocity_bp01Data_au3pzqmqpk
	  section.data(175).logicalSrcIdx = 174;
	  section.data(175).dtTransOffset = 340;
	
	  ;% rtP.Gain2_Gain_ivywmt2yty
	  section.data(176).logicalSrcIdx = 175;
	  section.data(176).dtTransOffset = 346;
	
	  ;% rtP.Fx1_Value_hqswq4jfh3
	  section.data(177).logicalSrcIdx = 176;
	  section.data(177).dtTransOffset = 347;
	
	  ;% rtP.Gain_Gain_fjon1i0mce
	  section.data(178).logicalSrcIdx = 177;
	  section.data(178).dtTransOffset = 348;
	
	  ;% rtP.Fx2_Value_ijbwagewm5
	  section.data(179).logicalSrcIdx = 178;
	  section.data(179).dtTransOffset = 349;
	
	  ;% rtP.Zeros_Value_jcefnewoxz
	  section.data(180).logicalSrcIdx = 179;
	  section.data(180).dtTransOffset = 352;
	
	  ;% rtP.FromWorkspace_Time0
	  section.data(181).logicalSrcIdx = 180;
	  section.data(181).dtTransOffset = 364;
	
	  ;% rtP.FromWorkspace_Data0
	  section.data(182).logicalSrcIdx = 181;
	  section.data(182).dtTransOffset = 1365;
	
	  ;% rtP.Integrator_gainval
	  section.data(183).logicalSrcIdx = 182;
	  section.data(183).dtTransOffset = 13377;
	
	  ;% rtP.Integrator_IC
	  section.data(184).logicalSrcIdx = 183;
	  section.data(184).dtTransOffset = 13378;
	
	  ;% rtP.Filter_gainval
	  section.data(185).logicalSrcIdx = 184;
	  section.data(185).dtTransOffset = 13379;
	
	  ;% rtP.Filter_IC
	  section.data(186).logicalSrcIdx = 185;
	  section.data(186).dtTransOffset = 13380;
	
	  ;% rtP.Integrator_gainval_iodwes1hjb
	  section.data(187).logicalSrcIdx = 186;
	  section.data(187).dtTransOffset = 13381;
	
	  ;% rtP.Integrator_IC_jfwb243z0j
	  section.data(188).logicalSrcIdx = 187;
	  section.data(188).dtTransOffset = 13382;
	
	  ;% rtP.Filter_gainval_d5o5lwexhk
	  section.data(189).logicalSrcIdx = 188;
	  section.data(189).dtTransOffset = 13383;
	
	  ;% rtP.Filter_IC_eps52ga2rl
	  section.data(190).logicalSrcIdx = 189;
	  section.data(190).dtTransOffset = 13384;
	
	  ;% rtP.Integrator_gainval_pbixauzv0i
	  section.data(191).logicalSrcIdx = 190;
	  section.data(191).dtTransOffset = 13385;
	
	  ;% rtP.Integrator_IC_omr0xm01t4
	  section.data(192).logicalSrcIdx = 191;
	  section.data(192).dtTransOffset = 13386;
	
	  ;% rtP.Filter_gainval_kzcfkh2hji
	  section.data(193).logicalSrcIdx = 192;
	  section.data(193).dtTransOffset = 13387;
	
	  ;% rtP.Filter_IC_ernoyracnd
	  section.data(194).logicalSrcIdx = 193;
	  section.data(194).dtTransOffset = 13388;
	
	  ;% rtP.Integrator_gainval_f0p0cfru1g
	  section.data(195).logicalSrcIdx = 194;
	  section.data(195).dtTransOffset = 13389;
	
	  ;% rtP.Integrator_IC_ixlfgtclxd
	  section.data(196).logicalSrcIdx = 195;
	  section.data(196).dtTransOffset = 13390;
	
	  ;% rtP.Filter_gainval_leneaf3a1b
	  section.data(197).logicalSrcIdx = 196;
	  section.data(197).dtTransOffset = 13391;
	
	  ;% rtP.Filter_IC_a4gm5i0s5p
	  section.data(198).logicalSrcIdx = 197;
	  section.data(198).dtTransOffset = 13392;
	
	  ;% rtP.Integrator_gainval_jtluthzzbk
	  section.data(199).logicalSrcIdx = 198;
	  section.data(199).dtTransOffset = 13393;
	
	  ;% rtP.Integrator_IC_grzfrpw5nw
	  section.data(200).logicalSrcIdx = 199;
	  section.data(200).dtTransOffset = 13394;
	
	  ;% rtP.Filter_gainval_co4xba2jqf
	  section.data(201).logicalSrcIdx = 200;
	  section.data(201).dtTransOffset = 13395;
	
	  ;% rtP.Filter_IC_p3kdre121u
	  section.data(202).logicalSrcIdx = 201;
	  section.data(202).dtTransOffset = 13396;
	
	  ;% rtP.Integrator_gainval_gqr3gqi4ub
	  section.data(203).logicalSrcIdx = 202;
	  section.data(203).dtTransOffset = 13397;
	
	  ;% rtP.Integrator_IC_cmwijt2akl
	  section.data(204).logicalSrcIdx = 203;
	  section.data(204).dtTransOffset = 13398;
	
	  ;% rtP.Filter_gainval_myy1pyo1pd
	  section.data(205).logicalSrcIdx = 204;
	  section.data(205).dtTransOffset = 13399;
	
	  ;% rtP.Filter_IC_mgzzcjwpyo
	  section.data(206).logicalSrcIdx = 205;
	  section.data(206).dtTransOffset = 13400;
	
	  ;% rtP.Integrator_gainval_ff52akqi2m
	  section.data(207).logicalSrcIdx = 206;
	  section.data(207).dtTransOffset = 13401;
	
	  ;% rtP.Integrator_IC_meh24nj4ua
	  section.data(208).logicalSrcIdx = 207;
	  section.data(208).dtTransOffset = 13402;
	
	  ;% rtP.Filter_gainval_gf3ycazftg
	  section.data(209).logicalSrcIdx = 208;
	  section.data(209).dtTransOffset = 13403;
	
	  ;% rtP.Filter_IC_ogsi1v33nz
	  section.data(210).logicalSrcIdx = 209;
	  section.data(210).dtTransOffset = 13404;
	
	  ;% rtP.Integrator_gainval_bcqy0tshcf
	  section.data(211).logicalSrcIdx = 210;
	  section.data(211).dtTransOffset = 13405;
	
	  ;% rtP.Integrator_IC_nbz1q43elg
	  section.data(212).logicalSrcIdx = 211;
	  section.data(212).dtTransOffset = 13406;
	
	  ;% rtP.Filter_gainval_k1mt3edj2j
	  section.data(213).logicalSrcIdx = 212;
	  section.data(213).dtTransOffset = 13407;
	
	  ;% rtP.Filter_IC_ldt5vepls2
	  section.data(214).logicalSrcIdx = 213;
	  section.data(214).dtTransOffset = 13408;
	
	  ;% rtP.Integrator_gainval_ndev1o4rdy
	  section.data(215).logicalSrcIdx = 214;
	  section.data(215).dtTransOffset = 13409;
	
	  ;% rtP.Integrator_IC_bww41n1t1i
	  section.data(216).logicalSrcIdx = 215;
	  section.data(216).dtTransOffset = 13410;
	
	  ;% rtP.Filter_gainval_c11rgbo02g
	  section.data(217).logicalSrcIdx = 216;
	  section.data(217).dtTransOffset = 13411;
	
	  ;% rtP.Filter_IC_gek0ttwb4z
	  section.data(218).logicalSrcIdx = 217;
	  section.data(218).dtTransOffset = 13412;
	
	  ;% rtP.Integrator_gainval_gqaeme5oaa
	  section.data(219).logicalSrcIdx = 218;
	  section.data(219).dtTransOffset = 13413;
	
	  ;% rtP.Integrator_IC_g43inwfxpz
	  section.data(220).logicalSrcIdx = 219;
	  section.data(220).dtTransOffset = 13414;
	
	  ;% rtP.Filter_gainval_dmx4hb14ky
	  section.data(221).logicalSrcIdx = 220;
	  section.data(221).dtTransOffset = 13415;
	
	  ;% rtP.Filter_IC_fuqdxa0m3k
	  section.data(222).logicalSrcIdx = 221;
	  section.data(222).dtTransOffset = 13416;
	
	  ;% rtP.Integrator_gainval_pimfptv5nd
	  section.data(223).logicalSrcIdx = 222;
	  section.data(223).dtTransOffset = 13417;
	
	  ;% rtP.Integrator_IC_i1slja0c5c
	  section.data(224).logicalSrcIdx = 223;
	  section.data(224).dtTransOffset = 13418;
	
	  ;% rtP.Filter_gainval_fbcwmq4nwd
	  section.data(225).logicalSrcIdx = 224;
	  section.data(225).dtTransOffset = 13419;
	
	  ;% rtP.Filter_IC_hfxt3zlbjp
	  section.data(226).logicalSrcIdx = 225;
	  section.data(226).dtTransOffset = 13420;
	
	  ;% rtP.Integrator_gainval_l2obg2geuu
	  section.data(227).logicalSrcIdx = 226;
	  section.data(227).dtTransOffset = 13421;
	
	  ;% rtP.Integrator_IC_lcfomp00ph
	  section.data(228).logicalSrcIdx = 227;
	  section.data(228).dtTransOffset = 13422;
	
	  ;% rtP.Filter_gainval_h20qjvkauk
	  section.data(229).logicalSrcIdx = 228;
	  section.data(229).dtTransOffset = 13423;
	
	  ;% rtP.Filter_IC_m5q2bx1ebr
	  section.data(230).logicalSrcIdx = 229;
	  section.data(230).dtTransOffset = 13424;
	
	  ;% rtP.Gain_Gain_jy54xabawu
	  section.data(231).logicalSrcIdx = 230;
	  section.data(231).dtTransOffset = 13425;
	
	  ;% rtP.Gain1_Gain
	  section.data(232).logicalSrcIdx = 231;
	  section.data(232).dtTransOffset = 13426;
	
	  ;% rtP.Merge_InitialOutput
	  section.data(233).logicalSrcIdx = 232;
	  section.data(233).dtTransOffset = 13427;
	
	  ;% rtP.Gain_Gain_bmrbtbsnvc
	  section.data(234).logicalSrcIdx = 233;
	  section.data(234).dtTransOffset = 13428;
	
	  ;% rtP.Gain1_Gain_ppizddhejj
	  section.data(235).logicalSrcIdx = 234;
	  section.data(235).dtTransOffset = 13429;
	
	  ;% rtP.Merge_InitialOutput_cv4lkc4gj2
	  section.data(236).logicalSrcIdx = 235;
	  section.data(236).dtTransOffset = 13430;
	
	  ;% rtP.Gain_Gain_iuc2toppf0
	  section.data(237).logicalSrcIdx = 236;
	  section.data(237).dtTransOffset = 13431;
	
	  ;% rtP.Gain1_Gain_jtedsrlia2
	  section.data(238).logicalSrcIdx = 237;
	  section.data(238).dtTransOffset = 13432;
	
	  ;% rtP.Merge_InitialOutput_kaltuseyfw
	  section.data(239).logicalSrcIdx = 238;
	  section.data(239).dtTransOffset = 13433;
	
	  ;% rtP.Gain_Gain_ijdttrp3hc
	  section.data(240).logicalSrcIdx = 239;
	  section.data(240).dtTransOffset = 13434;
	
	  ;% rtP.Gain1_Gain_aunol2sfew
	  section.data(241).logicalSrcIdx = 240;
	  section.data(241).dtTransOffset = 13435;
	
	  ;% rtP.Merge_InitialOutput_gyk43eq3d3
	  section.data(242).logicalSrcIdx = 241;
	  section.data(242).dtTransOffset = 13436;
	
	  ;% rtP.Gain_Gain_ero3ok42ie
	  section.data(243).logicalSrcIdx = 242;
	  section.data(243).dtTransOffset = 13437;
	
	  ;% rtP.Gain1_Gain_jv2el0ecs4
	  section.data(244).logicalSrcIdx = 243;
	  section.data(244).dtTransOffset = 13438;
	
	  ;% rtP.Merge_InitialOutput_bxo0rpp3mx
	  section.data(245).logicalSrcIdx = 244;
	  section.data(245).dtTransOffset = 13439;
	
	  ;% rtP.Gain_Gain_fk5czf5445
	  section.data(246).logicalSrcIdx = 245;
	  section.data(246).dtTransOffset = 13440;
	
	  ;% rtP.Gain1_Gain_ntvdie1u1c
	  section.data(247).logicalSrcIdx = 246;
	  section.data(247).dtTransOffset = 13441;
	
	  ;% rtP.Merge_InitialOutput_f0qm3rm2is
	  section.data(248).logicalSrcIdx = 247;
	  section.data(248).dtTransOffset = 13442;
	
	  ;% rtP.Gain_Gain_b44rzz02hp
	  section.data(249).logicalSrcIdx = 248;
	  section.data(249).dtTransOffset = 13443;
	
	  ;% rtP.Gain1_Gain_piugqgd2ex
	  section.data(250).logicalSrcIdx = 249;
	  section.data(250).dtTransOffset = 13444;
	
	  ;% rtP.Merge_InitialOutput_nshcrh0sfl
	  section.data(251).logicalSrcIdx = 250;
	  section.data(251).dtTransOffset = 13445;
	
	  ;% rtP.Gain_Gain_lqxsvyzd2i
	  section.data(252).logicalSrcIdx = 251;
	  section.data(252).dtTransOffset = 13446;
	
	  ;% rtP.Gain1_Gain_mzaz0olyoj
	  section.data(253).logicalSrcIdx = 252;
	  section.data(253).dtTransOffset = 13447;
	
	  ;% rtP.Merge_InitialOutput_op0wcflm2s
	  section.data(254).logicalSrcIdx = 253;
	  section.data(254).dtTransOffset = 13448;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(1) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (parameter)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    paramMap.nTotData = nTotData;
    


  ;%**************************
  ;% Create Block Output Map *
  ;%**************************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 1;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc sigMap
    ;%
    sigMap.nSections           = nTotSects;
    sigMap.sectIdxOffset       = sectIdxOffset;
      sigMap.sections(nTotSects) = dumSection; %prealloc
    sigMap.nTotData            = -1;
    
    ;%
    ;% Auto data (rtB)
    ;%
      section.nData     = 180;
      section.data(180)  = dumData; %prealloc
      
	  ;% rtB.hcn0vr3hrb
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtB.hirofycrgd
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 37;
	
	  ;% rtB.f15jrdigju
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 38;
	
	  ;% rtB.plzba5xetw
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 39;
	
	  ;% rtB.ltlawl3zl2
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 40;
	
	  ;% rtB.icjj41xko1
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 41;
	
	  ;% rtB.bll3bfmp2n
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 45;
	
	  ;% rtB.cczaczycq0
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 46;
	
	  ;% rtB.lf1bhpswdt
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 47;
	
	  ;% rtB.da4tevmyov
	  section.data(10).logicalSrcIdx = 9;
	  section.data(10).dtTransOffset = 48;
	
	  ;% rtB.bddzgzvr53
	  section.data(11).logicalSrcIdx = 10;
	  section.data(11).dtTransOffset = 49;
	
	  ;% rtB.pumjpl1iz3
	  section.data(12).logicalSrcIdx = 11;
	  section.data(12).dtTransOffset = 53;
	
	  ;% rtB.dgtinquxjx
	  section.data(13).logicalSrcIdx = 12;
	  section.data(13).dtTransOffset = 54;
	
	  ;% rtB.b3z4fdw5br
	  section.data(14).logicalSrcIdx = 13;
	  section.data(14).dtTransOffset = 55;
	
	  ;% rtB.e2c4l02dhq
	  section.data(15).logicalSrcIdx = 14;
	  section.data(15).dtTransOffset = 56;
	
	  ;% rtB.bjm5zfyi2p
	  section.data(16).logicalSrcIdx = 15;
	  section.data(16).dtTransOffset = 57;
	
	  ;% rtB.ibfpcqphrk
	  section.data(17).logicalSrcIdx = 16;
	  section.data(17).dtTransOffset = 61;
	
	  ;% rtB.b5kppw1udq
	  section.data(18).logicalSrcIdx = 17;
	  section.data(18).dtTransOffset = 62;
	
	  ;% rtB.oyzivx31me
	  section.data(19).logicalSrcIdx = 18;
	  section.data(19).dtTransOffset = 63;
	
	  ;% rtB.mddmixolpo
	  section.data(20).logicalSrcIdx = 19;
	  section.data(20).dtTransOffset = 64;
	
	  ;% rtB.jghoxy31b2
	  section.data(21).logicalSrcIdx = 20;
	  section.data(21).dtTransOffset = 65;
	
	  ;% rtB.cfc3apm4kh
	  section.data(22).logicalSrcIdx = 21;
	  section.data(22).dtTransOffset = 69;
	
	  ;% rtB.fqudttndmi
	  section.data(23).logicalSrcIdx = 22;
	  section.data(23).dtTransOffset = 70;
	
	  ;% rtB.f2brllrz2t
	  section.data(24).logicalSrcIdx = 23;
	  section.data(24).dtTransOffset = 71;
	
	  ;% rtB.n55lttunsa
	  section.data(25).logicalSrcIdx = 24;
	  section.data(25).dtTransOffset = 72;
	
	  ;% rtB.htfzgr0fqb
	  section.data(26).logicalSrcIdx = 25;
	  section.data(26).dtTransOffset = 73;
	
	  ;% rtB.p1wjg0fojr
	  section.data(27).logicalSrcIdx = 26;
	  section.data(27).dtTransOffset = 77;
	
	  ;% rtB.damqqzjunx
	  section.data(28).logicalSrcIdx = 27;
	  section.data(28).dtTransOffset = 78;
	
	  ;% rtB.pb0bia40m5
	  section.data(29).logicalSrcIdx = 28;
	  section.data(29).dtTransOffset = 79;
	
	  ;% rtB.hc4i5txchl
	  section.data(30).logicalSrcIdx = 29;
	  section.data(30).dtTransOffset = 80;
	
	  ;% rtB.jvbpoufbbd
	  section.data(31).logicalSrcIdx = 30;
	  section.data(31).dtTransOffset = 81;
	
	  ;% rtB.efk2iiw0ov
	  section.data(32).logicalSrcIdx = 31;
	  section.data(32).dtTransOffset = 85;
	
	  ;% rtB.igs4bb2doo
	  section.data(33).logicalSrcIdx = 32;
	  section.data(33).dtTransOffset = 86;
	
	  ;% rtB.oyeq1voio0
	  section.data(34).logicalSrcIdx = 33;
	  section.data(34).dtTransOffset = 87;
	
	  ;% rtB.czjlkkyvni
	  section.data(35).logicalSrcIdx = 34;
	  section.data(35).dtTransOffset = 88;
	
	  ;% rtB.he0uzvgiq4
	  section.data(36).logicalSrcIdx = 35;
	  section.data(36).dtTransOffset = 89;
	
	  ;% rtB.c1qyllbctc
	  section.data(37).logicalSrcIdx = 36;
	  section.data(37).dtTransOffset = 93;
	
	  ;% rtB.aulxa5mhm0
	  section.data(38).logicalSrcIdx = 37;
	  section.data(38).dtTransOffset = 94;
	
	  ;% rtB.nvpozvuyxb
	  section.data(39).logicalSrcIdx = 38;
	  section.data(39).dtTransOffset = 95;
	
	  ;% rtB.gozxlvfkh4
	  section.data(40).logicalSrcIdx = 39;
	  section.data(40).dtTransOffset = 96;
	
	  ;% rtB.mtoj0nmwvf
	  section.data(41).logicalSrcIdx = 40;
	  section.data(41).dtTransOffset = 97;
	
	  ;% rtB.jzpii3usrp
	  section.data(42).logicalSrcIdx = 41;
	  section.data(42).dtTransOffset = 101;
	
	  ;% rtB.oprozhx4uj
	  section.data(43).logicalSrcIdx = 42;
	  section.data(43).dtTransOffset = 102;
	
	  ;% rtB.ocxovvwljm
	  section.data(44).logicalSrcIdx = 43;
	  section.data(44).dtTransOffset = 103;
	
	  ;% rtB.ezdfpaqxwq
	  section.data(45).logicalSrcIdx = 44;
	  section.data(45).dtTransOffset = 104;
	
	  ;% rtB.bfj2j53qzs
	  section.data(46).logicalSrcIdx = 45;
	  section.data(46).dtTransOffset = 105;
	
	  ;% rtB.i5dohkj3yv
	  section.data(47).logicalSrcIdx = 46;
	  section.data(47).dtTransOffset = 109;
	
	  ;% rtB.aux52fnarx
	  section.data(48).logicalSrcIdx = 47;
	  section.data(48).dtTransOffset = 110;
	
	  ;% rtB.ookzcukj2c
	  section.data(49).logicalSrcIdx = 48;
	  section.data(49).dtTransOffset = 111;
	
	  ;% rtB.d5ospm2ziz
	  section.data(50).logicalSrcIdx = 49;
	  section.data(50).dtTransOffset = 112;
	
	  ;% rtB.jr34w0xked
	  section.data(51).logicalSrcIdx = 50;
	  section.data(51).dtTransOffset = 113;
	
	  ;% rtB.cllitsyo15
	  section.data(52).logicalSrcIdx = 51;
	  section.data(52).dtTransOffset = 117;
	
	  ;% rtB.k0q4r5jemu
	  section.data(53).logicalSrcIdx = 52;
	  section.data(53).dtTransOffset = 118;
	
	  ;% rtB.bkehlboqlu
	  section.data(54).logicalSrcIdx = 53;
	  section.data(54).dtTransOffset = 119;
	
	  ;% rtB.p4v0hi0b2s
	  section.data(55).logicalSrcIdx = 54;
	  section.data(55).dtTransOffset = 120;
	
	  ;% rtB.f5wlbbkruv
	  section.data(56).logicalSrcIdx = 55;
	  section.data(56).dtTransOffset = 121;
	
	  ;% rtB.hiecn3kddh
	  section.data(57).logicalSrcIdx = 56;
	  section.data(57).dtTransOffset = 125;
	
	  ;% rtB.cnk1to5unp
	  section.data(58).logicalSrcIdx = 57;
	  section.data(58).dtTransOffset = 126;
	
	  ;% rtB.kmbi1yokhc
	  section.data(59).logicalSrcIdx = 58;
	  section.data(59).dtTransOffset = 127;
	
	  ;% rtB.j3dl4fqu4m
	  section.data(60).logicalSrcIdx = 59;
	  section.data(60).dtTransOffset = 128;
	
	  ;% rtB.j5hezzhpad
	  section.data(61).logicalSrcIdx = 60;
	  section.data(61).dtTransOffset = 129;
	
	  ;% rtB.akkxndlybg
	  section.data(62).logicalSrcIdx = 61;
	  section.data(62).dtTransOffset = 133;
	
	  ;% rtB.coziykkuqi
	  section.data(63).logicalSrcIdx = 62;
	  section.data(63).dtTransOffset = 145;
	
	  ;% rtB.hwcmaul234
	  section.data(64).logicalSrcIdx = 63;
	  section.data(64).dtTransOffset = 149;
	
	  ;% rtB.kbxyuobcjk
	  section.data(65).logicalSrcIdx = 64;
	  section.data(65).dtTransOffset = 153;
	
	  ;% rtB.h0ni3fybzq
	  section.data(66).logicalSrcIdx = 65;
	  section.data(66).dtTransOffset = 157;
	
	  ;% rtB.eljaixri3a
	  section.data(67).logicalSrcIdx = 66;
	  section.data(67).dtTransOffset = 161;
	
	  ;% rtB.dgxetmwkoy
	  section.data(68).logicalSrcIdx = 67;
	  section.data(68).dtTransOffset = 165;
	
	  ;% rtB.f1dizuz3z4
	  section.data(69).logicalSrcIdx = 68;
	  section.data(69).dtTransOffset = 169;
	
	  ;% rtB.obazgkleqv
	  section.data(70).logicalSrcIdx = 69;
	  section.data(70).dtTransOffset = 173;
	
	  ;% rtB.hhdmw0xwdk
	  section.data(71).logicalSrcIdx = 70;
	  section.data(71).dtTransOffset = 177;
	
	  ;% rtB.pegr1geol5
	  section.data(72).logicalSrcIdx = 71;
	  section.data(72).dtTransOffset = 181;
	
	  ;% rtB.kznmwyizmk
	  section.data(73).logicalSrcIdx = 72;
	  section.data(73).dtTransOffset = 185;
	
	  ;% rtB.dsqdpjrpzo
	  section.data(74).logicalSrcIdx = 73;
	  section.data(74).dtTransOffset = 189;
	
	  ;% rtB.hqjzysrp0o
	  section.data(75).logicalSrcIdx = 74;
	  section.data(75).dtTransOffset = 193;
	
	  ;% rtB.dip225nbil
	  section.data(76).logicalSrcIdx = 75;
	  section.data(76).dtTransOffset = 205;
	
	  ;% rtB.lp0ndtxrmy
	  section.data(77).logicalSrcIdx = 76;
	  section.data(77).dtTransOffset = 209;
	
	  ;% rtB.mvu5v1khjn
	  section.data(78).logicalSrcIdx = 77;
	  section.data(78).dtTransOffset = 213;
	
	  ;% rtB.ku2hum1get
	  section.data(79).logicalSrcIdx = 78;
	  section.data(79).dtTransOffset = 217;
	
	  ;% rtB.jcygb1tz0u
	  section.data(80).logicalSrcIdx = 79;
	  section.data(80).dtTransOffset = 221;
	
	  ;% rtB.egbnbk3g42
	  section.data(81).logicalSrcIdx = 80;
	  section.data(81).dtTransOffset = 225;
	
	  ;% rtB.ebtf2snkfg
	  section.data(82).logicalSrcIdx = 81;
	  section.data(82).dtTransOffset = 229;
	
	  ;% rtB.ap2tyugwz4
	  section.data(83).logicalSrcIdx = 82;
	  section.data(83).dtTransOffset = 233;
	
	  ;% rtB.jm1aduj4pi
	  section.data(84).logicalSrcIdx = 83;
	  section.data(84).dtTransOffset = 237;
	
	  ;% rtB.j3pswqxend
	  section.data(85).logicalSrcIdx = 84;
	  section.data(85).dtTransOffset = 241;
	
	  ;% rtB.m0zla30rqt
	  section.data(86).logicalSrcIdx = 85;
	  section.data(86).dtTransOffset = 245;
	
	  ;% rtB.ezg2vo2pme
	  section.data(87).logicalSrcIdx = 86;
	  section.data(87).dtTransOffset = 249;
	
	  ;% rtB.ooxxuddjzn
	  section.data(88).logicalSrcIdx = 87;
	  section.data(88).dtTransOffset = 253;
	
	  ;% rtB.k0pjiwt14c
	  section.data(89).logicalSrcIdx = 88;
	  section.data(89).dtTransOffset = 265;
	
	  ;% rtB.llxdl5yagg
	  section.data(90).logicalSrcIdx = 89;
	  section.data(90).dtTransOffset = 269;
	
	  ;% rtB.kf4x2h0ral
	  section.data(91).logicalSrcIdx = 90;
	  section.data(91).dtTransOffset = 273;
	
	  ;% rtB.pdd1mqg0rx
	  section.data(92).logicalSrcIdx = 91;
	  section.data(92).dtTransOffset = 277;
	
	  ;% rtB.pkt31xp3rr
	  section.data(93).logicalSrcIdx = 92;
	  section.data(93).dtTransOffset = 281;
	
	  ;% rtB.llfy2nkhv0
	  section.data(94).logicalSrcIdx = 93;
	  section.data(94).dtTransOffset = 285;
	
	  ;% rtB.o5pyvdx1af
	  section.data(95).logicalSrcIdx = 94;
	  section.data(95).dtTransOffset = 289;
	
	  ;% rtB.bqrctq31wi
	  section.data(96).logicalSrcIdx = 95;
	  section.data(96).dtTransOffset = 293;
	
	  ;% rtB.bvyltbpjrl
	  section.data(97).logicalSrcIdx = 96;
	  section.data(97).dtTransOffset = 297;
	
	  ;% rtB.nvts4hgsyu
	  section.data(98).logicalSrcIdx = 97;
	  section.data(98).dtTransOffset = 301;
	
	  ;% rtB.d0tciblvl5
	  section.data(99).logicalSrcIdx = 98;
	  section.data(99).dtTransOffset = 305;
	
	  ;% rtB.jkxeohk4c0
	  section.data(100).logicalSrcIdx = 99;
	  section.data(100).dtTransOffset = 309;
	
	  ;% rtB.cwkocrv14d
	  section.data(101).logicalSrcIdx = 100;
	  section.data(101).dtTransOffset = 313;
	
	  ;% rtB.jlddt3t3mt
	  section.data(102).logicalSrcIdx = 101;
	  section.data(102).dtTransOffset = 325;
	
	  ;% rtB.cl0p0sxxrt
	  section.data(103).logicalSrcIdx = 102;
	  section.data(103).dtTransOffset = 329;
	
	  ;% rtB.nn0cl132uw
	  section.data(104).logicalSrcIdx = 103;
	  section.data(104).dtTransOffset = 333;
	
	  ;% rtB.epzh0otr5p
	  section.data(105).logicalSrcIdx = 104;
	  section.data(105).dtTransOffset = 337;
	
	  ;% rtB.hxymay2z11
	  section.data(106).logicalSrcIdx = 105;
	  section.data(106).dtTransOffset = 341;
	
	  ;% rtB.cn0cfee4bb
	  section.data(107).logicalSrcIdx = 106;
	  section.data(107).dtTransOffset = 345;
	
	  ;% rtB.fwv1uc0cwn
	  section.data(108).logicalSrcIdx = 107;
	  section.data(108).dtTransOffset = 349;
	
	  ;% rtB.aquqpgfvx1
	  section.data(109).logicalSrcIdx = 108;
	  section.data(109).dtTransOffset = 353;
	
	  ;% rtB.ip541s2scn
	  section.data(110).logicalSrcIdx = 109;
	  section.data(110).dtTransOffset = 357;
	
	  ;% rtB.dx4p2e0tun
	  section.data(111).logicalSrcIdx = 110;
	  section.data(111).dtTransOffset = 361;
	
	  ;% rtB.hewydbdvhu
	  section.data(112).logicalSrcIdx = 111;
	  section.data(112).dtTransOffset = 365;
	
	  ;% rtB.i0hu5id3uf
	  section.data(113).logicalSrcIdx = 112;
	  section.data(113).dtTransOffset = 369;
	
	  ;% rtB.hk1jxsynrf
	  section.data(114).logicalSrcIdx = 113;
	  section.data(114).dtTransOffset = 373;
	
	  ;% rtB.nvhecxknk2
	  section.data(115).logicalSrcIdx = 114;
	  section.data(115).dtTransOffset = 385;
	
	  ;% rtB.mhfhxoxo00
	  section.data(116).logicalSrcIdx = 115;
	  section.data(116).dtTransOffset = 389;
	
	  ;% rtB.cwiqwfetne
	  section.data(117).logicalSrcIdx = 116;
	  section.data(117).dtTransOffset = 393;
	
	  ;% rtB.na3ldgyvul
	  section.data(118).logicalSrcIdx = 117;
	  section.data(118).dtTransOffset = 397;
	
	  ;% rtB.c5z1ptw2wd
	  section.data(119).logicalSrcIdx = 118;
	  section.data(119).dtTransOffset = 401;
	
	  ;% rtB.of4ol0qicb
	  section.data(120).logicalSrcIdx = 119;
	  section.data(120).dtTransOffset = 405;
	
	  ;% rtB.iaoqkoobth
	  section.data(121).logicalSrcIdx = 120;
	  section.data(121).dtTransOffset = 409;
	
	  ;% rtB.dmor0gezf4
	  section.data(122).logicalSrcIdx = 121;
	  section.data(122).dtTransOffset = 413;
	
	  ;% rtB.luzgrksahm
	  section.data(123).logicalSrcIdx = 122;
	  section.data(123).dtTransOffset = 417;
	
	  ;% rtB.od4hjpwcnz
	  section.data(124).logicalSrcIdx = 123;
	  section.data(124).dtTransOffset = 421;
	
	  ;% rtB.idzios2gah
	  section.data(125).logicalSrcIdx = 124;
	  section.data(125).dtTransOffset = 425;
	
	  ;% rtB.jj2mruweoc
	  section.data(126).logicalSrcIdx = 125;
	  section.data(126).dtTransOffset = 429;
	
	  ;% rtB.po4ormommn
	  section.data(127).logicalSrcIdx = 126;
	  section.data(127).dtTransOffset = 433;
	
	  ;% rtB.iq55oinoq4
	  section.data(128).logicalSrcIdx = 127;
	  section.data(128).dtTransOffset = 445;
	
	  ;% rtB.ck5ncn4amd
	  section.data(129).logicalSrcIdx = 128;
	  section.data(129).dtTransOffset = 449;
	
	  ;% rtB.cvgmmj1beh
	  section.data(130).logicalSrcIdx = 129;
	  section.data(130).dtTransOffset = 453;
	
	  ;% rtB.dfvagmnyrb
	  section.data(131).logicalSrcIdx = 130;
	  section.data(131).dtTransOffset = 457;
	
	  ;% rtB.om2b1cgxhe
	  section.data(132).logicalSrcIdx = 131;
	  section.data(132).dtTransOffset = 461;
	
	  ;% rtB.ekl05ku2is
	  section.data(133).logicalSrcIdx = 132;
	  section.data(133).dtTransOffset = 465;
	
	  ;% rtB.oeckpgl25a
	  section.data(134).logicalSrcIdx = 133;
	  section.data(134).dtTransOffset = 469;
	
	  ;% rtB.ommyumni3p
	  section.data(135).logicalSrcIdx = 134;
	  section.data(135).dtTransOffset = 473;
	
	  ;% rtB.awz3kuon0w
	  section.data(136).logicalSrcIdx = 135;
	  section.data(136).dtTransOffset = 477;
	
	  ;% rtB.pzlba0d4w2
	  section.data(137).logicalSrcIdx = 136;
	  section.data(137).dtTransOffset = 481;
	
	  ;% rtB.kotayvoaeh
	  section.data(138).logicalSrcIdx = 137;
	  section.data(138).dtTransOffset = 485;
	
	  ;% rtB.ezfzkf4rue
	  section.data(139).logicalSrcIdx = 138;
	  section.data(139).dtTransOffset = 489;
	
	  ;% rtB.h4klzmyf4l
	  section.data(140).logicalSrcIdx = 139;
	  section.data(140).dtTransOffset = 493;
	
	  ;% rtB.nptbxbpbxv
	  section.data(141).logicalSrcIdx = 140;
	  section.data(141).dtTransOffset = 505;
	
	  ;% rtB.no5llqvwyu
	  section.data(142).logicalSrcIdx = 141;
	  section.data(142).dtTransOffset = 509;
	
	  ;% rtB.f3c0yfgvle
	  section.data(143).logicalSrcIdx = 142;
	  section.data(143).dtTransOffset = 513;
	
	  ;% rtB.glgo00yn35
	  section.data(144).logicalSrcIdx = 143;
	  section.data(144).dtTransOffset = 517;
	
	  ;% rtB.optfn1mlz5
	  section.data(145).logicalSrcIdx = 144;
	  section.data(145).dtTransOffset = 521;
	
	  ;% rtB.ifcf5dwz5c
	  section.data(146).logicalSrcIdx = 145;
	  section.data(146).dtTransOffset = 525;
	
	  ;% rtB.lf02vagcax
	  section.data(147).logicalSrcIdx = 146;
	  section.data(147).dtTransOffset = 529;
	
	  ;% rtB.fyc3luoktb
	  section.data(148).logicalSrcIdx = 147;
	  section.data(148).dtTransOffset = 533;
	
	  ;% rtB.p0iqwscudm
	  section.data(149).logicalSrcIdx = 148;
	  section.data(149).dtTransOffset = 537;
	
	  ;% rtB.cgxdbwjuxa
	  section.data(150).logicalSrcIdx = 149;
	  section.data(150).dtTransOffset = 541;
	
	  ;% rtB.aetr1m5rad
	  section.data(151).logicalSrcIdx = 150;
	  section.data(151).dtTransOffset = 545;
	
	  ;% rtB.djoyvkd3ha
	  section.data(152).logicalSrcIdx = 151;
	  section.data(152).dtTransOffset = 549;
	
	  ;% rtB.chm5ppnkcf
	  section.data(153).logicalSrcIdx = 152;
	  section.data(153).dtTransOffset = 553;
	
	  ;% rtB.ik3dg14iiy
	  section.data(154).logicalSrcIdx = 153;
	  section.data(154).dtTransOffset = 565;
	
	  ;% rtB.hbbzeec1yl
	  section.data(155).logicalSrcIdx = 154;
	  section.data(155).dtTransOffset = 569;
	
	  ;% rtB.lqdjsaxyqg
	  section.data(156).logicalSrcIdx = 155;
	  section.data(156).dtTransOffset = 573;
	
	  ;% rtB.kilzhag4qk
	  section.data(157).logicalSrcIdx = 156;
	  section.data(157).dtTransOffset = 577;
	
	  ;% rtB.oetcdow2cd
	  section.data(158).logicalSrcIdx = 157;
	  section.data(158).dtTransOffset = 581;
	
	  ;% rtB.bzoaxjvik0
	  section.data(159).logicalSrcIdx = 158;
	  section.data(159).dtTransOffset = 585;
	
	  ;% rtB.oekt5zyxgd
	  section.data(160).logicalSrcIdx = 159;
	  section.data(160).dtTransOffset = 589;
	
	  ;% rtB.gxzf2jnsuw
	  section.data(161).logicalSrcIdx = 160;
	  section.data(161).dtTransOffset = 593;
	
	  ;% rtB.pg34btjn3a
	  section.data(162).logicalSrcIdx = 161;
	  section.data(162).dtTransOffset = 597;
	
	  ;% rtB.a4ft2gzfhl
	  section.data(163).logicalSrcIdx = 162;
	  section.data(163).dtTransOffset = 601;
	
	  ;% rtB.hbyhxtzifu
	  section.data(164).logicalSrcIdx = 163;
	  section.data(164).dtTransOffset = 605;
	
	  ;% rtB.dl30qitgaz
	  section.data(165).logicalSrcIdx = 164;
	  section.data(165).dtTransOffset = 609;
	
	  ;% rtB.n23b5o5l5r
	  section.data(166).logicalSrcIdx = 165;
	  section.data(166).dtTransOffset = 613;
	
	  ;% rtB.ltar5dh2p4
	  section.data(167).logicalSrcIdx = 166;
	  section.data(167).dtTransOffset = 619;
	
	  ;% rtB.ezydxetdbq
	  section.data(168).logicalSrcIdx = 167;
	  section.data(168).dtTransOffset = 625;
	
	  ;% rtB.fl35nhqpjg
	  section.data(169).logicalSrcIdx = 168;
	  section.data(169).dtTransOffset = 626;
	
	  ;% rtB.iny3zs1fef
	  section.data(170).logicalSrcIdx = 169;
	  section.data(170).dtTransOffset = 627;
	
	  ;% rtB.hfuapnrn5g
	  section.data(171).logicalSrcIdx = 170;
	  section.data(171).dtTransOffset = 628;
	
	  ;% rtB.kzksgdh05c
	  section.data(172).logicalSrcIdx = 171;
	  section.data(172).dtTransOffset = 629;
	
	  ;% rtB.lgesuqespu
	  section.data(173).logicalSrcIdx = 172;
	  section.data(173).dtTransOffset = 630;
	
	  ;% rtB.f0jsjllutl
	  section.data(174).logicalSrcIdx = 173;
	  section.data(174).dtTransOffset = 631;
	
	  ;% rtB.dvbwbilkmt
	  section.data(175).logicalSrcIdx = 174;
	  section.data(175).dtTransOffset = 632;
	
	  ;% rtB.mb1izqi0rw
	  section.data(176).logicalSrcIdx = 175;
	  section.data(176).dtTransOffset = 633;
	
	  ;% rtB.lrsqiah4fu
	  section.data(177).logicalSrcIdx = 176;
	  section.data(177).dtTransOffset = 634;
	
	  ;% rtB.hkp3rznuma
	  section.data(178).logicalSrcIdx = 177;
	  section.data(178).dtTransOffset = 635;
	
	  ;% rtB.bha15gnhws
	  section.data(179).logicalSrcIdx = 178;
	  section.data(179).dtTransOffset = 636;
	
	  ;% rtB.jjihh4cnz0
	  section.data(180).logicalSrcIdx = 179;
	  section.data(180).dtTransOffset = 637;
	
      nTotData = nTotData + section.nData;
      sigMap.sections(1) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (signal)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    sigMap.nTotData = nTotData;
    


  ;%*******************
  ;% Create DWork Map *
  ;%*******************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 5;
    sectIdxOffset = 1;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc dworkMap
    ;%
    dworkMap.nSections           = nTotSects;
    dworkMap.sectIdxOffset       = sectIdxOffset;
      dworkMap.sections(nTotSects) = dumSection; %prealloc
    dworkMap.nTotData            = -1;
    
    ;%
    ;% Auto data (rtDW)
    ;%
      section.nData     = 132;
      section.data(132)  = dumData; %prealloc
      
	  ;% rtDW.nrqz0hdmpx
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.a5cfv2cjwi
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtDW.dltffxicte
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtDW.nxtvkj2h0b
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 4;
	
	  ;% rtDW.lyfxe32vch
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 5;
	
	  ;% rtDW.cx2fmuslsj
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 6;
	
	  ;% rtDW.e22dcccb23
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 8;
	
	  ;% rtDW.hpipwy3knf
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 9;
	
	  ;% rtDW.f1w5x3avvm
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 10;
	
	  ;% rtDW.mwmf3c0oij
	  section.data(10).logicalSrcIdx = 9;
	  section.data(10).dtTransOffset = 12;
	
	  ;% rtDW.f4kpzqdlkb
	  section.data(11).logicalSrcIdx = 10;
	  section.data(11).dtTransOffset = 13;
	
	  ;% rtDW.elwqmmemou
	  section.data(12).logicalSrcIdx = 11;
	  section.data(12).dtTransOffset = 14;
	
	  ;% rtDW.jzmxej1cmf
	  section.data(13).logicalSrcIdx = 12;
	  section.data(13).dtTransOffset = 16;
	
	  ;% rtDW.l2m2brv32h
	  section.data(14).logicalSrcIdx = 13;
	  section.data(14).dtTransOffset = 17;
	
	  ;% rtDW.djfg3zbkkx
	  section.data(15).logicalSrcIdx = 14;
	  section.data(15).dtTransOffset = 18;
	
	  ;% rtDW.ky5n1pbwy3
	  section.data(16).logicalSrcIdx = 15;
	  section.data(16).dtTransOffset = 20;
	
	  ;% rtDW.ev3aqevk3x
	  section.data(17).logicalSrcIdx = 16;
	  section.data(17).dtTransOffset = 21;
	
	  ;% rtDW.aibcwgnhdo
	  section.data(18).logicalSrcIdx = 17;
	  section.data(18).dtTransOffset = 22;
	
	  ;% rtDW.nnasep0gzx
	  section.data(19).logicalSrcIdx = 18;
	  section.data(19).dtTransOffset = 24;
	
	  ;% rtDW.azgzp351s3
	  section.data(20).logicalSrcIdx = 19;
	  section.data(20).dtTransOffset = 25;
	
	  ;% rtDW.l2lt0knr0e
	  section.data(21).logicalSrcIdx = 20;
	  section.data(21).dtTransOffset = 26;
	
	  ;% rtDW.g2xarhbhhu
	  section.data(22).logicalSrcIdx = 21;
	  section.data(22).dtTransOffset = 28;
	
	  ;% rtDW.lyeisq5fei
	  section.data(23).logicalSrcIdx = 22;
	  section.data(23).dtTransOffset = 29;
	
	  ;% rtDW.jr3jbag4zb
	  section.data(24).logicalSrcIdx = 23;
	  section.data(24).dtTransOffset = 30;
	
	  ;% rtDW.lxrbojnd12
	  section.data(25).logicalSrcIdx = 24;
	  section.data(25).dtTransOffset = 32;
	
	  ;% rtDW.e4uazoawm4
	  section.data(26).logicalSrcIdx = 25;
	  section.data(26).dtTransOffset = 33;
	
	  ;% rtDW.ev3pyicbhi
	  section.data(27).logicalSrcIdx = 26;
	  section.data(27).dtTransOffset = 34;
	
	  ;% rtDW.alxyshynhf
	  section.data(28).logicalSrcIdx = 27;
	  section.data(28).dtTransOffset = 36;
	
	  ;% rtDW.oug34r1kie
	  section.data(29).logicalSrcIdx = 28;
	  section.data(29).dtTransOffset = 37;
	
	  ;% rtDW.filr3vtyxc
	  section.data(30).logicalSrcIdx = 29;
	  section.data(30).dtTransOffset = 38;
	
	  ;% rtDW.d02izy4f0s
	  section.data(31).logicalSrcIdx = 30;
	  section.data(31).dtTransOffset = 40;
	
	  ;% rtDW.mu4yb1jzde
	  section.data(32).logicalSrcIdx = 31;
	  section.data(32).dtTransOffset = 41;
	
	  ;% rtDW.diob1xxhuj
	  section.data(33).logicalSrcIdx = 32;
	  section.data(33).dtTransOffset = 42;
	
	  ;% rtDW.mboxmfq03d
	  section.data(34).logicalSrcIdx = 33;
	  section.data(34).dtTransOffset = 44;
	
	  ;% rtDW.i4fyh1bjhw
	  section.data(35).logicalSrcIdx = 34;
	  section.data(35).dtTransOffset = 45;
	
	  ;% rtDW.jjrzedeio0
	  section.data(36).logicalSrcIdx = 35;
	  section.data(36).dtTransOffset = 46;
	
	  ;% rtDW.bpnextwfco
	  section.data(37).logicalSrcIdx = 36;
	  section.data(37).dtTransOffset = 48;
	
	  ;% rtDW.ltp54a525z
	  section.data(38).logicalSrcIdx = 37;
	  section.data(38).dtTransOffset = 50;
	
	  ;% rtDW.isgrx4illb
	  section.data(39).logicalSrcIdx = 38;
	  section.data(39).dtTransOffset = 52;
	
	  ;% rtDW.glfdolrfjb
	  section.data(40).logicalSrcIdx = 39;
	  section.data(40).dtTransOffset = 54;
	
	  ;% rtDW.jlsmhciyaq
	  section.data(41).logicalSrcIdx = 40;
	  section.data(41).dtTransOffset = 56;
	
	  ;% rtDW.om2iqx4kr1
	  section.data(42).logicalSrcIdx = 41;
	  section.data(42).dtTransOffset = 58;
	
	  ;% rtDW.pbzeshngkt
	  section.data(43).logicalSrcIdx = 42;
	  section.data(43).dtTransOffset = 60;
	
	  ;% rtDW.gewhfppc5m
	  section.data(44).logicalSrcIdx = 43;
	  section.data(44).dtTransOffset = 62;
	
	  ;% rtDW.hdtcyuju2y
	  section.data(45).logicalSrcIdx = 44;
	  section.data(45).dtTransOffset = 64;
	
	  ;% rtDW.pak4mvbvlr
	  section.data(46).logicalSrcIdx = 45;
	  section.data(46).dtTransOffset = 66;
	
	  ;% rtDW.p5hwv5zkug
	  section.data(47).logicalSrcIdx = 46;
	  section.data(47).dtTransOffset = 68;
	
	  ;% rtDW.hidrnstsqw
	  section.data(48).logicalSrcIdx = 47;
	  section.data(48).dtTransOffset = 70;
	
	  ;% rtDW.bwlepauqo4
	  section.data(49).logicalSrcIdx = 48;
	  section.data(49).dtTransOffset = 72;
	
	  ;% rtDW.pqdc3ui5li
	  section.data(50).logicalSrcIdx = 49;
	  section.data(50).dtTransOffset = 74;
	
	  ;% rtDW.lezth4paqi
	  section.data(51).logicalSrcIdx = 50;
	  section.data(51).dtTransOffset = 76;
	
	  ;% rtDW.mcgcdbw5z5
	  section.data(52).logicalSrcIdx = 51;
	  section.data(52).dtTransOffset = 78;
	
	  ;% rtDW.b3akyiibpd
	  section.data(53).logicalSrcIdx = 52;
	  section.data(53).dtTransOffset = 80;
	
	  ;% rtDW.mllubq5r3w
	  section.data(54).logicalSrcIdx = 53;
	  section.data(54).dtTransOffset = 82;
	
	  ;% rtDW.f34voctojv
	  section.data(55).logicalSrcIdx = 54;
	  section.data(55).dtTransOffset = 84;
	
	  ;% rtDW.olcih4g4ik
	  section.data(56).logicalSrcIdx = 55;
	  section.data(56).dtTransOffset = 86;
	
	  ;% rtDW.crdn1mgrri
	  section.data(57).logicalSrcIdx = 56;
	  section.data(57).dtTransOffset = 88;
	
	  ;% rtDW.ivhu3gpzjx
	  section.data(58).logicalSrcIdx = 57;
	  section.data(58).dtTransOffset = 90;
	
	  ;% rtDW.paloclk424
	  section.data(59).logicalSrcIdx = 58;
	  section.data(59).dtTransOffset = 92;
	
	  ;% rtDW.be3lrza4wi
	  section.data(60).logicalSrcIdx = 59;
	  section.data(60).dtTransOffset = 94;
	
	  ;% rtDW.p3n1aglok3
	  section.data(61).logicalSrcIdx = 60;
	  section.data(61).dtTransOffset = 96;
	
	  ;% rtDW.ozh132yxwb
	  section.data(62).logicalSrcIdx = 61;
	  section.data(62).dtTransOffset = 98;
	
	  ;% rtDW.jmx0ljg5zh
	  section.data(63).logicalSrcIdx = 62;
	  section.data(63).dtTransOffset = 100;
	
	  ;% rtDW.pdv4bhcnck
	  section.data(64).logicalSrcIdx = 63;
	  section.data(64).dtTransOffset = 102;
	
	  ;% rtDW.imzxvqeimx
	  section.data(65).logicalSrcIdx = 64;
	  section.data(65).dtTransOffset = 104;
	
	  ;% rtDW.ejw55xhs3c
	  section.data(66).logicalSrcIdx = 65;
	  section.data(66).dtTransOffset = 106;
	
	  ;% rtDW.bifebq2snm
	  section.data(67).logicalSrcIdx = 66;
	  section.data(67).dtTransOffset = 108;
	
	  ;% rtDW.b2zahahssu
	  section.data(68).logicalSrcIdx = 67;
	  section.data(68).dtTransOffset = 110;
	
	  ;% rtDW.euskl1gdb0
	  section.data(69).logicalSrcIdx = 68;
	  section.data(69).dtTransOffset = 112;
	
	  ;% rtDW.jikzvz0dtk
	  section.data(70).logicalSrcIdx = 69;
	  section.data(70).dtTransOffset = 114;
	
	  ;% rtDW.co2nzunacq
	  section.data(71).logicalSrcIdx = 70;
	  section.data(71).dtTransOffset = 116;
	
	  ;% rtDW.enwqyz1jzn
	  section.data(72).logicalSrcIdx = 71;
	  section.data(72).dtTransOffset = 118;
	
	  ;% rtDW.p4xgu4xl4i
	  section.data(73).logicalSrcIdx = 72;
	  section.data(73).dtTransOffset = 120;
	
	  ;% rtDW.fec0m0mb4t
	  section.data(74).logicalSrcIdx = 73;
	  section.data(74).dtTransOffset = 122;
	
	  ;% rtDW.ekjowofczj
	  section.data(75).logicalSrcIdx = 74;
	  section.data(75).dtTransOffset = 124;
	
	  ;% rtDW.h51zlqgslw
	  section.data(76).logicalSrcIdx = 75;
	  section.data(76).dtTransOffset = 126;
	
	  ;% rtDW.drrt25z2gq
	  section.data(77).logicalSrcIdx = 76;
	  section.data(77).dtTransOffset = 128;
	
	  ;% rtDW.eibv3w251c
	  section.data(78).logicalSrcIdx = 77;
	  section.data(78).dtTransOffset = 130;
	
	  ;% rtDW.f0ql5zxk1i
	  section.data(79).logicalSrcIdx = 78;
	  section.data(79).dtTransOffset = 132;
	
	  ;% rtDW.hagsy4inex
	  section.data(80).logicalSrcIdx = 79;
	  section.data(80).dtTransOffset = 134;
	
	  ;% rtDW.db2quzp5v1
	  section.data(81).logicalSrcIdx = 80;
	  section.data(81).dtTransOffset = 136;
	
	  ;% rtDW.owtzbz5xax
	  section.data(82).logicalSrcIdx = 81;
	  section.data(82).dtTransOffset = 138;
	
	  ;% rtDW.ocadpp31ig
	  section.data(83).logicalSrcIdx = 82;
	  section.data(83).dtTransOffset = 140;
	
	  ;% rtDW.n34vwdccv4
	  section.data(84).logicalSrcIdx = 83;
	  section.data(84).dtTransOffset = 142;
	
	  ;% rtDW.m1egow4qgo
	  section.data(85).logicalSrcIdx = 84;
	  section.data(85).dtTransOffset = 144;
	
	  ;% rtDW.bnpszb2yyg
	  section.data(86).logicalSrcIdx = 85;
	  section.data(86).dtTransOffset = 146;
	
	  ;% rtDW.m202m3rfyw
	  section.data(87).logicalSrcIdx = 86;
	  section.data(87).dtTransOffset = 148;
	
	  ;% rtDW.mex5zo5pmy
	  section.data(88).logicalSrcIdx = 87;
	  section.data(88).dtTransOffset = 150;
	
	  ;% rtDW.pzdcfak5zp
	  section.data(89).logicalSrcIdx = 88;
	  section.data(89).dtTransOffset = 152;
	
	  ;% rtDW.pr1luhangd
	  section.data(90).logicalSrcIdx = 89;
	  section.data(90).dtTransOffset = 154;
	
	  ;% rtDW.oszgw5p1ox
	  section.data(91).logicalSrcIdx = 90;
	  section.data(91).dtTransOffset = 156;
	
	  ;% rtDW.mfud514kg3
	  section.data(92).logicalSrcIdx = 91;
	  section.data(92).dtTransOffset = 158;
	
	  ;% rtDW.kuxqfoide4
	  section.data(93).logicalSrcIdx = 92;
	  section.data(93).dtTransOffset = 160;
	
	  ;% rtDW.j2s1pfzhw2
	  section.data(94).logicalSrcIdx = 93;
	  section.data(94).dtTransOffset = 162;
	
	  ;% rtDW.dsaf3gpjtf
	  section.data(95).logicalSrcIdx = 94;
	  section.data(95).dtTransOffset = 164;
	
	  ;% rtDW.aqiw2alqul
	  section.data(96).logicalSrcIdx = 95;
	  section.data(96).dtTransOffset = 166;
	
	  ;% rtDW.mi5tk3o5e5
	  section.data(97).logicalSrcIdx = 96;
	  section.data(97).dtTransOffset = 168;
	
	  ;% rtDW.pyiw1uh122
	  section.data(98).logicalSrcIdx = 97;
	  section.data(98).dtTransOffset = 170;
	
	  ;% rtDW.jqjq12p54y
	  section.data(99).logicalSrcIdx = 98;
	  section.data(99).dtTransOffset = 172;
	
	  ;% rtDW.dxg4nsrkdi
	  section.data(100).logicalSrcIdx = 99;
	  section.data(100).dtTransOffset = 174;
	
	  ;% rtDW.afkwzcmkdg
	  section.data(101).logicalSrcIdx = 100;
	  section.data(101).dtTransOffset = 176;
	
	  ;% rtDW.dfcc5enzd3
	  section.data(102).logicalSrcIdx = 101;
	  section.data(102).dtTransOffset = 178;
	
	  ;% rtDW.gd3flx3xxq
	  section.data(103).logicalSrcIdx = 102;
	  section.data(103).dtTransOffset = 180;
	
	  ;% rtDW.nvjfbq1b0t
	  section.data(104).logicalSrcIdx = 103;
	  section.data(104).dtTransOffset = 182;
	
	  ;% rtDW.i2mxhr35b0
	  section.data(105).logicalSrcIdx = 104;
	  section.data(105).dtTransOffset = 184;
	
	  ;% rtDW.jl0avgi5cx
	  section.data(106).logicalSrcIdx = 105;
	  section.data(106).dtTransOffset = 186;
	
	  ;% rtDW.lyy25fe03i
	  section.data(107).logicalSrcIdx = 106;
	  section.data(107).dtTransOffset = 188;
	
	  ;% rtDW.aoud0j2a0r
	  section.data(108).logicalSrcIdx = 107;
	  section.data(108).dtTransOffset = 190;
	
	  ;% rtDW.bevflfauvx
	  section.data(109).logicalSrcIdx = 108;
	  section.data(109).dtTransOffset = 192;
	
	  ;% rtDW.g1dqkdb3c3
	  section.data(110).logicalSrcIdx = 109;
	  section.data(110).dtTransOffset = 194;
	
	  ;% rtDW.py2ijh00ky
	  section.data(111).logicalSrcIdx = 110;
	  section.data(111).dtTransOffset = 196;
	
	  ;% rtDW.kjmzvtdhyk
	  section.data(112).logicalSrcIdx = 111;
	  section.data(112).dtTransOffset = 198;
	
	  ;% rtDW.mthvpncvpm
	  section.data(113).logicalSrcIdx = 112;
	  section.data(113).dtTransOffset = 200;
	
	  ;% rtDW.lxkt1dyonc
	  section.data(114).logicalSrcIdx = 113;
	  section.data(114).dtTransOffset = 202;
	
	  ;% rtDW.axiemv1zky
	  section.data(115).logicalSrcIdx = 114;
	  section.data(115).dtTransOffset = 204;
	
	  ;% rtDW.mwolorwcwq
	  section.data(116).logicalSrcIdx = 115;
	  section.data(116).dtTransOffset = 206;
	
	  ;% rtDW.jmirrco3wb
	  section.data(117).logicalSrcIdx = 116;
	  section.data(117).dtTransOffset = 208;
	
	  ;% rtDW.bdui54ib5n
	  section.data(118).logicalSrcIdx = 117;
	  section.data(118).dtTransOffset = 210;
	
	  ;% rtDW.mhdft32om4
	  section.data(119).logicalSrcIdx = 118;
	  section.data(119).dtTransOffset = 212;
	
	  ;% rtDW.ce5c1bku5e
	  section.data(120).logicalSrcIdx = 119;
	  section.data(120).dtTransOffset = 214;
	
	  ;% rtDW.c3drf1bv52
	  section.data(121).logicalSrcIdx = 120;
	  section.data(121).dtTransOffset = 216;
	
	  ;% rtDW.lolckbgije
	  section.data(122).logicalSrcIdx = 121;
	  section.data(122).dtTransOffset = 218;
	
	  ;% rtDW.kucfmcr1j1
	  section.data(123).logicalSrcIdx = 122;
	  section.data(123).dtTransOffset = 220;
	
	  ;% rtDW.oqdh4x5kax
	  section.data(124).logicalSrcIdx = 123;
	  section.data(124).dtTransOffset = 222;
	
	  ;% rtDW.jiuvqrjca3
	  section.data(125).logicalSrcIdx = 124;
	  section.data(125).dtTransOffset = 224;
	
	  ;% rtDW.hlei5hxyzw
	  section.data(126).logicalSrcIdx = 125;
	  section.data(126).dtTransOffset = 226;
	
	  ;% rtDW.etds5ng1py
	  section.data(127).logicalSrcIdx = 126;
	  section.data(127).dtTransOffset = 228;
	
	  ;% rtDW.onn5evzags
	  section.data(128).logicalSrcIdx = 127;
	  section.data(128).dtTransOffset = 230;
	
	  ;% rtDW.awwcxuepry
	  section.data(129).logicalSrcIdx = 128;
	  section.data(129).dtTransOffset = 232;
	
	  ;% rtDW.flyhppc0fg
	  section.data(130).logicalSrcIdx = 129;
	  section.data(130).dtTransOffset = 234;
	
	  ;% rtDW.owgzwsjq5d
	  section.data(131).logicalSrcIdx = 130;
	  section.data(131).dtTransOffset = 236;
	
	  ;% rtDW.mwpi3ynzr4
	  section.data(132).logicalSrcIdx = 131;
	  section.data(132).dtTransOffset = 238;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(1) = section;
      clear section
      
      section.nData     = 22;
      section.data(22)  = dumData; %prealloc
      
	  ;% rtDW.b2arsst4q2
	  section.data(1).logicalSrcIdx = 132;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.bon5nsgn3b
	  section.data(2).logicalSrcIdx = 133;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtDW.k0ssi30azu
	  section.data(3).logicalSrcIdx = 134;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtDW.irfedvubtt
	  section.data(4).logicalSrcIdx = 135;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtDW.ojt2pz2p32
	  section.data(5).logicalSrcIdx = 136;
	  section.data(5).dtTransOffset = 4;
	
	  ;% rtDW.pdgssa1b2o
	  section.data(6).logicalSrcIdx = 137;
	  section.data(6).dtTransOffset = 5;
	
	  ;% rtDW.awuluam3ml
	  section.data(7).logicalSrcIdx = 138;
	  section.data(7).dtTransOffset = 6;
	
	  ;% rtDW.ept4uan2f3
	  section.data(8).logicalSrcIdx = 139;
	  section.data(8).dtTransOffset = 7;
	
	  ;% rtDW.aiatmsc2jo
	  section.data(9).logicalSrcIdx = 140;
	  section.data(9).dtTransOffset = 8;
	
	  ;% rtDW.lgfzjs5dth
	  section.data(10).logicalSrcIdx = 141;
	  section.data(10).dtTransOffset = 9;
	
	  ;% rtDW.crbf2tygs1.TimePtr
	  section.data(11).logicalSrcIdx = 142;
	  section.data(11).dtTransOffset = 10;
	
	  ;% rtDW.eihttukf4z
	  section.data(12).logicalSrcIdx = 143;
	  section.data(12).dtTransOffset = 11;
	
	  ;% rtDW.idz4dpacax
	  section.data(13).logicalSrcIdx = 144;
	  section.data(13).dtTransOffset = 12;
	
	  ;% rtDW.pppjilj514
	  section.data(14).logicalSrcIdx = 145;
	  section.data(14).dtTransOffset = 13;
	
	  ;% rtDW.l0mbzpqsvw
	  section.data(15).logicalSrcIdx = 146;
	  section.data(15).dtTransOffset = 14;
	
	  ;% rtDW.nw4i03rf3m
	  section.data(16).logicalSrcIdx = 147;
	  section.data(16).dtTransOffset = 15;
	
	  ;% rtDW.cihz1sgfnh.SignalProbe
	  section.data(17).logicalSrcIdx = 148;
	  section.data(17).dtTransOffset = 16;
	
	  ;% rtDW.agooo1dpjy
	  section.data(18).logicalSrcIdx = 149;
	  section.data(18).dtTransOffset = 17;
	
	  ;% rtDW.bsepwavlsu
	  section.data(19).logicalSrcIdx = 150;
	  section.data(19).dtTransOffset = 18;
	
	  ;% rtDW.ov1vp5ntf4
	  section.data(20).logicalSrcIdx = 151;
	  section.data(20).dtTransOffset = 19;
	
	  ;% rtDW.h14dxgikfj
	  section.data(21).logicalSrcIdx = 152;
	  section.data(21).dtTransOffset = 20;
	
	  ;% rtDW.g0y0nwsi3s
	  section.data(22).logicalSrcIdx = 153;
	  section.data(22).dtTransOffset = 21;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(2) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.m4szg5brio.PrevIndex
	  section.data(1).logicalSrcIdx = 154;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(3) = section;
      clear section
      
      section.nData     = 24;
      section.data(24)  = dumData; %prealloc
      
	  ;% rtDW.iwawdscqee
	  section.data(1).logicalSrcIdx = 155;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.j3shhplgyq
	  section.data(2).logicalSrcIdx = 156;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtDW.ma0she0t2q
	  section.data(3).logicalSrcIdx = 157;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtDW.lxvboya1ss
	  section.data(4).logicalSrcIdx = 158;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtDW.axl1nezjim
	  section.data(5).logicalSrcIdx = 159;
	  section.data(5).dtTransOffset = 4;
	
	  ;% rtDW.dvydkkivyd
	  section.data(6).logicalSrcIdx = 160;
	  section.data(6).dtTransOffset = 5;
	
	  ;% rtDW.h2jt4vttoe
	  section.data(7).logicalSrcIdx = 161;
	  section.data(7).dtTransOffset = 6;
	
	  ;% rtDW.cwinnxzchn
	  section.data(8).logicalSrcIdx = 162;
	  section.data(8).dtTransOffset = 7;
	
	  ;% rtDW.osfzlnqadd
	  section.data(9).logicalSrcIdx = 163;
	  section.data(9).dtTransOffset = 8;
	
	  ;% rtDW.ib1dk32ciq
	  section.data(10).logicalSrcIdx = 164;
	  section.data(10).dtTransOffset = 9;
	
	  ;% rtDW.jzysxf0hup
	  section.data(11).logicalSrcIdx = 165;
	  section.data(11).dtTransOffset = 10;
	
	  ;% rtDW.cc2ir2gryz
	  section.data(12).logicalSrcIdx = 166;
	  section.data(12).dtTransOffset = 11;
	
	  ;% rtDW.mpgodqtr40
	  section.data(13).logicalSrcIdx = 167;
	  section.data(13).dtTransOffset = 12;
	
	  ;% rtDW.e1zupici05
	  section.data(14).logicalSrcIdx = 168;
	  section.data(14).dtTransOffset = 13;
	
	  ;% rtDW.cszkl4zl1i
	  section.data(15).logicalSrcIdx = 169;
	  section.data(15).dtTransOffset = 14;
	
	  ;% rtDW.cinwgvjojv
	  section.data(16).logicalSrcIdx = 170;
	  section.data(16).dtTransOffset = 15;
	
	  ;% rtDW.lx4yhnbdap
	  section.data(17).logicalSrcIdx = 171;
	  section.data(17).dtTransOffset = 16;
	
	  ;% rtDW.pgnt5qxpp1
	  section.data(18).logicalSrcIdx = 172;
	  section.data(18).dtTransOffset = 17;
	
	  ;% rtDW.abnvjxict3
	  section.data(19).logicalSrcIdx = 173;
	  section.data(19).dtTransOffset = 18;
	
	  ;% rtDW.myqa1mdtgw
	  section.data(20).logicalSrcIdx = 174;
	  section.data(20).dtTransOffset = 19;
	
	  ;% rtDW.eu14vek5kv
	  section.data(21).logicalSrcIdx = 175;
	  section.data(21).dtTransOffset = 20;
	
	  ;% rtDW.cylsx1gv5u
	  section.data(22).logicalSrcIdx = 176;
	  section.data(22).dtTransOffset = 21;
	
	  ;% rtDW.k2qzjlhwrk
	  section.data(23).logicalSrcIdx = 177;
	  section.data(23).dtTransOffset = 22;
	
	  ;% rtDW.ocfi4hx2cy
	  section.data(24).logicalSrcIdx = 178;
	  section.data(24).dtTransOffset = 23;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(4) = section;
      clear section
      
      section.nData     = 4;
      section.data(4)  = dumData; %prealloc
      
	  ;% rtDW.aqkvejlfs3
	  section.data(1).logicalSrcIdx = 179;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.latvz1stk0
	  section.data(2).logicalSrcIdx = 180;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtDW.g5rrca1ekq
	  section.data(3).logicalSrcIdx = 181;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtDW.on3zfoelyn
	  section.data(4).logicalSrcIdx = 182;
	  section.data(4).dtTransOffset = 3;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(5) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (dwork)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    dworkMap.nTotData = nTotData;
    


  ;%
  ;% Add individual maps to base struct.
  ;%

  targMap.paramMap  = paramMap;    
  targMap.signalMap = sigMap;
  targMap.dworkMap  = dworkMap;
  
  ;%
  ;% Add checksums to base struct.
  ;%


  targMap.checksum0 = 1082360751;
  targMap.checksum1 = 2881760269;
  targMap.checksum2 = 2535395024;
  targMap.checksum3 = 1684015469;

