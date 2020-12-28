
pragma solidity >=0.5.0 <0.7.0;

import "./PlonkCore.sol";

// Hardcoded constants to avoid accessing store
contract KeysWithPlonkVerifier is VerifierWithDeserialize {

    function isBlockSizeSupportedInternal(uint32 _size) internal pure returns (bool) {
        if (_size == uint32(6)) { return true; }
        else if (_size == uint32(30)) { return true; }
        else if (_size == uint32(74)) { return true; }
        else if (_size == uint32(150)) { return true; }
        else if (_size == uint32(320)) { return true; }
        else if (_size == uint32(630)) { return true; }
        else { return false; }
    }

    function getVkBlock(uint32 _chunks) internal pure returns (VerificationKey memory vk) {
        if (_chunks == uint32(6)) { return getVkBlock6(); }
        else if (_chunks == uint32(30)) { return getVkBlock30(); }
        else if (_chunks == uint32(74)) { return getVkBlock74(); }
        else if (_chunks == uint32(150)) { return getVkBlock150(); }
        else if (_chunks == uint32(320)) { return getVkBlock320(); }
        else if (_chunks == uint32(630)) { return getVkBlock630(); }
    }

    
    function getVkBlock6() internal pure returns(VerificationKey memory vk) {
        vk.domain_size = 2097152;
        vk.num_inputs = 1;
        vk.omega = PairingsBn254.new_fr(0x032750f8f3c2493d0828c7285d0258e1bdcaa463f4442a52747b5c96639659bb);
        vk.selector_commitments[0] = PairingsBn254.new_g1(
            0x0bbdc1e77641b9052896eb71e4f7ef4d3dff56b687fb279be7a250f3186cd078,
            0x21aa0fec4f386d16a0f9f931945aaa78c18ad335071d61865c7b4962cc99cd7d
        );
        vk.selector_commitments[1] = PairingsBn254.new_g1(
            0x15b7257110e0f21b105a6c2d5fce629a3c00e7e75db15acbf6655f0aa7976b9e,
            0x0deaccc252ab8dec5cc14ea3294942d11bd91edb856e905f59a2eb3b340f8396
        );
        vk.selector_commitments[2] = PairingsBn254.new_g1(
            0x07f398ff4e80dbe4a06ce06f9136400b31d5339d8ab1a819245212f386665d3c,
            0x2c1cdc5be085137629a7875a27c13fc72113182cecb68d7ca75b7bccb314d627
        );
        vk.selector_commitments[3] = PairingsBn254.new_g1(
            0x2783ffd7292aa329f24ae64a3a4251826f22edd57cd65cd77264b66e446a1d07,
            0x0df10c5b446049b451be6477a4eea0bad2c2909d65e6e46f217c0bf41b593069
        );
        vk.selector_commitments[4] = PairingsBn254.new_g1(
            0x0e21fe5625c6b080fee8081a5f2eec864a9adbd103a349fb8f735d41e78c092b,
            0x1749b43047bc1e0906bcaf401dc83216e2d8c763808e97397fe1c4b3e6b5d74f
        );
        vk.selector_commitments[5] = PairingsBn254.new_g1(
            0x04dd178ae664b300dfe4ad744f9d4a72a3e845eaee42aa936a56f9f7ad38ea42,
            0x16756ac150b8f593a08cd301d6eb10d15401a377017d3440094701a0d94e9fb1
        );

        // we only have access to value of the d(x) witness polynomial on the next
        // trace step, so we only need one element here and deal with it in other places
        // by having this in mind
        vk.next_step_selector_commitments[0] = PairingsBn254.new_g1(
            0x1de484b5004b0598138b340eeff3c73aeff63c88312e0d4286b06d8f28558886,
            0x2bf1e5d54cd1f8e1779f832006d280063fd5bb529d577da4a4eef0d41e796b70
        );

         vk.permutation_commitments[0] = PairingsBn254.new_g1(
            0x0c4c0205c90fb86c92cd6bb5bfae571d27f2f81f6b836c49e4a4682565cfe061,
            0x2314d2d3f72a77d64c1cf5aa4c98e2384eb7f701c9a08e163f9576c35a760689
        );
        vk.permutation_commitments[1] = PairingsBn254.new_g1(
            0x0e6b6a87d1082c1134fba0f2fa88d11f69c7617d0643798fb8e9cca0bc536f51,
            0x0ad7878c702fa6aa24d81d03c799cd2fd1266d0a1018334ffd6fa5902a535df7
        );
        vk.permutation_commitments[2] = PairingsBn254.new_g1(
            0x0eb8f67e627729c680f56ce131ddbe9e7b916b054253ff60b889c1b136848b32,
            0x1dc15705f9fc5d86f22d326cf406ae87e9f4836e51bf32e179a909cdd3d5c8cc
        );
        vk.permutation_commitments[3] = PairingsBn254.new_g1(
            0x1633a6d181beb7fdfeb34ef98e13a833c70e1991b54cc87f68c250eb8b962fce,
            0x1a47f51fb1f618550b689f8548e5a3ffcf496acdb9ee75c708dbe0f70338a5b4
        );

        vk.permutation_non_residues[0] = PairingsBn254.new_fr(
            0x0000000000000000000000000000000000000000000000000000000000000005
        );
        vk.permutation_non_residues[1] = PairingsBn254.new_fr(
            0x0000000000000000000000000000000000000000000000000000000000000007
        );
        vk.permutation_non_residues[2] = PairingsBn254.new_fr(
            0x000000000000000000000000000000000000000000000000000000000000000a
        );

        vk.g2_x = PairingsBn254.new_g2(
            [0x260e01b251f6f1c7e7ff4e580791dee8ea51d87a358e038b4efe30fac09383c1,
             0x0118c4d5b837bcc2bc89b5b398b5974e9f5944073b32078b7e231fec938883b0],
            [0x04fc6369f7110fe3d25156c1bb9a72859cf2a04641f99ba4ee413c80da6a5fe4,
             0x22febda3c0c0632a56475b4214e5615e11e6dd3f96e6cea2854a87d4dacc5e55]
        );
    }
    
    function getVkBlock30() internal pure returns(VerificationKey memory vk) {
        vk.domain_size = 4194304;
        vk.num_inputs = 1;
        vk.omega = PairingsBn254.new_fr(0x18c95f1ae6514e11a1b30fd7923947c5ffcec5347f16e91b4dd654168326bede);
        vk.selector_commitments[0] = PairingsBn254.new_g1(
            0x2511a17b772ec60f881382571196ed06ef09bc3d701456898a81e0ccf5002c53,
            0x2e95410633fcac3f1226a3b49ab7fc962fda1bc5a9c2c668aeb1d70f783f52b0
        );
        vk.selector_commitments[1] = PairingsBn254.new_g1(
            0x0c48fe0be86da1b804b88179ce75f63519a654947b9a57dabd030ab7d591b315,
            0x206515e1545ac65c0262417e57f7a386431debc8591d318584640fd5070b5a3b
        );
        vk.selector_commitments[2] = PairingsBn254.new_g1(
            0x0e7b9fff45640e775d9591ca2313df04119bf79f0dc3c5b5bb5a9f83e280fc52,
            0x0701265fcff91d78fd4e34705dacf6e28b849986bc5b7bd61516b43647555101
        );
        vk.selector_commitments[3] = PairingsBn254.new_g1(
            0x2fa7f4bd5969ee3bd36f6193a2f3c5c7db1df98c38395c298626e3878945e586,
            0x027d881f7238b3b76f8c8536cea37186e12e7a8767a7736c41fe5804023ec2e1
        );
        vk.selector_commitments[4] = PairingsBn254.new_g1(
            0x1221e8cb0c49abee67827c2272b3bfcc1b228a49ee8ed06247e14fc982c79310,
            0x2db21bfef8251add73e0ab0fabd05156cb8a24fade99723965a3c3cd73731a98
        );
        vk.selector_commitments[5] = PairingsBn254.new_g1(
            0x2c80ea829376296192599f72185e649bea442d2c42e183cb555aa553f519812b,
            0x1d8eb8336f88ce1ab9e45b4dcf52ee9d7e0e9a1696ff1e4e14108dc5c06ac499
        );

        // we only have access to value of the d(x) witness polynomial on the next
        // trace step, so we only need one element here and deal with it in other places
        // by having this in mind
        vk.next_step_selector_commitments[0] = PairingsBn254.new_g1(
            0x239137a1613ff61f55233376bfe8f8e13de40cf21ebddd93971d641d2b5a7812,
            0x2d9fff5b807ece123c3a447df669adae97eb1fcf797a3d8e31491e869df1ff8f
        );

         vk.permutation_commitments[0] = PairingsBn254.new_g1(
            0x0d8ae93e3f66097b98d10951ccd55049f7bf01de76d83c96e7ec24efd4f26d16,
            0x0052a8340fa0a25bd9ca8d11b2c5b3a820d022f5834e4054dde6451895114563
        );
        vk.permutation_commitments[1] = PairingsBn254.new_g1(
            0x0c6764ee77ba72660c0fae99135a868844b103c333c5c1dd7ca7ed4a350003dd,
            0x2d507b525dfc15d705e4955ae6d3bfd90cdaf875946c8dee6a9afc8106a95506
        );
        vk.permutation_commitments[2] = PairingsBn254.new_g1(
            0x0ba37e6d6b25c59049890d1e6007b250016f3523c2f141308ae80e7a0302b160,
            0x0995303a738e5688d023572d72b100bd7c217ac1af001c20d8358bba56eff8d9
        );
        vk.permutation_commitments[3] = PairingsBn254.new_g1(
            0x0009e576b31aeefe49596e1233bc5e53e427afa9f8d0fd423ee425074a371c6b,
            0x1d518564a037dd5e740966bde366c3a9341766dfbb1f5d78d666d86e93123f30
        );

        vk.permutation_non_residues[0] = PairingsBn254.new_fr(
            0x0000000000000000000000000000000000000000000000000000000000000005
        );
        vk.permutation_non_residues[1] = PairingsBn254.new_fr(
            0x0000000000000000000000000000000000000000000000000000000000000007
        );
        vk.permutation_non_residues[2] = PairingsBn254.new_fr(
            0x000000000000000000000000000000000000000000000000000000000000000a
        );

        vk.g2_x = PairingsBn254.new_g2(
            [0x260e01b251f6f1c7e7ff4e580791dee8ea51d87a358e038b4efe30fac09383c1,
             0x0118c4d5b837bcc2bc89b5b398b5974e9f5944073b32078b7e231fec938883b0],
            [0x04fc6369f7110fe3d25156c1bb9a72859cf2a04641f99ba4ee413c80da6a5fe4,
             0x22febda3c0c0632a56475b4214e5615e11e6dd3f96e6cea2854a87d4dacc5e55]
        );
    }
    
    function getVkBlock74() internal pure returns(VerificationKey memory vk) {
        vk.domain_size = 8388608;
        vk.num_inputs = 1;
        vk.omega = PairingsBn254.new_fr(0x1283ba6f4b7b1a76ba2008fe823128bea4adb9269cbfd7c41c223be65bc60863);
        vk.selector_commitments[0] = PairingsBn254.new_g1(
            0x16c1ae805f3f4dd8d6f7746d02bc3665af4b0b17d17b65b2351bcddfdf03c7d0,
            0x04c263d3fa1df99437bf892fec63b1dae7d44fd26898c6c745ab711427b52fec
        );
        vk.selector_commitments[1] = PairingsBn254.new_g1(
            0x23ded23db5a425a4306adbfade17c822a017a9691c648a10f16ad20cdcc73959,
            0x067e3a5eee1e444257968b376f6d2fe1fed2773e3ac34af08c73fcb0ead8b435
        );
        vk.selector_commitments[2] = PairingsBn254.new_g1(
            0x00b38d0c1e823bab03e235ae469425c61842b788bc716e20e192d4c6656bba75,
            0x282d49c9d6aee99ffb4480aa797fdd5ac2e90f689c99e77f0cb90325e55d775a
        );
        vk.selector_commitments[3] = PairingsBn254.new_g1(
            0x1ec4c0eb1590ca1b32dec591a307e9af1d9eaafe6977fa4476510954d848980b,
            0x04c32cab39b445dc2aa4f1d19defe68d808e24fdffca6537f6c3338a485def07
        );
        vk.selector_commitments[4] = PairingsBn254.new_g1(
            0x2aa30e5edb2273e47150758b3a1c4e3e46f5d679d32cd5be300a875a8ef9728e,
            0x0d08e54f63d11b5b35eeeb8bd72adafd571ddbecc3b9be8685ac0fe9c45081e2
        );
        vk.selector_commitments[5] = PairingsBn254.new_g1(
            0x06a35e377409ca66c025f52b850c83aadeaa90ca172acde9d9c6326e09d7537c,
            0x0a865baaf9f6ad5713362a2475e846243b52f9bbf8766e955f3fea82100f34ee
        );

        // we only have access to value of the d(x) witness polynomial on the next
        // trace step, so we only need one element here and deal with it in other places
        // by having this in mind
        vk.next_step_selector_commitments[0] = PairingsBn254.new_g1(
            0x042795ee1f4efaac4d6e9fde64ee4d4e0859c09cabbc9dba2d880feb366a51f2,
            0x18ec6158957a3163fdb6a42f1a06f9aca186bdbc6589c13ad5054ecd51d1553b
        );

         vk.permutation_commitments[0] = PairingsBn254.new_g1(
            0x0c0c96f500f630ea2dcc14104969671f2e8335a7a50d5832b1b3aa52818b2f86,
            0x1801c805d9cd6e297102b9b87071389f88614b1bf7e257bbf7942091f1aa3984
        );
        vk.permutation_commitments[1] = PairingsBn254.new_g1(
            0x26c6e629dbd9b5d9365c990bbd7e62a38b22e3bc1fa8ec9d139cdb8811b6b3f9,
            0x284af50ac9e135aa4aaea8aeb075a5bf56c2ebb7a13f042f1b273ec1631e1320
        );
        vk.permutation_commitments[2] = PairingsBn254.new_g1(
            0x1b2bebfe46bdce24f3f24c48c87040876340c89ff0e6ae0c20871bd752f4013e,
            0x2bc24c0193f1982cf9df2c3b5b6d6c93d9a47c8747b8887c315c002b093112f1
        );
        vk.permutation_commitments[3] = PairingsBn254.new_g1(
            0x2bc7372695196f189f5d189dc03b795d8bbacb5b067ba888e91562d1498f01ca,
            0x1891d2f1948b2960cd024bcba0c27baa4fdb2a9e9c1be5b81ab84c53915815f4
        );

        vk.permutation_non_residues[0] = PairingsBn254.new_fr(
            0x0000000000000000000000000000000000000000000000000000000000000005
        );
        vk.permutation_non_residues[1] = PairingsBn254.new_fr(
            0x0000000000000000000000000000000000000000000000000000000000000007
        );
        vk.permutation_non_residues[2] = PairingsBn254.new_fr(
            0x000000000000000000000000000000000000000000000000000000000000000a
        );

        vk.g2_x = PairingsBn254.new_g2(
            [0x260e01b251f6f1c7e7ff4e580791dee8ea51d87a358e038b4efe30fac09383c1,
             0x0118c4d5b837bcc2bc89b5b398b5974e9f5944073b32078b7e231fec938883b0],
            [0x04fc6369f7110fe3d25156c1bb9a72859cf2a04641f99ba4ee413c80da6a5fe4,
             0x22febda3c0c0632a56475b4214e5615e11e6dd3f96e6cea2854a87d4dacc5e55]
        );
    }
    
    function getVkBlock150() internal pure returns(VerificationKey memory vk) {
        vk.domain_size = 16777216;
        vk.num_inputs = 1;
        vk.omega = PairingsBn254.new_fr(0x1951441010b2b95a6e47a6075066a50a036f5ba978c050f2821df86636c0facb);
        vk.selector_commitments[0] = PairingsBn254.new_g1(
            0x077c7ae91978ee8279ee9edc5d8694f8702e8ac62c6f106392655ca6534ca9e5,
            0x20712f4a60efbbf483eff556da61231b6980119dc8f81f87d867403257c5bd21
        );
        vk.selector_commitments[1] = PairingsBn254.new_g1(
            0x272c4bb2891fa37f35fc99ee5da1383f8e05146fef695e4e60b3b1f211b312b5,
            0x209c3e3d3f2019851ae7a02b6353d776e8915a974a3b08ee78f2741bbcf0e977
        );
        vk.selector_commitments[2] = PairingsBn254.new_g1(
            0x2076a7f37fb31be04fa32cb2fb2cbc7c26f3f517b2779ecc3a2aea91eb3d3242,
            0x03e70d8a98fdb39a8d222178ef96e4c4af2ac47f66e2637c56ab72f017c7bb9c
        );
        vk.selector_commitments[3] = PairingsBn254.new_g1(
            0x2d9af4c8b2ebdbd80fa165c11fff98bc9596a731651453aa6bd2fae23b0f6a86,
            0x25953a2fe7e5ea6d7171ea161083fc39546ee03cef4823ef8bbe87df7af67c27
        );
        vk.selector_commitments[4] = PairingsBn254.new_g1(
            0x197489d10b680f38eb75103b7206d02eff21bf479eaf6931122c3657db5b4789,
            0x1059a97c34b75b6ac25f6a05d3402924eacbc5b19766f8a7daf2ee955ff81176
        );
        vk.selector_commitments[5] = PairingsBn254.new_g1(
            0x0727abd906ee805d3649a8fbd95c5951242ca56d75fde9abb1e783c69e46eb01,
            0x2107c461ace3d84c634ab005491ee20189c8c90859b1414be97a829c7167d38f
        );

        // we only have access to value of the d(x) witness polynomial on the next
        // trace step, so we only need one element here and deal with it in other places
        // by having this in mind
        vk.next_step_selector_commitments[0] = PairingsBn254.new_g1(
            0x0bffc9aae44914e7466ff92c6c20704ccbf19ed3e3638a9219b178b1e3d5ba5d,
            0x046f70159ad8821c8bc69508edd51162441528d030ca7396e4e56b708e4ccb4f
        );

         vk.permutation_commitments[0] = PairingsBn254.new_g1(
            0x17c393630ce06a6ee975015c5f2602c7c8c6bbb1f9e6d0734f354a32c63c3056,
            0x156e36264a96be89609e64613424b8c3e1c3407e4f2e0c2151313b7f4b89840d
        );
        vk.permutation_commitments[1] = PairingsBn254.new_g1(
            0x0e24d3e32590b2dc9bdca31d7708ed943c896c20230cd77647458014ae01f427,
            0x1db41c129eac7cf42055bd5e4a735912f60bd82d68b7f23e51f74ee32a60d57a
        );
        vk.permutation_commitments[2] = PairingsBn254.new_g1(
            0x286a450639c1876ade265dd466c1f1c83d0bebba1561c867bd7503ece9fbcf5e,
            0x0c160a1e5d7499610117ce44456692afeb594ff9e661452ec216a68680d1153d
        );
        vk.permutation_commitments[3] = PairingsBn254.new_g1(
            0x2801c063b93cd8e584bbf1f748289ca6bc73becd05b0901190ae706531754586,
            0x1928be35f2694db09e8a2f04ff250d1286f8a24b2d1db366e535cddef2500867
        );

        vk.permutation_non_residues[0] = PairingsBn254.new_fr(
            0x0000000000000000000000000000000000000000000000000000000000000005
        );
        vk.permutation_non_residues[1] = PairingsBn254.new_fr(
            0x0000000000000000000000000000000000000000000000000000000000000007
        );
        vk.permutation_non_residues[2] = PairingsBn254.new_fr(
            0x000000000000000000000000000000000000000000000000000000000000000a
        );

        vk.g2_x = PairingsBn254.new_g2(
            [0x260e01b251f6f1c7e7ff4e580791dee8ea51d87a358e038b4efe30fac09383c1,
             0x0118c4d5b837bcc2bc89b5b398b5974e9f5944073b32078b7e231fec938883b0],
            [0x04fc6369f7110fe3d25156c1bb9a72859cf2a04641f99ba4ee413c80da6a5fe4,
             0x22febda3c0c0632a56475b4214e5615e11e6dd3f96e6cea2854a87d4dacc5e55]
        );
    }
    
    function getVkBlock320() internal pure returns(VerificationKey memory vk) {
        vk.domain_size = 33554432;
        vk.num_inputs = 1;
        vk.omega = PairingsBn254.new_fr(0x0d94d63997367c97a8ed16c17adaae39262b9af83acb9e003f94c217303dd160);
        vk.selector_commitments[0] = PairingsBn254.new_g1(
            0x1042adce3a68df985c364c022bd13a046c5f856490326aadb02c04766ba69adc,
            0x042fcdb81637d3d385b3ced0f1140301ffbfc0c94548b573fff579ffcd3e5d55
        );
        vk.selector_commitments[1] = PairingsBn254.new_g1(
            0x0123899c85c6df72510e9620eff5c77420d506048580cda91452ae8dc5a7bf2d,
            0x20703d86dfa32b8a242c75ce9346f4e1f431a55dc42b09eaf34427cc98a85e0d
        );
        vk.selector_commitments[2] = PairingsBn254.new_g1(
            0x1e9c165c99237974660e689f735ad0906d975168fddc51b7573306f0281e0096,
            0x1ec942f769b670b434d872150df3d2474cbda55e0c069e592ddfa7d302e6bf73
        );
        vk.selector_commitments[3] = PairingsBn254.new_g1(
            0x0f0e3f44205fe6222d653010bcacc1999b8cc06748c4ac24d0f5953e508ac850,
            0x008d0660bab2e1fa6c6ee2ec4cd8bd4b0eb02150966d5026d5435efc075ac039
        );
        vk.selector_commitments[4] = PairingsBn254.new_g1(
            0x2bbb9cdc4d2dd7561b118792864c23653c2b2d2703266a3a1ccfb2e3c8281bae,
            0x1145aeba56dc541c02739a8be26e281b15d75fd46e4d95787fb10acbabaa9ea8
        );
        vk.selector_commitments[5] = PairingsBn254.new_g1(
            0x00f1e99c8b9cf5ca3d73bb0e35ffd45e74dc14cd49ffa971f06eb4ff48aad267,
            0x2c4a49bdc0d6d933c51aa79e7ddf3b7fdda6b72e35aa7347a0f2ec0a010d83e0
        );

        // we only have access to value of the d(x) witness polynomial on the next
        // trace step, so we only need one element here and deal with it in other places
        // by having this in mind
        vk.next_step_selector_commitments[0] = PairingsBn254.new_g1(
            0x15a95ee5879779c388c4d5aa005a7c1e4c251c0eaa214ab55f5017333e8976ef,
            0x11263cfdc8f80e697bab2ebc0b49d9c50cb7c5b8ffcb913cbad857bd44ef7883
        );

         vk.permutation_commitments[0] = PairingsBn254.new_g1(
            0x0d256d39ecc835a1dca56ffb2233539bed3757fcc237d8aa5c076ad996726fcb,
            0x17e1d32da61e250e87d6171939162368613de7a1d248ef5b8f60002338985389
        );
        vk.permutation_commitments[1] = PairingsBn254.new_g1(
            0x21ce5f25026068bd465393a2a721747093db377da26db72646220faf08b9e8b8,
            0x24c6cf0f23cec87dab63267e4193a1b9666ced4d7db07cb5597168a6f7b0998a
        );
        vk.permutation_commitments[2] = PairingsBn254.new_g1(
            0x0ff5079618b0804d177d063c7b89fe9be26f101ca396bb73c32de8fa07d7e9cd,
            0x26fc4b4e5e2d78588c1bd703cce79f0060099c8e33ded315cdc33f38d2054896
        );
        vk.permutation_commitments[3] = PairingsBn254.new_g1(
            0x0cca8b91c6e8dee99c03dea846a8549395504b48aa6c91f9eeecf9946c1e22d7,
            0x0b9ed706b66c521fbfa51a558d24ac874caff27946f4b126d598009cc6fd1d4f
        );

        vk.permutation_non_residues[0] = PairingsBn254.new_fr(
            0x0000000000000000000000000000000000000000000000000000000000000005
        );
        vk.permutation_non_residues[1] = PairingsBn254.new_fr(
            0x0000000000000000000000000000000000000000000000000000000000000007
        );
        vk.permutation_non_residues[2] = PairingsBn254.new_fr(
            0x000000000000000000000000000000000000000000000000000000000000000a
        );

        vk.g2_x = PairingsBn254.new_g2(
            [0x260e01b251f6f1c7e7ff4e580791dee8ea51d87a358e038b4efe30fac09383c1,
             0x0118c4d5b837bcc2bc89b5b398b5974e9f5944073b32078b7e231fec938883b0],
            [0x04fc6369f7110fe3d25156c1bb9a72859cf2a04641f99ba4ee413c80da6a5fe4,
             0x22febda3c0c0632a56475b4214e5615e11e6dd3f96e6cea2854a87d4dacc5e55]
        );
    }
    
    function getVkBlock630() internal pure returns(VerificationKey memory vk) {
        vk.domain_size = 67108864;
        vk.num_inputs = 1;
        vk.omega = PairingsBn254.new_fr(0x1dba8b5bdd64ef6ce29a9039aca3c0e524395c43b9227b96c75090cc6cc7ec97);
        vk.selector_commitments[0] = PairingsBn254.new_g1(
            0x0ba35abb44fbfe720599bae1069ba4c803f27921375219fb079c221027349504,
            0x27c309bdbbca8729af48985f92bbc4a1831c12cd490659a70c7c9cb0249ec836
        );
        vk.selector_commitments[1] = PairingsBn254.new_g1(
            0x281febd9df48c5096835d7c7cdb2551ced1bd375d36c56bdf0ae681c5c60e29b,
            0x1e639883a5deda8187ad1ea7b4f9e2e573cb20b28ff8b9a6edc8b6881e05f180
        );
        vk.selector_commitments[2] = PairingsBn254.new_g1(
            0x27d8975f4714a0b07f7bccf7ecf9b766b70b35fa8511bfdfa1dcd7f4225de861,
            0x1a03a603130fe423e0c49202c50700ee735e88c6e331f76ed7207b9554b7166b
        );
        vk.selector_commitments[3] = PairingsBn254.new_g1(
            0x261eb71b438140dd2a42db98350060ae01ce0440e69581bb9a89e8aa8e11a44e,
            0x1643909b37221c3e09524a2d587bc332f5bfc32b4d215fdacfe6f1aec0aad146
        );
        vk.selector_commitments[4] = PairingsBn254.new_g1(
            0x2c2cb672423e7f315039d310eb39c2f203edd009f0b376268a850b1e56cdd0e3,
            0x034ca333c7ed5f17a680f6076ea7604275f89d9b34010195b043b82f828f98ad
        );
        vk.selector_commitments[5] = PairingsBn254.new_g1(
            0x0a78cc07a9546249e511f031647815b6e60c31efa8a94b96d536fc1efa6d0b30,
            0x1075e2c0f3aa88d468cdda6383ef4248179f5c1cacd7987f2ce7905c1f6157f5
        );

        // we only have access to value of the d(x) witness polynomial on the next
        // trace step, so we only need one element here and deal with it in other places
        // by having this in mind
        vk.next_step_selector_commitments[0] = PairingsBn254.new_g1(
            0x2da056883140fbed79a06ad0215f1c0021e57de6dc560b877113b7bac11ca92e,
            0x2bb2c163e673a6c1bfaea39cb3b0c88174713eb3cc57ae3cdcc693297fc1fca3
        );

         vk.permutation_commitments[0] = PairingsBn254.new_g1(
            0x1fd93734fb282abb99bfb46717c0e32114ce08f9b51f1c7cf25cb63e982d4832,
            0x15f151ce34b9b0e4aea63e234639c1c18842228319355cd7925d06e176e5b362
        );
        vk.permutation_commitments[1] = PairingsBn254.new_g1(
            0x2d0bc2716eada8a535267ab7b820f9923375c35c04dab9d1e9265cbb81cb69b6,
            0x2caf36309fc6a2db48d0573a38e1770ae47e631a7efc65d83750bca89e2b99ae
        );
        vk.permutation_commitments[2] = PairingsBn254.new_g1(
            0x2fb793e6afd7dcd0106dea4767c295247822b13efc0791296b6f9f6e5453c4ad,
            0x30518491d2b4b88532d04daf604256527e3116983b85a9d38a91e33f82c7121f
        );
        vk.permutation_commitments[3] = PairingsBn254.new_g1(
            0x2f72fb20de19983cebd2444acc0ab54108b03d7e44d307295ebb5dd3df2a7d7f,
            0x0917f243cf4fa383d0667434be66c3b8bd3dafc4a9b5c2c325815c5c14d55b40
        );

        vk.permutation_non_residues[0] = PairingsBn254.new_fr(
            0x0000000000000000000000000000000000000000000000000000000000000005
        );
        vk.permutation_non_residues[1] = PairingsBn254.new_fr(
            0x0000000000000000000000000000000000000000000000000000000000000007
        );
        vk.permutation_non_residues[2] = PairingsBn254.new_fr(
            0x000000000000000000000000000000000000000000000000000000000000000a
        );

        vk.g2_x = PairingsBn254.new_g2(
            [0x260e01b251f6f1c7e7ff4e580791dee8ea51d87a358e038b4efe30fac09383c1,
             0x0118c4d5b837bcc2bc89b5b398b5974e9f5944073b32078b7e231fec938883b0],
            [0x04fc6369f7110fe3d25156c1bb9a72859cf2a04641f99ba4ee413c80da6a5fe4,
             0x22febda3c0c0632a56475b4214e5615e11e6dd3f96e6cea2854a87d4dacc5e55]
        );
    }
    
    function getVkExit() internal pure returns(VerificationKey memory vk) {
        vk.domain_size = 262144;
        vk.num_inputs = 1;
        vk.omega = PairingsBn254.new_fr(0x0f60c8fe0414cb9379b2d39267945f6bd60d06a05216231b26a9fcf88ddbfebe);
        vk.selector_commitments[0] = PairingsBn254.new_g1(
            0x117ebe939b7336d17b69b05d5530e30326af39da45a989b078bb3d607707bf3e,
            0x18b16095a1c814fe2980170ff34490f1fd454e874caa87df2f739fb9c8d2e902
        );
        vk.selector_commitments[1] = PairingsBn254.new_g1(
            0x05ac70a10fc569cc8358bfb708c184446966c6b6a3e0d7c25183ded97f9e7933,
            0x0f6152282854e153588d45e784d216a423a624522a687741492ee0b807348e71
        );
        vk.selector_commitments[2] = PairingsBn254.new_g1(
            0x03cfa9d8f9b40e565435bee3c5b0e855c8612c5a89623557cc30f4588617d7bd,
            0x2292bb95c2cc2da55833b403a387e250a9575e32e4ce7d6caa954f12e6ce592a
        );
        vk.selector_commitments[3] = PairingsBn254.new_g1(
            0x04d04f495c69127b6cc6ecbfd23f77f178e7f4e2d2de3eab3e583a4997744cd9,
            0x09dcf5b3db29af5c5eef2759da26d3b6959cb8d80ada9f9b086f7cc39246ad2b
        );
        vk.selector_commitments[4] = PairingsBn254.new_g1(
            0x01ebab991522d407cfd4e8a1740b64617f0dfca50479bba2707c2ec4159039fc,
            0x2c8bd00a44c6120bbf8e57877013f2b5ee36b53eef4ea3b6748fd03568005946
        );
        vk.selector_commitments[5] = PairingsBn254.new_g1(
            0x07a7124d1fece66bd5428fcce25c22a4a9d5ceaa1e632565d9a062c39f005b5e,
            0x2044ae5306f0e114c48142b9b97001d94e3f2280db1b01a1e47ac1cf6bd5f99e
        );

        // we only have access to value of the d(x) witness polynomial on the next
        // trace step, so we only need one element here and deal with it in other places
        // by having this in mind
        vk.next_step_selector_commitments[0] = PairingsBn254.new_g1(
            0x1dd1549a639f052c4fbc95b7b7a40acf39928cad715580ba2b38baa116dacd9c,
            0x0f8e712990da1ce5195faaf80185ef0d5e430fdec9045a20af758cc8ecdac2e5
        );

         vk.permutation_commitments[0] = PairingsBn254.new_g1(
            0x0026b64066e39a22739be37fed73308ace0a5f38a0e2292dcc2309c818e8c89c,
            0x285101acca358974c2c7c9a8a3936e08fbd86779b877b416d9480c91518cb35b
        );
        vk.permutation_commitments[1] = PairingsBn254.new_g1(
            0x2159265ac6fcd4d0257673c3a85c17f4cf3ea13a3c9fb51e404037b13778d56f,
            0x25bf73e568ba3406ace2137195bb2176d9de87a48ae42520281aaef2ac2ef937
        );
        vk.permutation_commitments[2] = PairingsBn254.new_g1(
            0x068f29af99fc8bbf8c00659d34b6d34e4757af6edc10fc7647476cbd0ea9be63,
            0x2ef759b20cabf3da83d7f578d9e11ed60f7015440e77359db94475ddb303144d
        );
        vk.permutation_commitments[3] = PairingsBn254.new_g1(
            0x22793db6e98b9e37a1c5d78fcec67a2d8c527d34c5e9c8c1ff15007d30a4c133,
            0x1b683d60fd0750b3a45cdee5cbc4057204a02bd428e8071c92fe6694a40a5c1f
        );

        vk.permutation_non_residues[0] = PairingsBn254.new_fr(
            0x0000000000000000000000000000000000000000000000000000000000000005
        );
        vk.permutation_non_residues[1] = PairingsBn254.new_fr(
            0x0000000000000000000000000000000000000000000000000000000000000007
        );
        vk.permutation_non_residues[2] = PairingsBn254.new_fr(
            0x000000000000000000000000000000000000000000000000000000000000000a
        );

        vk.g2_x = PairingsBn254.new_g2(
            [0x260e01b251f6f1c7e7ff4e580791dee8ea51d87a358e038b4efe30fac09383c1,
             0x0118c4d5b837bcc2bc89b5b398b5974e9f5944073b32078b7e231fec938883b0],
            [0x04fc6369f7110fe3d25156c1bb9a72859cf2a04641f99ba4ee413c80da6a5fe4,
             0x22febda3c0c0632a56475b4214e5615e11e6dd3f96e6cea2854a87d4dacc5e55]
        );
    }
    

}
