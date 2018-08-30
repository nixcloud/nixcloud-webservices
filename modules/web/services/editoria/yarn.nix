{fetchurl, linkFarm}: rec {
  offline_cache = linkFarm "offline" packages;
  packages = [

    {
      name = "code-frame-7.0.0-beta.44.tgz";
      path = fetchurl {
        name = "code-frame-7.0.0-beta.44.tgz";
        url  = "https://registry.yarnpkg.com/@babel/code-frame/-/code-frame-7.0.0-beta.44.tgz";
        sha1 = "2a02643368de80916162be70865c97774f3adbd9";
      };
    }

    {
      name = "code-frame-7.0.0-beta.52.tgz";
      path = fetchurl {
        name = "code-frame-7.0.0-beta.52.tgz";
        url  = "https://registry.yarnpkg.com/@babel/code-frame/-/code-frame-7.0.0-beta.52.tgz";
        sha1 = "192483bfa0d1e467c101571c21029ccb74af2801";
      };
    }

    {
      name = "generator-7.0.0-beta.44.tgz";
      path = fetchurl {
        name = "generator-7.0.0-beta.44.tgz";
        url  = "https://registry.yarnpkg.com/@babel/generator/-/generator-7.0.0-beta.44.tgz";
        sha1 = "c7e67b9b5284afcf69b309b50d7d37f3e5033d42";
      };
    }

    {
      name = "helper-function-name-7.0.0-beta.44.tgz";
      path = fetchurl {
        name = "helper-function-name-7.0.0-beta.44.tgz";
        url  = "https://registry.yarnpkg.com/@babel/helper-function-name/-/helper-function-name-7.0.0-beta.44.tgz";
        sha1 = "e18552aaae2231100a6e485e03854bc3532d44dd";
      };
    }

    {
      name = "helper-get-function-arity-7.0.0-beta.44.tgz";
      path = fetchurl {
        name = "helper-get-function-arity-7.0.0-beta.44.tgz";
        url  = "https://registry.yarnpkg.com/@babel/helper-get-function-arity/-/helper-get-function-arity-7.0.0-beta.44.tgz";
        sha1 = "d03ca6dd2b9f7b0b1e6b32c56c72836140db3a15";
      };
    }

    {
      name = "helper-split-export-declaration-7.0.0-beta.44.tgz";
      path = fetchurl {
        name = "helper-split-export-declaration-7.0.0-beta.44.tgz";
        url  = "https://registry.yarnpkg.com/@babel/helper-split-export-declaration/-/helper-split-export-declaration-7.0.0-beta.44.tgz";
        sha1 = "c0b351735e0fbcb3822c8ad8db4e583b05ebd9dc";
      };
    }

    {
      name = "highlight-7.0.0-beta.44.tgz";
      path = fetchurl {
        name = "highlight-7.0.0-beta.44.tgz";
        url  = "https://registry.yarnpkg.com/@babel/highlight/-/highlight-7.0.0-beta.44.tgz";
        sha1 = "18c94ce543916a80553edcdcf681890b200747d5";
      };
    }

    {
      name = "highlight-7.0.0-beta.52.tgz";
      path = fetchurl {
        name = "highlight-7.0.0-beta.52.tgz";
        url  = "https://registry.yarnpkg.com/@babel/highlight/-/highlight-7.0.0-beta.52.tgz";
        sha1 = "ef24931432f06155e7bc39cdb8a6b37b4a28b3d0";
      };
    }

    {
      name = "runtime-7.0.0-beta.52.tgz";
      path = fetchurl {
        name = "runtime-7.0.0-beta.52.tgz";
        url  = "https://registry.yarnpkg.com/@babel/runtime/-/runtime-7.0.0-beta.52.tgz";
        sha1 = "3f3b42b82b92b4e1a283fc78df1bb2fd4ba8d0c7";
      };
    }

    {
      name = "template-7.0.0-beta.44.tgz";
      path = fetchurl {
        name = "template-7.0.0-beta.44.tgz";
        url  = "https://registry.yarnpkg.com/@babel/template/-/template-7.0.0-beta.44.tgz";
        sha1 = "f8832f4fdcee5d59bf515e595fc5106c529b394f";
      };
    }

    {
      name = "traverse-7.0.0-beta.44.tgz";
      path = fetchurl {
        name = "traverse-7.0.0-beta.44.tgz";
        url  = "https://registry.yarnpkg.com/@babel/traverse/-/traverse-7.0.0-beta.44.tgz";
        sha1 = "a970a2c45477ad18017e2e465a0606feee0d2966";
      };
    }

    {
      name = "types-7.0.0-beta.44.tgz";
      path = fetchurl {
        name = "types-7.0.0-beta.44.tgz";
        url  = "https://registry.yarnpkg.com/@babel/types/-/types-7.0.0-beta.44.tgz";
        sha1 = "6b1b164591f77dec0a0342aca995f2d046b3a757";
      };
    }

    {
      name = "component-polling-client-0.0.3.tgz";
      path = fetchurl {
        name = "component-polling-client-0.0.3.tgz";
        url  = "https://registry.yarnpkg.com/@pubsweet/component-polling-client/-/component-polling-client-0.0.3.tgz";
        sha1 = "c59f2066c476587376980932e542c152629b6a32";
      };
    }

    {
      name = "component-polling-server-0.0.7.tgz";
      path = fetchurl {
        name = "component-polling-server-0.0.7.tgz";
        url  = "https://registry.yarnpkg.com/@pubsweet/component-polling-server/-/component-polling-server-0.0.7.tgz";
        sha1 = "f0fee03407ab7a51aa3854279f95e1024d60d1e1";
      };
    }

    {
      name = "db-manager-1.2.1.tgz";
      path = fetchurl {
        name = "db-manager-1.2.1.tgz";
        url  = "https://registry.yarnpkg.com/@pubsweet/db-manager/-/db-manager-1.2.1.tgz";
        sha1 = "6b79f634bd3b448d2ac954014113cd21b1fdd7bb";
      };
    }

    {
      name = "default-theme-0.2.2.tgz";
      path = fetchurl {
        name = "default-theme-0.2.2.tgz";
        url  = "https://registry.yarnpkg.com/@pubsweet/default-theme/-/default-theme-0.2.2.tgz";
        sha1 = "23a229e74a7bdc63b951efe0f0bbd830fd5faa98";
      };
    }

    {
      name = "logger-0.0.1.tgz";
      path = fetchurl {
        name = "logger-0.0.1.tgz";
        url  = "https://registry.yarnpkg.com/@pubsweet/logger/-/logger-0.0.1.tgz";
        sha1 = "ec0c15f04e0c64232c29173848ffe6da8190c9c2";
      };
    }

    {
      name = "logger-0.2.4.tgz";
      path = fetchurl {
        name = "logger-0.2.4.tgz";
        url  = "https://registry.yarnpkg.com/@pubsweet/logger/-/logger-0.2.4.tgz";
        sha1 = "e7cf19661ef8d8f3b38868731d15620cb38f96b5";
      };
    }

    {
      name = "ui-4.1.3.tgz";
      path = fetchurl {
        name = "ui-4.1.3.tgz";
        url  = "https://registry.yarnpkg.com/@pubsweet/ui/-/ui-4.1.3.tgz";
        sha1 = "a8c65aa69618505a1e3777f4d18c3d676b800ee9";
      };
    }

    {
      name = "async-2.0.49.tgz";
      path = fetchurl {
        name = "async-2.0.49.tgz";
        url  = "https://registry.yarnpkg.com/@types/async/-/async-2.0.49.tgz";
        sha1 = "92e33d13f74c895cb9a7f38ba97db8431ed14bc0";
      };
    }

    {
      name = "error-stack-parser-1.3.18.tgz";
      path = fetchurl {
        name = "error-stack-parser-1.3.18.tgz";
        url  = "https://registry.yarnpkg.com/@types/error-stack-parser/-/error-stack-parser-1.3.18.tgz";
        sha1 = "e01c9f8c85ca83b610320c62258b0c9026ade0f7";
      };
    }

    {
      name = "graphql-0.12.6.tgz";
      path = fetchurl {
        name = "graphql-0.12.6.tgz";
        url  = "https://registry.yarnpkg.com/@types/graphql/-/graphql-0.12.6.tgz";
        sha1 = "3d619198585fcabe5f4e1adfb5cf5f3388c66c13";
      };
    }

    {
      name = "lodash-4.14.111.tgz";
      path = fetchurl {
        name = "lodash-4.14.111.tgz";
        url  = "https://registry.yarnpkg.com/@types/lodash/-/lodash-4.14.111.tgz";
        sha1 = "d926250baa9526c0ffe85914dd10363068e7893a";
      };
    }

    {
      name = "node-10.5.2.tgz";
      path = fetchurl {
        name = "node-10.5.2.tgz";
        url  = "https://registry.yarnpkg.com/@types/node/-/node-10.5.2.tgz";
        sha1 = "f19f05314d5421fe37e74153254201a7bf00a707";
      };
    }

    {
      name = "zen-observable-0.5.4.tgz";
      path = fetchurl {
        name = "zen-observable-0.5.4.tgz";
        url  = "https://registry.yarnpkg.com/@types/zen-observable/-/zen-observable-0.5.4.tgz";
        sha1 = "b863a4191e525206819e008097ebf0fb2e3a1cdc";
      };
    }

    {
      name = "JSONStream-1.3.3.tgz";
      path = fetchurl {
        name = "JSONStream-1.3.3.tgz";
        url  = "https://registry.yarnpkg.com/JSONStream/-/JSONStream-1.3.3.tgz";
        sha1 = "27b4b8fbbfeab4e71bcf551e7f27be8d952239bf";
      };
    }

    {
      name = "abab-1.0.4.tgz";
      path = fetchurl {
        name = "abab-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/abab/-/abab-1.0.4.tgz";
        sha1 = "5faad9c2c07f60dd76770f71cf025b62a63cfd4e";
      };
    }

    {
      name = "abbrev-1.1.1.tgz";
      path = fetchurl {
        name = "abbrev-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/abbrev/-/abbrev-1.1.1.tgz";
        sha1 = "f8f2c887ad10bf67f634f005b6987fed3179aac8";
      };
    }

    {
      name = "abstract-leveldown-2.4.1.tgz";
      path = fetchurl {
        name = "abstract-leveldown-2.4.1.tgz";
        url  = "https://registry.yarnpkg.com/abstract-leveldown/-/abstract-leveldown-2.4.1.tgz";
        sha1 = "b3bfedb884eb693a12775f0c55e9f0a420ccee64";
      };
    }

    {
      name = "abstract-leveldown-3.0.0.tgz";
      path = fetchurl {
        name = "abstract-leveldown-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/abstract-leveldown/-/abstract-leveldown-3.0.0.tgz";
        sha1 = "5cb89f958a44f526779d740d1440e743e0c30a57";
      };
    }

    {
      name = "accepts-1.3.5.tgz";
      path = fetchurl {
        name = "accepts-1.3.5.tgz";
        url  = "https://registry.yarnpkg.com/accepts/-/accepts-1.3.5.tgz";
        sha1 = "eb777df6011723a3b14e8a72c0805c8e86746bd2";
      };
    }

    {
      name = "acorn-dynamic-import-2.0.2.tgz";
      path = fetchurl {
        name = "acorn-dynamic-import-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/acorn-dynamic-import/-/acorn-dynamic-import-2.0.2.tgz";
        sha1 = "c752bd210bef679501b6c6cb7fc84f8f47158cc4";
      };
    }

    {
      name = "acorn-dynamic-import-3.0.0.tgz";
      path = fetchurl {
        name = "acorn-dynamic-import-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/acorn-dynamic-import/-/acorn-dynamic-import-3.0.0.tgz";
        sha1 = "901ceee4c7faaef7e07ad2a47e890675da50a278";
      };
    }

    {
      name = "acorn-globals-3.1.0.tgz";
      path = fetchurl {
        name = "acorn-globals-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/acorn-globals/-/acorn-globals-3.1.0.tgz";
        sha1 = "fd8270f71fbb4996b004fa880ee5d46573a731bf";
      };
    }

    {
      name = "acorn-globals-4.1.0.tgz";
      path = fetchurl {
        name = "acorn-globals-4.1.0.tgz";
        url  = "https://registry.yarnpkg.com/acorn-globals/-/acorn-globals-4.1.0.tgz";
        sha1 = "ab716025dbe17c54d3ef81d32ece2b2d99fe2538";
      };
    }

    {
      name = "acorn-jsx-3.0.1.tgz";
      path = fetchurl {
        name = "acorn-jsx-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/acorn-jsx/-/acorn-jsx-3.0.1.tgz";
        sha1 = "afdf9488fb1ecefc8348f6fb22f464e32a58b36b";
      };
    }

    {
      name = "acorn-jsx-4.1.1.tgz";
      path = fetchurl {
        name = "acorn-jsx-4.1.1.tgz";
        url  = "https://registry.yarnpkg.com/acorn-jsx/-/acorn-jsx-4.1.1.tgz";
        sha1 = "e8e41e48ea2fe0c896740610ab6a4ffd8add225e";
      };
    }

    {
      name = "acorn-3.3.0.tgz";
      path = fetchurl {
        name = "acorn-3.3.0.tgz";
        url  = "https://registry.yarnpkg.com/acorn/-/acorn-3.3.0.tgz";
        sha1 = "45e37fb39e8da3f25baee3ff5369e2bb5f22017a";
      };
    }

    {
      name = "acorn-4.0.13.tgz";
      path = fetchurl {
        name = "acorn-4.0.13.tgz";
        url  = "https://registry.yarnpkg.com/acorn/-/acorn-4.0.13.tgz";
        sha1 = "105495ae5361d697bd195c825192e1ad7f253787";
      };
    }

    {
      name = "acorn-5.7.1.tgz";
      path = fetchurl {
        name = "acorn-5.7.1.tgz";
        url  = "https://registry.yarnpkg.com/acorn/-/acorn-5.7.1.tgz";
        sha1 = "f095829297706a7c9776958c0afc8930a9b9d9d8";
      };
    }

    {
      name = "add-stream-1.0.0.tgz";
      path = fetchurl {
        name = "add-stream-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/add-stream/-/add-stream-1.0.0.tgz";
        sha1 = "6a7990437ca736d5e1288db92bd3266d5f5cb2aa";
      };
    }

    {
      name = "address-1.0.3.tgz";
      path = fetchurl {
        name = "address-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/address/-/address-1.0.3.tgz";
        sha1 = "b5f50631f8d6cec8bd20c963963afb55e06cbce9";
      };
    }

    {
      name = "ajv-keywords-1.5.1.tgz";
      path = fetchurl {
        name = "ajv-keywords-1.5.1.tgz";
        url  = "https://registry.yarnpkg.com/ajv-keywords/-/ajv-keywords-1.5.1.tgz";
        sha1 = "314dd0a4b3368fad3dfcdc54ede6171b886daf3c";
      };
    }

    {
      name = "ajv-keywords-2.1.1.tgz";
      path = fetchurl {
        name = "ajv-keywords-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/ajv-keywords/-/ajv-keywords-2.1.1.tgz";
        sha1 = "617997fc5f60576894c435f940d819e135b80762";
      };
    }

    {
      name = "ajv-keywords-3.2.0.tgz";
      path = fetchurl {
        name = "ajv-keywords-3.2.0.tgz";
        url  = "https://registry.yarnpkg.com/ajv-keywords/-/ajv-keywords-3.2.0.tgz";
        sha1 = "e86b819c602cf8821ad637413698f1dec021847a";
      };
    }

    {
      name = "ajv-4.11.8.tgz";
      path = fetchurl {
        name = "ajv-4.11.8.tgz";
        url  = "https://registry.yarnpkg.com/ajv/-/ajv-4.11.8.tgz";
        sha1 = "82ffb02b29e662ae53bdc20af15947706739c536";
      };
    }

    {
      name = "ajv-5.5.2.tgz";
      path = fetchurl {
        name = "ajv-5.5.2.tgz";
        url  = "https://registry.yarnpkg.com/ajv/-/ajv-5.5.2.tgz";
        sha1 = "73b5eeca3fab653e3d3f9422b341ad42205dc965";
      };
    }

    {
      name = "ajv-6.5.2.tgz";
      path = fetchurl {
        name = "ajv-6.5.2.tgz";
        url  = "https://registry.yarnpkg.com/ajv/-/ajv-6.5.2.tgz";
        sha1 = "678495f9b82f7cca6be248dd92f59bff5e1f4360";
      };
    }

    {
      name = "align-text-0.1.4.tgz";
      path = fetchurl {
        name = "align-text-0.1.4.tgz";
        url  = "https://registry.yarnpkg.com/align-text/-/align-text-0.1.4.tgz";
        sha1 = "0cd90a561093f35d0a99256c22b7069433fad117";
      };
    }

    {
      name = "alphanum-sort-1.0.2.tgz";
      path = fetchurl {
        name = "alphanum-sort-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/alphanum-sort/-/alphanum-sort-1.0.2.tgz";
        sha1 = "97a1119649b211ad33691d9f9f486a8ec9fbe0a3";
      };
    }

    {
      name = "amdefine-1.0.1.tgz";
      path = fetchurl {
        name = "amdefine-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/amdefine/-/amdefine-1.0.1.tgz";
        sha1 = "4a5282ac164729e93619bcfd3ad151f817ce91f5";
      };
    }

    {
      name = "ansi-escape-sequences-4.0.0.tgz";
      path = fetchurl {
        name = "ansi-escape-sequences-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/ansi-escape-sequences/-/ansi-escape-sequences-4.0.0.tgz";
        sha1 = "e0ecb042958b71e42942d35c1fcf1d9b00a0f67e";
      };
    }

    {
      name = "ansi-escapes-1.4.0.tgz";
      path = fetchurl {
        name = "ansi-escapes-1.4.0.tgz";
        url  = "https://registry.yarnpkg.com/ansi-escapes/-/ansi-escapes-1.4.0.tgz";
        sha1 = "d3a8a83b319aa67793662b13e761c7911422306e";
      };
    }

    {
      name = "ansi-escapes-2.0.0.tgz";
      path = fetchurl {
        name = "ansi-escapes-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/ansi-escapes/-/ansi-escapes-2.0.0.tgz";
        sha1 = "5bae52be424878dd9783e8910e3fc2922e83c81b";
      };
    }

    {
      name = "ansi-escapes-3.1.0.tgz";
      path = fetchurl {
        name = "ansi-escapes-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/ansi-escapes/-/ansi-escapes-3.1.0.tgz";
        sha1 = "f73207bb81207d75fd6c83f125af26eea378ca30";
      };
    }

    {
      name = "ansi-html-0.0.7.tgz";
      path = fetchurl {
        name = "ansi-html-0.0.7.tgz";
        url  = "https://registry.yarnpkg.com/ansi-html/-/ansi-html-0.0.7.tgz";
        sha1 = "813584021962a9e9e6fd039f940d12f56ca7859e";
      };
    }

    {
      name = "ansi-regex-2.1.1.tgz";
      path = fetchurl {
        name = "ansi-regex-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/ansi-regex/-/ansi-regex-2.1.1.tgz";
        sha1 = "c3b33ab5ee360d86e0e628f0468ae7ef27d654df";
      };
    }

    {
      name = "ansi-regex-3.0.0.tgz";
      path = fetchurl {
        name = "ansi-regex-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/ansi-regex/-/ansi-regex-3.0.0.tgz";
        sha1 = "ed0317c322064f79466c02966bddb605ab37d998";
      };
    }

    {
      name = "ansi-styles-2.2.1.tgz";
      path = fetchurl {
        name = "ansi-styles-2.2.1.tgz";
        url  = "https://registry.yarnpkg.com/ansi-styles/-/ansi-styles-2.2.1.tgz";
        sha1 = "b432dd3358b634cf75e1e4664368240533c1ddbe";
      };
    }

    {
      name = "ansi-styles-3.2.1.tgz";
      path = fetchurl {
        name = "ansi-styles-3.2.1.tgz";
        url  = "https://registry.yarnpkg.com/ansi-styles/-/ansi-styles-3.2.1.tgz";
        sha1 = "41fbb20243e50b12be0f04b8dedbf07520ce841d";
      };
    }

    {
      name = "ansicolors-0.2.1.tgz";
      path = fetchurl {
        name = "ansicolors-0.2.1.tgz";
        url  = "https://registry.yarnpkg.com/ansicolors/-/ansicolors-0.2.1.tgz";
        sha1 = "be089599097b74a5c9c4a84a0cdbcdb62bd87aef";
      };
    }

    {
      name = "any-observable-0.2.0.tgz";
      path = fetchurl {
        name = "any-observable-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/any-observable/-/any-observable-0.2.0.tgz";
        sha1 = "c67870058003579009083f54ac0abafb5c33d242";
      };
    }

    {
      name = "anymatch-1.3.2.tgz";
      path = fetchurl {
        name = "anymatch-1.3.2.tgz";
        url  = "https://registry.yarnpkg.com/anymatch/-/anymatch-1.3.2.tgz";
        sha1 = "553dcb8f91e3c889845dfdba34c77721b90b9d7a";
      };
    }

    {
      name = "anymatch-2.0.0.tgz";
      path = fetchurl {
        name = "anymatch-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/anymatch/-/anymatch-2.0.0.tgz";
        sha1 = "bcb24b4f37934d9aa7ac17b4adaf89e7c76ef2eb";
      };
    }

    {
      name = "apollo-cache-control-0.1.1.tgz";
      path = fetchurl {
        name = "apollo-cache-control-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/apollo-cache-control/-/apollo-cache-control-0.1.1.tgz";
        sha1 = "173d14ceb3eb9e7cb53de7eb8b61bee6159d4171";
      };
    }

    {
      name = "apollo-cache-inmemory-1.2.5.tgz";
      path = fetchurl {
        name = "apollo-cache-inmemory-1.2.5.tgz";
        url  = "https://registry.yarnpkg.com/apollo-cache-inmemory/-/apollo-cache-inmemory-1.2.5.tgz";
        sha1 = "b57951947b1db486a60db11c7dcfc6b112e5abe9";
      };
    }

    {
      name = "apollo-cache-1.1.12.tgz";
      path = fetchurl {
        name = "apollo-cache-1.1.12.tgz";
        url  = "https://registry.yarnpkg.com/apollo-cache/-/apollo-cache-1.1.12.tgz";
        sha1 = "070015c9051b2ebb69676beb10466a9c0b259f91";
      };
    }

    {
      name = "apollo-client-preset-1.0.8.tgz";
      path = fetchurl {
        name = "apollo-client-preset-1.0.8.tgz";
        url  = "https://registry.yarnpkg.com/apollo-client-preset/-/apollo-client-preset-1.0.8.tgz";
        sha1 = "23bd7176849d0d815f12c648774d009b258a449e";
      };
    }

    {
      name = "apollo-client-2.3.5.tgz";
      path = fetchurl {
        name = "apollo-client-2.3.5.tgz";
        url  = "https://registry.yarnpkg.com/apollo-client/-/apollo-client-2.3.5.tgz";
        sha1 = "74b62bd7e7bd7030d01c35e2e221ed65a807af23";
      };
    }

    {
      name = "apollo-link-context-1.0.8.tgz";
      path = fetchurl {
        name = "apollo-link-context-1.0.8.tgz";
        url  = "https://registry.yarnpkg.com/apollo-link-context/-/apollo-link-context-1.0.8.tgz";
        sha1 = "c967a56ac6ed32add748937735bcb57c5cc64c95";
      };
    }

    {
      name = "apollo-link-dedup-1.0.9.tgz";
      path = fetchurl {
        name = "apollo-link-dedup-1.0.9.tgz";
        url  = "https://registry.yarnpkg.com/apollo-link-dedup/-/apollo-link-dedup-1.0.9.tgz";
        sha1 = "3c4e4af88ef027cbddfdb857c043fd0574051dad";
      };
    }

    {
      name = "apollo-link-http-common-0.2.4.tgz";
      path = fetchurl {
        name = "apollo-link-http-common-0.2.4.tgz";
        url  = "https://registry.yarnpkg.com/apollo-link-http-common/-/apollo-link-http-common-0.2.4.tgz";
        sha1 = "877603f7904dc8f70242cac61808b1f8d034b2c3";
      };
    }

    {
      name = "apollo-link-http-1.5.4.tgz";
      path = fetchurl {
        name = "apollo-link-http-1.5.4.tgz";
        url  = "https://registry.yarnpkg.com/apollo-link-http/-/apollo-link-http-1.5.4.tgz";
        sha1 = "b80b7b4b342c655b6a5614624b076a36be368f43";
      };
    }

    {
      name = "apollo-link-1.2.2.tgz";
      path = fetchurl {
        name = "apollo-link-1.2.2.tgz";
        url  = "https://registry.yarnpkg.com/apollo-link/-/apollo-link-1.2.2.tgz";
        sha1 = "54c84199b18ac1af8d63553a68ca389c05217a03";
      };
    }

    {
      name = "apollo-server-core-1.3.6.tgz";
      path = fetchurl {
        name = "apollo-server-core-1.3.6.tgz";
        url  = "https://registry.yarnpkg.com/apollo-server-core/-/apollo-server-core-1.3.6.tgz";
        sha1 = "08636243c2de56fa8c267d68dd602cb1fbd323e3";
      };
    }

    {
      name = "apollo-server-express-1.3.6.tgz";
      path = fetchurl {
        name = "apollo-server-express-1.3.6.tgz";
        url  = "https://registry.yarnpkg.com/apollo-server-express/-/apollo-server-express-1.3.6.tgz";
        sha1 = "2120b05021a87def44fafd846e8a0e2a32852db7";
      };
    }

    {
      name = "apollo-server-module-graphiql-1.3.4.tgz";
      path = fetchurl {
        name = "apollo-server-module-graphiql-1.3.4.tgz";
        url  = "https://registry.yarnpkg.com/apollo-server-module-graphiql/-/apollo-server-module-graphiql-1.3.4.tgz";
        sha1 = "50399b7c51b7267d0c841529f5173e5fc7304de4";
      };
    }

    {
      name = "apollo-tracing-0.1.4.tgz";
      path = fetchurl {
        name = "apollo-tracing-0.1.4.tgz";
        url  = "https://registry.yarnpkg.com/apollo-tracing/-/apollo-tracing-0.1.4.tgz";
        sha1 = "5b8ae1b01526b160ee6e552a7f131923a9aedcc7";
      };
    }

    {
      name = "apollo-upload-client-8.1.0.tgz";
      path = fetchurl {
        name = "apollo-upload-client-8.1.0.tgz";
        url  = "https://registry.yarnpkg.com/apollo-upload-client/-/apollo-upload-client-8.1.0.tgz";
        sha1 = "db99eed6af926dbd54cb0bbde30345672c97fc5f";
      };
    }

    {
      name = "apollo-upload-server-4.0.2.tgz";
      path = fetchurl {
        name = "apollo-upload-server-4.0.2.tgz";
        url  = "https://registry.yarnpkg.com/apollo-upload-server/-/apollo-upload-server-4.0.2.tgz";
        sha1 = "1a042e413d09d4bd5529738f9e0af45ba553cc2d";
      };
    }

    {
      name = "apollo-utilities-1.0.16.tgz";
      path = fetchurl {
        name = "apollo-utilities-1.0.16.tgz";
        url  = "https://registry.yarnpkg.com/apollo-utilities/-/apollo-utilities-1.0.16.tgz";
        sha1 = "787310df4c3900a68c0beb3d351c59725a588cdb";
      };
    }

    {
      name = "app-module-path-2.2.0.tgz";
      path = fetchurl {
        name = "app-module-path-2.2.0.tgz";
        url  = "https://registry.yarnpkg.com/app-module-path/-/app-module-path-2.2.0.tgz";
        sha1 = "641aa55dfb7d6a6f0a8141c4b9c0aa50b6c24dd5";
      };
    }

    {
      name = "app-root-path-2.1.0.tgz";
      path = fetchurl {
        name = "app-root-path-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/app-root-path/-/app-root-path-2.1.0.tgz";
        sha1 = "98bf6599327ecea199309866e8140368fd2e646a";
      };
    }

    {
      name = "append-field-0.1.0.tgz";
      path = fetchurl {
        name = "append-field-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/append-field/-/append-field-0.1.0.tgz";
        sha1 = "6ddc58fa083c7bc545d3c5995b2830cc2366d44a";
      };
    }

    {
      name = "append-transform-1.0.0.tgz";
      path = fetchurl {
        name = "append-transform-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/append-transform/-/append-transform-1.0.0.tgz";
        sha1 = "046a52ae582a228bd72f58acfbe2967c678759ab";
      };
    }

    {
      name = "aproba-1.2.0.tgz";
      path = fetchurl {
        name = "aproba-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/aproba/-/aproba-1.2.0.tgz";
        sha1 = "6802e6264efd18c790a1b0d517f0f2627bf2c94a";
      };
    }

    {
      name = "archiver-utils-1.3.0.tgz";
      path = fetchurl {
        name = "archiver-utils-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/archiver-utils/-/archiver-utils-1.3.0.tgz";
        sha1 = "e50b4c09c70bf3d680e32ff1b7994e9f9d895174";
      };
    }

    {
      name = "archiver-2.1.1.tgz";
      path = fetchurl {
        name = "archiver-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/archiver/-/archiver-2.1.1.tgz";
        sha1 = "ff662b4a78201494a3ee544d3a33fe7496509ebc";
      };
    }

    {
      name = "are-we-there-yet-1.1.5.tgz";
      path = fetchurl {
        name = "are-we-there-yet-1.1.5.tgz";
        url  = "https://registry.yarnpkg.com/are-we-there-yet/-/are-we-there-yet-1.1.5.tgz";
        sha1 = "4b35c2944f062a8bfcda66410760350fe9ddfc21";
      };
    }

    {
      name = "argparse-1.0.10.tgz";
      path = fetchurl {
        name = "argparse-1.0.10.tgz";
        url  = "https://registry.yarnpkg.com/argparse/-/argparse-1.0.10.tgz";
        sha1 = "bcd6791ea5ae09725e17e5ad988134cd40b3d911";
      };
    }

    {
      name = "argsarray-0.0.1.tgz";
      path = fetchurl {
        name = "argsarray-0.0.1.tgz";
        url  = "https://registry.yarnpkg.com/argsarray/-/argsarray-0.0.1.tgz";
        sha1 = "6e7207b4ecdb39b0af88303fa5ae22bda8df61cb";
      };
    }

    {
      name = "argv-tools-0.1.1.tgz";
      path = fetchurl {
        name = "argv-tools-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/argv-tools/-/argv-tools-0.1.1.tgz";
        sha1 = "588283f3393ada47141440b12981cd41bf6b7032";
      };
    }

    {
      name = "aria-query-3.0.0.tgz";
      path = fetchurl {
        name = "aria-query-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/aria-query/-/aria-query-3.0.0.tgz";
        sha1 = "65b3fcc1ca1155a8c9ae64d6eee297f15d5133cc";
      };
    }

    {
      name = "arr-diff-2.0.0.tgz";
      path = fetchurl {
        name = "arr-diff-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/arr-diff/-/arr-diff-2.0.0.tgz";
        sha1 = "8f3b827f955a8bd669697e4a4256ac3ceae356cf";
      };
    }

    {
      name = "arr-diff-4.0.0.tgz";
      path = fetchurl {
        name = "arr-diff-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/arr-diff/-/arr-diff-4.0.0.tgz";
        sha1 = "d6461074febfec71e7e15235761a329a5dc7c520";
      };
    }

    {
      name = "arr-flatten-1.1.0.tgz";
      path = fetchurl {
        name = "arr-flatten-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/arr-flatten/-/arr-flatten-1.1.0.tgz";
        sha1 = "36048bbff4e7b47e136644316c99669ea5ae91f1";
      };
    }

    {
      name = "arr-union-3.1.0.tgz";
      path = fetchurl {
        name = "arr-union-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/arr-union/-/arr-union-3.1.0.tgz";
        sha1 = "e39b09aea9def866a8f206e288af63919bae39c4";
      };
    }

    {
      name = "array-back-1.0.4.tgz";
      path = fetchurl {
        name = "array-back-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/array-back/-/array-back-1.0.4.tgz";
        sha1 = "644ba7f095f7ffcf7c43b5f0dc39d3c1f03c063b";
      };
    }

    {
      name = "array-back-2.0.0.tgz";
      path = fetchurl {
        name = "array-back-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/array-back/-/array-back-2.0.0.tgz";
        sha1 = "6877471d51ecc9c9bfa6136fb6c7d5fe69748022";
      };
    }

    {
      name = "array-equal-1.0.0.tgz";
      path = fetchurl {
        name = "array-equal-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/array-equal/-/array-equal-1.0.0.tgz";
        sha1 = "8c2a5ef2472fd9ea742b04c77a75093ba2757c93";
      };
    }

    {
      name = "array-filter-0.0.1.tgz";
      path = fetchurl {
        name = "array-filter-0.0.1.tgz";
        url  = "https://registry.yarnpkg.com/array-filter/-/array-filter-0.0.1.tgz";
        sha1 = "7da8cf2e26628ed732803581fd21f67cacd2eeec";
      };
    }

    {
      name = "array-find-index-1.0.2.tgz";
      path = fetchurl {
        name = "array-find-index-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/array-find-index/-/array-find-index-1.0.2.tgz";
        sha1 = "df010aa1287e164bbda6f9723b0a96a1ec4187a1";
      };
    }

    {
      name = "array-find-1.0.0.tgz";
      path = fetchurl {
        name = "array-find-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/array-find/-/array-find-1.0.0.tgz";
        sha1 = "6c8e286d11ed768327f8e62ecee87353ca3e78b8";
      };
    }

    {
      name = "array-flatten-1.1.1.tgz";
      path = fetchurl {
        name = "array-flatten-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/array-flatten/-/array-flatten-1.1.1.tgz";
        sha1 = "9a5f699051b1e7073328f2a008968b64ea2955d2";
      };
    }

    {
      name = "array-flatten-2.1.1.tgz";
      path = fetchurl {
        name = "array-flatten-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/array-flatten/-/array-flatten-2.1.1.tgz";
        sha1 = "426bb9da84090c1838d812c8150af20a8331e296";
      };
    }

    {
      name = "array-ify-1.0.0.tgz";
      path = fetchurl {
        name = "array-ify-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/array-ify/-/array-ify-1.0.0.tgz";
        sha1 = "9e528762b4a9066ad163a6962a364418e9626ece";
      };
    }

    {
      name = "array-includes-3.0.3.tgz";
      path = fetchurl {
        name = "array-includes-3.0.3.tgz";
        url  = "https://registry.yarnpkg.com/array-includes/-/array-includes-3.0.3.tgz";
        sha1 = "184b48f62d92d7452bb31b323165c7f8bd02266d";
      };
    }

    {
      name = "array-iterate-1.1.2.tgz";
      path = fetchurl {
        name = "array-iterate-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/array-iterate/-/array-iterate-1.1.2.tgz";
        sha1 = "f66a57e84426f8097f4197fbb6c051b8e5cdf7d8";
      };
    }

    {
      name = "array-map-0.0.0.tgz";
      path = fetchurl {
        name = "array-map-0.0.0.tgz";
        url  = "https://registry.yarnpkg.com/array-map/-/array-map-0.0.0.tgz";
        sha1 = "88a2bab73d1cf7bcd5c1b118a003f66f665fa662";
      };
    }

    {
      name = "array-reduce-0.0.0.tgz";
      path = fetchurl {
        name = "array-reduce-0.0.0.tgz";
        url  = "https://registry.yarnpkg.com/array-reduce/-/array-reduce-0.0.0.tgz";
        sha1 = "173899d3ffd1c7d9383e4479525dbe278cab5f2b";
      };
    }

    {
      name = "array-union-1.0.2.tgz";
      path = fetchurl {
        name = "array-union-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/array-union/-/array-union-1.0.2.tgz";
        sha1 = "9a34410e4f4e3da23dea375be5be70f24778ec39";
      };
    }

    {
      name = "array-uniq-1.0.3.tgz";
      path = fetchurl {
        name = "array-uniq-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/array-uniq/-/array-uniq-1.0.3.tgz";
        sha1 = "af6ac877a25cc7f74e058894753858dfdb24fdb6";
      };
    }

    {
      name = "array-unique-0.2.1.tgz";
      path = fetchurl {
        name = "array-unique-0.2.1.tgz";
        url  = "https://registry.yarnpkg.com/array-unique/-/array-unique-0.2.1.tgz";
        sha1 = "a1d97ccafcbc2625cc70fadceb36a50c58b01a53";
      };
    }

    {
      name = "array-unique-0.3.2.tgz";
      path = fetchurl {
        name = "array-unique-0.3.2.tgz";
        url  = "https://registry.yarnpkg.com/array-unique/-/array-unique-0.3.2.tgz";
        sha1 = "a894b75d4bc4f6cd679ef3244a9fd8f46ae2d428";
      };
    }

    {
      name = "array.prototype.find-2.0.4.tgz";
      path = fetchurl {
        name = "array.prototype.find-2.0.4.tgz";
        url  = "https://registry.yarnpkg.com/array.prototype.find/-/array.prototype.find-2.0.4.tgz";
        sha1 = "556a5c5362c08648323ddaeb9de9d14bc1864c90";
      };
    }

    {
      name = "arrify-1.0.1.tgz";
      path = fetchurl {
        name = "arrify-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/arrify/-/arrify-1.0.1.tgz";
        sha1 = "898508da2226f380df904728456849c1501a4b0d";
      };
    }

    {
      name = "asap-2.0.6.tgz";
      path = fetchurl {
        name = "asap-2.0.6.tgz";
        url  = "https://registry.yarnpkg.com/asap/-/asap-2.0.6.tgz";
        sha1 = "e50347611d7e690943208bbdafebcbc2fb866d46";
      };
    }

    {
      name = "asn1.js-4.10.1.tgz";
      path = fetchurl {
        name = "asn1.js-4.10.1.tgz";
        url  = "https://registry.yarnpkg.com/asn1.js/-/asn1.js-4.10.1.tgz";
        sha1 = "b9c2bf5805f1e64aadeed6df3a2bfafb5a73f5a0";
      };
    }

    {
      name = "asn1-0.2.3.tgz";
      path = fetchurl {
        name = "asn1-0.2.3.tgz";
        url  = "https://registry.yarnpkg.com/asn1/-/asn1-0.2.3.tgz";
        sha1 = "dac8787713c9966849fc8180777ebe9c1ddf3b86";
      };
    }

    {
      name = "assert-plus-1.0.0.tgz";
      path = fetchurl {
        name = "assert-plus-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/assert-plus/-/assert-plus-1.0.0.tgz";
        sha1 = "f12e0f3c5d77b0b1cdd9146942e4e96c1e4dd525";
      };
    }

    {
      name = "assert-plus-0.2.0.tgz";
      path = fetchurl {
        name = "assert-plus-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/assert-plus/-/assert-plus-0.2.0.tgz";
        sha1 = "d74e1b87e7affc0db8aadb7021f3fe48101ab234";
      };
    }

    {
      name = "assert-1.4.1.tgz";
      path = fetchurl {
        name = "assert-1.4.1.tgz";
        url  = "https://registry.yarnpkg.com/assert/-/assert-1.4.1.tgz";
        sha1 = "99912d591836b5a6f5b345c0f07eefc08fc65d91";
      };
    }

    {
      name = "assertion-error-1.1.0.tgz";
      path = fetchurl {
        name = "assertion-error-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/assertion-error/-/assertion-error-1.1.0.tgz";
        sha1 = "e60b6b0e8f301bd97e5375215bda406c85118c0b";
      };
    }

    {
      name = "assign-symbols-1.0.0.tgz";
      path = fetchurl {
        name = "assign-symbols-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/assign-symbols/-/assign-symbols-1.0.0.tgz";
        sha1 = "59667f41fadd4f20ccbc2bb96b8d4f7f78ec0367";
      };
    }

    {
      name = "ast-types-flow-0.0.7.tgz";
      path = fetchurl {
        name = "ast-types-flow-0.0.7.tgz";
        url  = "https://registry.yarnpkg.com/ast-types-flow/-/ast-types-flow-0.0.7.tgz";
        sha1 = "f70b735c6bca1a5c9c22d982c3e39e7feba3bdad";
      };
    }

    {
      name = "ast-types-0.10.1.tgz";
      path = fetchurl {
        name = "ast-types-0.10.1.tgz";
        url  = "https://registry.yarnpkg.com/ast-types/-/ast-types-0.10.1.tgz";
        sha1 = "f52fca9715579a14f841d67d7f8d25432ab6a3dd";
      };
    }

    {
      name = "ast-types-0.9.11.tgz";
      path = fetchurl {
        name = "ast-types-0.9.11.tgz";
        url  = "https://registry.yarnpkg.com/ast-types/-/ast-types-0.9.11.tgz";
        sha1 = "371177bb59232ff5ceaa1d09ee5cad705b1a5aa9";
      };
    }

    {
      name = "ast-types-0.11.5.tgz";
      path = fetchurl {
        name = "ast-types-0.11.5.tgz";
        url  = "https://registry.yarnpkg.com/ast-types/-/ast-types-0.11.5.tgz";
        sha1 = "9890825d660c03c28339f315e9fa0a360e31ec28";
      };
    }

    {
      name = "ast-types-0.7.8.tgz";
      path = fetchurl {
        name = "ast-types-0.7.8.tgz";
        url  = "https://registry.yarnpkg.com/ast-types/-/ast-types-0.7.8.tgz";
        sha1 = "902d2e0d60d071bdcd46dc115e1809ed11c138a9";
      };
    }

    {
      name = "astral-regex-1.0.0.tgz";
      path = fetchurl {
        name = "astral-regex-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/astral-regex/-/astral-regex-1.0.0.tgz";
        sha1 = "6c8c3fb827dd43ee3918f27b82782ab7658a6fd9";
      };
    }

    {
      name = "async-each-1.0.1.tgz";
      path = fetchurl {
        name = "async-each-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/async-each/-/async-each-1.0.1.tgz";
        sha1 = "19d386a1d9edc6e7c1c85d388aedbcc56d33602d";
      };
    }

    {
      name = "async-exit-hook-1.1.2.tgz";
      path = fetchurl {
        name = "async-exit-hook-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/async-exit-hook/-/async-exit-hook-1.1.2.tgz";
        sha1 = "8095d75e488c29acee0551fe87252169d789cfba";
      };
    }

    {
      name = "async-foreach-0.1.3.tgz";
      path = fetchurl {
        name = "async-foreach-0.1.3.tgz";
        url  = "https://registry.yarnpkg.com/async-foreach/-/async-foreach-0.1.3.tgz";
        sha1 = "36121f845c0578172de419a97dbeb1d16ec34542";
      };
    }

    {
      name = "async-limiter-1.0.0.tgz";
      path = fetchurl {
        name = "async-limiter-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/async-limiter/-/async-limiter-1.0.0.tgz";
        sha1 = "78faed8c3d074ab81f22b4e985d79e8738f720f8";
      };
    }

    {
      name = "async-0.2.6.tgz";
      path = fetchurl {
        name = "async-0.2.6.tgz";
        url  = "https://registry.yarnpkg.com/async/-/async-0.2.6.tgz";
        sha1 = "ad3f373d9249ae324881565582bc90e152abbd68";
      };
    }

    {
      name = "async-0.2.9.tgz";
      path = fetchurl {
        name = "async-0.2.9.tgz";
        url  = "https://registry.yarnpkg.com/async/-/async-0.2.9.tgz";
        sha1 = "df63060fbf3d33286a76aaf6d55a2986d9ff8619";
      };
    }

    {
      name = "async-0.2.10.tgz";
      path = fetchurl {
        name = "async-0.2.10.tgz";
        url  = "https://registry.yarnpkg.com/async/-/async-0.2.10.tgz";
        sha1 = "b6bbe0b0674b9d719708ca38de8c237cb526c3d1";
      };
    }

    {
      name = "async-1.5.2.tgz";
      path = fetchurl {
        name = "async-1.5.2.tgz";
        url  = "https://registry.yarnpkg.com/async/-/async-1.5.2.tgz";
        sha1 = "ec6a61ae56480c0c3cb241c95618e20892f9672a";
      };
    }

    {
      name = "async-2.6.1.tgz";
      path = fetchurl {
        name = "async-2.6.1.tgz";
        url  = "https://registry.yarnpkg.com/async/-/async-2.6.1.tgz";
        sha1 = "b245a23ca71930044ec53fa46aa00a3e87c6a610";
      };
    }

    {
      name = "async-0.9.2.tgz";
      path = fetchurl {
        name = "async-0.9.2.tgz";
        url  = "https://registry.yarnpkg.com/async/-/async-0.9.2.tgz";
        sha1 = "aea74d5e61c1f899613bf64bda66d4c78f2fd17d";
      };
    }

    {
      name = "async-1.0.0.tgz";
      path = fetchurl {
        name = "async-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/async/-/async-1.0.0.tgz";
        sha1 = "f8fc04ca3a13784ade9e1641af98578cfbd647a9";
      };
    }

    {
      name = "asynckit-0.4.0.tgz";
      path = fetchurl {
        name = "asynckit-0.4.0.tgz";
        url  = "https://registry.yarnpkg.com/asynckit/-/asynckit-0.4.0.tgz";
        sha1 = "c79ed97f7f34cb8f2ba1bc9790bcc366474b4b79";
      };
    }

    {
      name = "atob-2.1.1.tgz";
      path = fetchurl {
        name = "atob-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/atob/-/atob-2.1.1.tgz";
        sha1 = "ae2d5a729477f289d60dd7f96a6314a22dd6c22a";
      };
    }

    {
      name = "atob-1.1.3.tgz";
      path = fetchurl {
        name = "atob-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/atob/-/atob-1.1.3.tgz";
        sha1 = "95f13629b12c3a51a5d215abdce2aa9f32f80773";
      };
    }

    {
      name = "attempt-x-1.1.3.tgz";
      path = fetchurl {
        name = "attempt-x-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/attempt-x/-/attempt-x-1.1.3.tgz";
        sha1 = "9ac844c75bca2c4e9e30d8d5c01f41eeb481a8b7";
      };
    }

    {
      name = "attr-accept-1.1.3.tgz";
      path = fetchurl {
        name = "attr-accept-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/attr-accept/-/attr-accept-1.1.3.tgz";
        sha1 = "48230c79f93790ef2775fcec4f0db0f5db41ca52";
      };
    }

    {
      name = "authsome-0.1.0.tgz";
      path = fetchurl {
        name = "authsome-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/authsome/-/authsome-0.1.0.tgz";
        sha1 = "4152e666afcaa7f7c51ddbed94145ad7105904d9";
      };
    }

    {
      name = "autobind-decorator-1.4.3.tgz";
      path = fetchurl {
        name = "autobind-decorator-1.4.3.tgz";
        url  = "https://registry.yarnpkg.com/autobind-decorator/-/autobind-decorator-1.4.3.tgz";
        sha1 = "4c96ffa77b10622ede24f110f5dbbf56691417d1";
      };
    }

    {
      name = "autoprefixer-6.7.7.tgz";
      path = fetchurl {
        name = "autoprefixer-6.7.7.tgz";
        url  = "https://registry.yarnpkg.com/autoprefixer/-/autoprefixer-6.7.7.tgz";
        sha1 = "1dbd1c835658e35ce3f9984099db00585c782014";
      };
    }

    {
      name = "autoprefixer-7.2.6.tgz";
      path = fetchurl {
        name = "autoprefixer-7.2.6.tgz";
        url  = "https://registry.yarnpkg.com/autoprefixer/-/autoprefixer-7.2.6.tgz";
        sha1 = "256672f86f7c735da849c4f07d008abb056067dc";
      };
    }

    {
      name = "aws-sign2-0.6.0.tgz";
      path = fetchurl {
        name = "aws-sign2-0.6.0.tgz";
        url  = "https://registry.yarnpkg.com/aws-sign2/-/aws-sign2-0.6.0.tgz";
        sha1 = "14342dd38dbcc94d0e5b87d763cd63612c0e794f";
      };
    }

    {
      name = "aws-sign2-0.7.0.tgz";
      path = fetchurl {
        name = "aws-sign2-0.7.0.tgz";
        url  = "https://registry.yarnpkg.com/aws-sign2/-/aws-sign2-0.7.0.tgz";
        sha1 = "b46e890934a9591f2d2f6f86d7e6a9f1b3fe76a8";
      };
    }

    {
      name = "aws4-1.7.0.tgz";
      path = fetchurl {
        name = "aws4-1.7.0.tgz";
        url  = "https://registry.yarnpkg.com/aws4/-/aws4-1.7.0.tgz";
        sha1 = "d4d0e9b9dbfca77bf08eeb0a8a471550fe39e289";
      };
    }

    {
      name = "axios-0.17.1.tgz";
      path = fetchurl {
        name = "axios-0.17.1.tgz";
        url  = "https://registry.yarnpkg.com/axios/-/axios-0.17.1.tgz";
        sha1 = "2d8e3e5d0bdbd7327f91bc814f5c57660f81824d";
      };
    }

    {
      name = "axobject-query-2.0.1.tgz";
      path = fetchurl {
        name = "axobject-query-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/axobject-query/-/axobject-query-2.0.1.tgz";
        sha1 = "05dfa705ada8ad9db993fa6896f22d395b0b0a07";
      };
    }

    {
      name = "babel-code-frame-6.26.0.tgz";
      path = fetchurl {
        name = "babel-code-frame-6.26.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-code-frame/-/babel-code-frame-6.26.0.tgz";
        sha1 = "63fd43f7dc1e3bb7ce35947db8fe369a3f58c74b";
      };
    }

    {
      name = "babel-core-6.26.3.tgz";
      path = fetchurl {
        name = "babel-core-6.26.3.tgz";
        url  = "https://registry.yarnpkg.com/babel-core/-/babel-core-6.26.3.tgz";
        sha1 = "b2e2f09e342d0f0c88e2f02e067794125e75c207";
      };
    }

    {
      name = "babel-eslint-8.2.5.tgz";
      path = fetchurl {
        name = "babel-eslint-8.2.5.tgz";
        url  = "https://registry.yarnpkg.com/babel-eslint/-/babel-eslint-8.2.5.tgz";
        sha1 = "dc2331c259d36782aa189da510c43dedd5adc7a3";
      };
    }

    {
      name = "babel-generator-6.26.1.tgz";
      path = fetchurl {
        name = "babel-generator-6.26.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-generator/-/babel-generator-6.26.1.tgz";
        sha1 = "1844408d3b8f0d35a404ea7ac180f087a601bd90";
      };
    }

    {
      name = "babel-helper-bindify-decorators-6.24.1.tgz";
      path = fetchurl {
        name = "babel-helper-bindify-decorators-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-bindify-decorators/-/babel-helper-bindify-decorators-6.24.1.tgz";
        sha1 = "14c19e5f142d7b47f19a52431e52b1ccbc40a330";
      };
    }

    {
      name = "babel-helper-builder-binary-assignment-operator-visitor-6.24.1.tgz";
      path = fetchurl {
        name = "babel-helper-builder-binary-assignment-operator-visitor-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-builder-binary-assignment-operator-visitor/-/babel-helper-builder-binary-assignment-operator-visitor-6.24.1.tgz";
        sha1 = "cce4517ada356f4220bcae8a02c2b346f9a56664";
      };
    }

    {
      name = "babel-helper-builder-react-jsx-6.26.0.tgz";
      path = fetchurl {
        name = "babel-helper-builder-react-jsx-6.26.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-builder-react-jsx/-/babel-helper-builder-react-jsx-6.26.0.tgz";
        sha1 = "39ff8313b75c8b65dceff1f31d383e0ff2a408a0";
      };
    }

    {
      name = "babel-helper-call-delegate-6.24.1.tgz";
      path = fetchurl {
        name = "babel-helper-call-delegate-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-call-delegate/-/babel-helper-call-delegate-6.24.1.tgz";
        sha1 = "ece6aacddc76e41c3461f88bfc575bd0daa2df8d";
      };
    }

    {
      name = "babel-helper-define-map-6.26.0.tgz";
      path = fetchurl {
        name = "babel-helper-define-map-6.26.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-define-map/-/babel-helper-define-map-6.26.0.tgz";
        sha1 = "a5f56dab41a25f97ecb498c7ebaca9819f95be5f";
      };
    }

    {
      name = "babel-helper-evaluate-path-0.0.3.tgz";
      path = fetchurl {
        name = "babel-helper-evaluate-path-0.0.3.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-evaluate-path/-/babel-helper-evaluate-path-0.0.3.tgz";
        sha1 = "1d103ac9d4a59e5d431842212f151785f7ac547b";
      };
    }

    {
      name = "babel-helper-evaluate-path-0.3.0.tgz";
      path = fetchurl {
        name = "babel-helper-evaluate-path-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-evaluate-path/-/babel-helper-evaluate-path-0.3.0.tgz";
        sha1 = "2439545e0b6eae5b7f49b790acbebd6b9a73df20";
      };
    }

    {
      name = "babel-helper-explode-assignable-expression-6.24.1.tgz";
      path = fetchurl {
        name = "babel-helper-explode-assignable-expression-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-explode-assignable-expression/-/babel-helper-explode-assignable-expression-6.24.1.tgz";
        sha1 = "f25b82cf7dc10433c55f70592d5746400ac22caa";
      };
    }

    {
      name = "babel-helper-explode-class-6.24.1.tgz";
      path = fetchurl {
        name = "babel-helper-explode-class-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-explode-class/-/babel-helper-explode-class-6.24.1.tgz";
        sha1 = "7dc2a3910dee007056e1e31d640ced3d54eaa9eb";
      };
    }

    {
      name = "babel-helper-flip-expressions-0.0.2.tgz";
      path = fetchurl {
        name = "babel-helper-flip-expressions-0.0.2.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-flip-expressions/-/babel-helper-flip-expressions-0.0.2.tgz";
        sha1 = "7bab2cf61162bc92703e9b298ef512bcf77d6787";
      };
    }

    {
      name = "babel-helper-flip-expressions-0.3.0.tgz";
      path = fetchurl {
        name = "babel-helper-flip-expressions-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-flip-expressions/-/babel-helper-flip-expressions-0.3.0.tgz";
        sha1 = "f5b6394bd5219b43cf8f7b201535ed540c6e7fa2";
      };
    }

    {
      name = "babel-helper-function-name-6.24.1.tgz";
      path = fetchurl {
        name = "babel-helper-function-name-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-function-name/-/babel-helper-function-name-6.24.1.tgz";
        sha1 = "d3475b8c03ed98242a25b48351ab18399d3580a9";
      };
    }

    {
      name = "babel-helper-get-function-arity-6.24.1.tgz";
      path = fetchurl {
        name = "babel-helper-get-function-arity-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-get-function-arity/-/babel-helper-get-function-arity-6.24.1.tgz";
        sha1 = "8f7782aa93407c41d3aa50908f89b031b1b6853d";
      };
    }

    {
      name = "babel-helper-hoist-variables-6.24.1.tgz";
      path = fetchurl {
        name = "babel-helper-hoist-variables-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-hoist-variables/-/babel-helper-hoist-variables-6.24.1.tgz";
        sha1 = "1ecb27689c9d25513eadbc9914a73f5408be7a76";
      };
    }

    {
      name = "babel-helper-is-nodes-equiv-0.0.1.tgz";
      path = fetchurl {
        name = "babel-helper-is-nodes-equiv-0.0.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-is-nodes-equiv/-/babel-helper-is-nodes-equiv-0.0.1.tgz";
        sha1 = "34e9b300b1479ddd98ec77ea0bbe9342dfe39684";
      };
    }

    {
      name = "babel-helper-is-void-0-0.0.1.tgz";
      path = fetchurl {
        name = "babel-helper-is-void-0-0.0.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-is-void-0/-/babel-helper-is-void-0-0.0.1.tgz";
        sha1 = "ed74553b883e68226ae45f989a99b02c190f105a";
      };
    }

    {
      name = "babel-helper-is-void-0-0.3.0.tgz";
      path = fetchurl {
        name = "babel-helper-is-void-0-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-is-void-0/-/babel-helper-is-void-0-0.3.0.tgz";
        sha1 = "95570d20bd27b2206f68083ae9980ee7003d8fe7";
      };
    }

    {
      name = "babel-helper-mark-eval-scopes-0.0.3.tgz";
      path = fetchurl {
        name = "babel-helper-mark-eval-scopes-0.0.3.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-mark-eval-scopes/-/babel-helper-mark-eval-scopes-0.0.3.tgz";
        sha1 = "902f75aeb537336edc35eb9f52b6f09db7785328";
      };
    }

    {
      name = "babel-helper-mark-eval-scopes-0.1.1.tgz";
      path = fetchurl {
        name = "babel-helper-mark-eval-scopes-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-mark-eval-scopes/-/babel-helper-mark-eval-scopes-0.1.1.tgz";
        sha1 = "4554345edf9f2549427bd2098e530253f8af2992";
      };
    }

    {
      name = "babel-helper-mark-eval-scopes-0.3.0.tgz";
      path = fetchurl {
        name = "babel-helper-mark-eval-scopes-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-mark-eval-scopes/-/babel-helper-mark-eval-scopes-0.3.0.tgz";
        sha1 = "b4731314fdd7a89091271a5213b4e12d236e29e8";
      };
    }

    {
      name = "babel-helper-optimise-call-expression-6.24.1.tgz";
      path = fetchurl {
        name = "babel-helper-optimise-call-expression-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-optimise-call-expression/-/babel-helper-optimise-call-expression-6.24.1.tgz";
        sha1 = "f7a13427ba9f73f8f4fa993c54a97882d1244257";
      };
    }

    {
      name = "babel-helper-regex-6.26.0.tgz";
      path = fetchurl {
        name = "babel-helper-regex-6.26.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-regex/-/babel-helper-regex-6.26.0.tgz";
        sha1 = "325c59f902f82f24b74faceed0363954f6495e72";
      };
    }

    {
      name = "babel-helper-remap-async-to-generator-6.24.1.tgz";
      path = fetchurl {
        name = "babel-helper-remap-async-to-generator-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-remap-async-to-generator/-/babel-helper-remap-async-to-generator-6.24.1.tgz";
        sha1 = "5ec581827ad723fecdd381f1c928390676e4551b";
      };
    }

    {
      name = "babel-helper-remove-or-void-0.1.1.tgz";
      path = fetchurl {
        name = "babel-helper-remove-or-void-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-remove-or-void/-/babel-helper-remove-or-void-0.1.1.tgz";
        sha1 = "9d7e1856dc6fafcb41b283a416730dc1844f66d7";
      };
    }

    {
      name = "babel-helper-remove-or-void-0.3.0.tgz";
      path = fetchurl {
        name = "babel-helper-remove-or-void-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-remove-or-void/-/babel-helper-remove-or-void-0.3.0.tgz";
        sha1 = "f43c86147c8fcc395a9528cbb31e7ff49d7e16e3";
      };
    }

    {
      name = "babel-helper-replace-supers-6.24.1.tgz";
      path = fetchurl {
        name = "babel-helper-replace-supers-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-replace-supers/-/babel-helper-replace-supers-6.24.1.tgz";
        sha1 = "bf6dbfe43938d17369a213ca8a8bf74b6a90ab1a";
      };
    }

    {
      name = "babel-helper-to-multiple-sequence-expressions-0.0.4.tgz";
      path = fetchurl {
        name = "babel-helper-to-multiple-sequence-expressions-0.0.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-to-multiple-sequence-expressions/-/babel-helper-to-multiple-sequence-expressions-0.0.4.tgz";
        sha1 = "d94414b386b6286fbaad77f073dea9b34324b01c";
      };
    }

    {
      name = "babel-helper-to-multiple-sequence-expressions-0.3.0.tgz";
      path = fetchurl {
        name = "babel-helper-to-multiple-sequence-expressions-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-helper-to-multiple-sequence-expressions/-/babel-helper-to-multiple-sequence-expressions-0.3.0.tgz";
        sha1 = "8da2275ccc26995566118f7213abfd9af7214427";
      };
    }

    {
      name = "babel-helpers-6.24.1.tgz";
      path = fetchurl {
        name = "babel-helpers-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-helpers/-/babel-helpers-6.24.1.tgz";
        sha1 = "3471de9caec388e5c850e597e58a26ddf37602b2";
      };
    }

    {
      name = "babel-jest-18.0.0.tgz";
      path = fetchurl {
        name = "babel-jest-18.0.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-jest/-/babel-jest-18.0.0.tgz";
        sha1 = "17ebba8cb3285c906d859e8707e4e79795fb65e3";
      };
    }

    {
      name = "babel-jest-20.0.3.tgz";
      path = fetchurl {
        name = "babel-jest-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/babel-jest/-/babel-jest-20.0.3.tgz";
        sha1 = "e4a03b13dc10389e140fc645d09ffc4ced301671";
      };
    }

    {
      name = "babel-jest-21.2.0.tgz";
      path = fetchurl {
        name = "babel-jest-21.2.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-jest/-/babel-jest-21.2.0.tgz";
        sha1 = "2ce059519a9374a2c46f2455b6fbef5ad75d863e";
      };
    }

    {
      name = "babel-jest-22.4.4.tgz";
      path = fetchurl {
        name = "babel-jest-22.4.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-jest/-/babel-jest-22.4.4.tgz";
        sha1 = "977259240420e227444ebe49e226a61e49ea659d";
      };
    }

    {
      name = "babel-loader-7.1.5.tgz";
      path = fetchurl {
        name = "babel-loader-7.1.5.tgz";
        url  = "https://registry.yarnpkg.com/babel-loader/-/babel-loader-7.1.5.tgz";
        sha1 = "e3ee0cd7394aa557e013b02d3e492bfd07aa6d68";
      };
    }

    {
      name = "babel-messages-6.23.0.tgz";
      path = fetchurl {
        name = "babel-messages-6.23.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-messages/-/babel-messages-6.23.0.tgz";
        sha1 = "f3cdf4703858035b2a2951c6ec5edf6c62f2630e";
      };
    }

    {
      name = "babel-plugin-check-es2015-constants-6.22.0.tgz";
      path = fetchurl {
        name = "babel-plugin-check-es2015-constants-6.22.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-check-es2015-constants/-/babel-plugin-check-es2015-constants-6.22.0.tgz";
        sha1 = "35157b101426fd2ffd3da3f75c7d1e91835bbf8a";
      };
    }

    {
      name = "babel-plugin-istanbul-3.1.2.tgz";
      path = fetchurl {
        name = "babel-plugin-istanbul-3.1.2.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-istanbul/-/babel-plugin-istanbul-3.1.2.tgz";
        sha1 = "11d5abde18425ec24b5d648c7e0b5d25cd354a22";
      };
    }

    {
      name = "babel-plugin-istanbul-4.1.6.tgz";
      path = fetchurl {
        name = "babel-plugin-istanbul-4.1.6.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-istanbul/-/babel-plugin-istanbul-4.1.6.tgz";
        sha1 = "36c59b2192efce81c5b378321b74175add1c9a45";
      };
    }

    {
      name = "babel-plugin-jest-hoist-18.0.0.tgz";
      path = fetchurl {
        name = "babel-plugin-jest-hoist-18.0.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-jest-hoist/-/babel-plugin-jest-hoist-18.0.0.tgz";
        sha1 = "4150e70ecab560e6e7344adc849498072d34e12a";
      };
    }

    {
      name = "babel-plugin-jest-hoist-20.0.3.tgz";
      path = fetchurl {
        name = "babel-plugin-jest-hoist-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-jest-hoist/-/babel-plugin-jest-hoist-20.0.3.tgz";
        sha1 = "afedc853bd3f8dc3548ea671fbe69d03cc2c1767";
      };
    }

    {
      name = "babel-plugin-jest-hoist-21.2.0.tgz";
      path = fetchurl {
        name = "babel-plugin-jest-hoist-21.2.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-jest-hoist/-/babel-plugin-jest-hoist-21.2.0.tgz";
        sha1 = "2cef637259bd4b628a6cace039de5fcd14dbb006";
      };
    }

    {
      name = "babel-plugin-jest-hoist-22.4.4.tgz";
      path = fetchurl {
        name = "babel-plugin-jest-hoist-22.4.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-jest-hoist/-/babel-plugin-jest-hoist-22.4.4.tgz";
        sha1 = "b9851906eab34c7bf6f8c895a2b08bea1a844c0b";
      };
    }

    {
      name = "babel-plugin-minify-builtins-0.0.2.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-builtins-0.0.2.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-builtins/-/babel-plugin-minify-builtins-0.0.2.tgz";
        sha1 = "f3be6121763c0c518d5ef82067cef4b615c9498c";
      };
    }

    {
      name = "babel-plugin-minify-builtins-0.3.0.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-builtins-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-builtins/-/babel-plugin-minify-builtins-0.3.0.tgz";
        sha1 = "4740117a6a784063aaf8f092989cf9e4bd484860";
      };
    }

    {
      name = "babel-plugin-minify-constant-folding-0.0.4.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-constant-folding-0.0.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-constant-folding/-/babel-plugin-minify-constant-folding-0.0.4.tgz";
        sha1 = "b6e231026a6035e88ceadd206128d7db2b5c15e6";
      };
    }

    {
      name = "babel-plugin-minify-constant-folding-0.3.0.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-constant-folding-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-constant-folding/-/babel-plugin-minify-constant-folding-0.3.0.tgz";
        sha1 = "687e40336bd4ddd921e0e197f0006235ac184bb9";
      };
    }

    {
      name = "babel-plugin-minify-dead-code-elimination-0.1.7.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-dead-code-elimination-0.1.7.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-dead-code-elimination/-/babel-plugin-minify-dead-code-elimination-0.1.7.tgz";
        sha1 = "774f536f347b98393a27baa717872968813c342c";
      };
    }

    {
      name = "babel-plugin-minify-dead-code-elimination-0.3.0.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-dead-code-elimination-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-dead-code-elimination/-/babel-plugin-minify-dead-code-elimination-0.3.0.tgz";
        sha1 = "a323f686c404b824186ba5583cf7996cac81719e";
      };
    }

    {
      name = "babel-plugin-minify-flip-comparisons-0.0.2.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-flip-comparisons-0.0.2.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-flip-comparisons/-/babel-plugin-minify-flip-comparisons-0.0.2.tgz";
        sha1 = "7d0953aa5876ede6118966bda9edecc63bf346ab";
      };
    }

    {
      name = "babel-plugin-minify-flip-comparisons-0.3.0.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-flip-comparisons-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-flip-comparisons/-/babel-plugin-minify-flip-comparisons-0.3.0.tgz";
        sha1 = "6627893a409c9f30ef7f2c89e0c6eea7ee97ddc4";
      };
    }

    {
      name = "babel-plugin-minify-guarded-expressions-0.0.4.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-guarded-expressions-0.0.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-guarded-expressions/-/babel-plugin-minify-guarded-expressions-0.0.4.tgz";
        sha1 = "957104a760e6a7ffd967005a7a11621bb42fd11c";
      };
    }

    {
      name = "babel-plugin-minify-guarded-expressions-0.3.0.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-guarded-expressions-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-guarded-expressions/-/babel-plugin-minify-guarded-expressions-0.3.0.tgz";
        sha1 = "2552d96189ef45d9a463f1a6b5e4fa110703ac8d";
      };
    }

    {
      name = "babel-plugin-minify-infinity-0.0.3.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-infinity-0.0.3.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-infinity/-/babel-plugin-minify-infinity-0.0.3.tgz";
        sha1 = "4cc99b61d12b434ce80ad675103335c589cba9a1";
      };
    }

    {
      name = "babel-plugin-minify-infinity-0.3.0.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-infinity-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-infinity/-/babel-plugin-minify-infinity-0.3.0.tgz";
        sha1 = "c5ec0edd433517cf31b3af17077c202beb48bbe7";
      };
    }

    {
      name = "babel-plugin-minify-mangle-names-0.0.8.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-mangle-names-0.0.8.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-mangle-names/-/babel-plugin-minify-mangle-names-0.0.8.tgz";
        sha1 = "1e2fea856dd742d5697aa26b427e41258a8c5b79";
      };
    }

    {
      name = "babel-plugin-minify-mangle-names-0.3.0.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-mangle-names-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-mangle-names/-/babel-plugin-minify-mangle-names-0.3.0.tgz";
        sha1 = "f28561bad0dd2f0380816816bb946e219b3b6135";
      };
    }

    {
      name = "babel-plugin-minify-numeric-literals-0.0.1.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-numeric-literals-0.0.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-numeric-literals/-/babel-plugin-minify-numeric-literals-0.0.1.tgz";
        sha1 = "9597e6c31154d7daf3744d0bd417c144b275bd53";
      };
    }

    {
      name = "babel-plugin-minify-numeric-literals-0.3.0.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-numeric-literals-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-numeric-literals/-/babel-plugin-minify-numeric-literals-0.3.0.tgz";
        sha1 = "b57734a612e8a592005407323c321119f27d4b40";
      };
    }

    {
      name = "babel-plugin-minify-replace-0.0.1.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-replace-0.0.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-replace/-/babel-plugin-minify-replace-0.0.1.tgz";
        sha1 = "5d5aea7cb9899245248d1ee9ce7a2fe556a8facc";
      };
    }

    {
      name = "babel-plugin-minify-replace-0.3.0.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-replace-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-replace/-/babel-plugin-minify-replace-0.3.0.tgz";
        sha1 = "980125bbf7cbb5a637439de9d0b1b030a4693893";
      };
    }

    {
      name = "babel-plugin-minify-simplify-0.0.8.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-simplify-0.0.8.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-simplify/-/babel-plugin-minify-simplify-0.0.8.tgz";
        sha1 = "597b23327bba4373fed1c51461a689bce9ff4979";
      };
    }

    {
      name = "babel-plugin-minify-simplify-0.3.0.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-simplify-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-simplify/-/babel-plugin-minify-simplify-0.3.0.tgz";
        sha1 = "14574cc74d21c81d3060fafa041010028189f11b";
      };
    }

    {
      name = "babel-plugin-minify-type-constructors-0.0.4.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-type-constructors-0.0.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-type-constructors/-/babel-plugin-minify-type-constructors-0.0.4.tgz";
        sha1 = "52d8b623775107523227719ade2d0b7458758b5f";
      };
    }

    {
      name = "babel-plugin-minify-type-constructors-0.3.0.tgz";
      path = fetchurl {
        name = "babel-plugin-minify-type-constructors-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-minify-type-constructors/-/babel-plugin-minify-type-constructors-0.3.0.tgz";
        sha1 = "7f5a86ef322c4746364e3c591b8514eeafea6ad4";
      };
    }

    {
      name = "babel-plugin-syntax-async-functions-6.13.0.tgz";
      path = fetchurl {
        name = "babel-plugin-syntax-async-functions-6.13.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-syntax-async-functions/-/babel-plugin-syntax-async-functions-6.13.0.tgz";
        sha1 = "cad9cad1191b5ad634bf30ae0872391e0647be95";
      };
    }

    {
      name = "babel-plugin-syntax-async-generators-6.13.0.tgz";
      path = fetchurl {
        name = "babel-plugin-syntax-async-generators-6.13.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-syntax-async-generators/-/babel-plugin-syntax-async-generators-6.13.0.tgz";
        sha1 = "6bc963ebb16eccbae6b92b596eb7f35c342a8b9a";
      };
    }

    {
      name = "babel-plugin-syntax-class-constructor-call-6.18.0.tgz";
      path = fetchurl {
        name = "babel-plugin-syntax-class-constructor-call-6.18.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-syntax-class-constructor-call/-/babel-plugin-syntax-class-constructor-call-6.18.0.tgz";
        sha1 = "9cb9d39fe43c8600bec8146456ddcbd4e1a76416";
      };
    }

    {
      name = "babel-plugin-syntax-class-properties-6.13.0.tgz";
      path = fetchurl {
        name = "babel-plugin-syntax-class-properties-6.13.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-syntax-class-properties/-/babel-plugin-syntax-class-properties-6.13.0.tgz";
        sha1 = "d7eb23b79a317f8543962c505b827c7d6cac27de";
      };
    }

    {
      name = "babel-plugin-syntax-decorators-6.13.0.tgz";
      path = fetchurl {
        name = "babel-plugin-syntax-decorators-6.13.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-syntax-decorators/-/babel-plugin-syntax-decorators-6.13.0.tgz";
        sha1 = "312563b4dbde3cc806cee3e416cceeaddd11ac0b";
      };
    }

    {
      name = "babel-plugin-syntax-do-expressions-6.13.0.tgz";
      path = fetchurl {
        name = "babel-plugin-syntax-do-expressions-6.13.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-syntax-do-expressions/-/babel-plugin-syntax-do-expressions-6.13.0.tgz";
        sha1 = "5747756139aa26d390d09410b03744ba07e4796d";
      };
    }

    {
      name = "babel-plugin-syntax-dynamic-import-6.18.0.tgz";
      path = fetchurl {
        name = "babel-plugin-syntax-dynamic-import-6.18.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-syntax-dynamic-import/-/babel-plugin-syntax-dynamic-import-6.18.0.tgz";
        sha1 = "8d6a26229c83745a9982a441051572caa179b1da";
      };
    }

    {
      name = "babel-plugin-syntax-exponentiation-operator-6.13.0.tgz";
      path = fetchurl {
        name = "babel-plugin-syntax-exponentiation-operator-6.13.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-syntax-exponentiation-operator/-/babel-plugin-syntax-exponentiation-operator-6.13.0.tgz";
        sha1 = "9ee7e8337290da95288201a6a57f4170317830de";
      };
    }

    {
      name = "babel-plugin-syntax-export-extensions-6.13.0.tgz";
      path = fetchurl {
        name = "babel-plugin-syntax-export-extensions-6.13.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-syntax-export-extensions/-/babel-plugin-syntax-export-extensions-6.13.0.tgz";
        sha1 = "70a1484f0f9089a4e84ad44bac353c95b9b12721";
      };
    }

    {
      name = "babel-plugin-syntax-flow-6.18.0.tgz";
      path = fetchurl {
        name = "babel-plugin-syntax-flow-6.18.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-syntax-flow/-/babel-plugin-syntax-flow-6.18.0.tgz";
        sha1 = "4c3ab20a2af26aa20cd25995c398c4eb70310c8d";
      };
    }

    {
      name = "babel-plugin-syntax-function-bind-6.13.0.tgz";
      path = fetchurl {
        name = "babel-plugin-syntax-function-bind-6.13.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-syntax-function-bind/-/babel-plugin-syntax-function-bind-6.13.0.tgz";
        sha1 = "48c495f177bdf31a981e732f55adc0bdd2601f46";
      };
    }

    {
      name = "babel-plugin-syntax-jsx-6.18.0.tgz";
      path = fetchurl {
        name = "babel-plugin-syntax-jsx-6.18.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-syntax-jsx/-/babel-plugin-syntax-jsx-6.18.0.tgz";
        sha1 = "0af32a9a6e13ca7a3fd5069e62d7b0f58d0d8946";
      };
    }

    {
      name = "babel-plugin-syntax-object-rest-spread-6.13.0.tgz";
      path = fetchurl {
        name = "babel-plugin-syntax-object-rest-spread-6.13.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-syntax-object-rest-spread/-/babel-plugin-syntax-object-rest-spread-6.13.0.tgz";
        sha1 = "fd6536f2bce13836ffa3a5458c4903a597bb3bf5";
      };
    }

    {
      name = "babel-plugin-syntax-trailing-function-commas-6.22.0.tgz";
      path = fetchurl {
        name = "babel-plugin-syntax-trailing-function-commas-6.22.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-syntax-trailing-function-commas/-/babel-plugin-syntax-trailing-function-commas-6.22.0.tgz";
        sha1 = "ba0360937f8d06e40180a43fe0d5616fff532cf3";
      };
    }

    {
      name = "babel-plugin-transform-async-generator-functions-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-async-generator-functions-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-async-generator-functions/-/babel-plugin-transform-async-generator-functions-6.24.1.tgz";
        sha1 = "f058900145fd3e9907a6ddf28da59f215258a5db";
      };
    }

    {
      name = "babel-plugin-transform-async-to-generator-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-async-to-generator-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-async-to-generator/-/babel-plugin-transform-async-to-generator-6.24.1.tgz";
        sha1 = "6536e378aff6cb1d5517ac0e40eb3e9fc8d08761";
      };
    }

    {
      name = "babel-plugin-transform-class-constructor-call-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-class-constructor-call-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-class-constructor-call/-/babel-plugin-transform-class-constructor-call-6.24.1.tgz";
        sha1 = "80dc285505ac067dcb8d6c65e2f6f11ab7765ef9";
      };
    }

    {
      name = "babel-plugin-transform-class-properties-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-class-properties-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-class-properties/-/babel-plugin-transform-class-properties-6.24.1.tgz";
        sha1 = "6a79763ea61d33d36f37b611aa9def81a81b46ac";
      };
    }

    {
      name = "babel-plugin-transform-decorators-legacy-1.3.5.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-decorators-legacy-1.3.5.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-decorators-legacy/-/babel-plugin-transform-decorators-legacy-1.3.5.tgz";
        sha1 = "0e492dffa0edd70529072887f8aa86d4dd8b40a1";
      };
    }

    {
      name = "babel-plugin-transform-decorators-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-decorators-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-decorators/-/babel-plugin-transform-decorators-6.24.1.tgz";
        sha1 = "788013d8f8c6b5222bdf7b344390dfd77569e24d";
      };
    }

    {
      name = "babel-plugin-transform-do-expressions-6.22.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-do-expressions-6.22.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-do-expressions/-/babel-plugin-transform-do-expressions-6.22.0.tgz";
        sha1 = "28ccaf92812d949c2cd1281f690c8fdc468ae9bb";
      };
    }

    {
      name = "babel-plugin-transform-es2015-arrow-functions-6.22.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-arrow-functions-6.22.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-arrow-functions/-/babel-plugin-transform-es2015-arrow-functions-6.22.0.tgz";
        sha1 = "452692cb711d5f79dc7f85e440ce41b9f244d221";
      };
    }

    {
      name = "babel-plugin-transform-es2015-block-scoped-functions-6.22.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-block-scoped-functions-6.22.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-block-scoped-functions/-/babel-plugin-transform-es2015-block-scoped-functions-6.22.0.tgz";
        sha1 = "bbc51b49f964d70cb8d8e0b94e820246ce3a6141";
      };
    }

    {
      name = "babel-plugin-transform-es2015-block-scoping-6.26.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-block-scoping-6.26.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-block-scoping/-/babel-plugin-transform-es2015-block-scoping-6.26.0.tgz";
        sha1 = "d70f5299c1308d05c12f463813b0a09e73b1895f";
      };
    }

    {
      name = "babel-plugin-transform-es2015-classes-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-classes-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-classes/-/babel-plugin-transform-es2015-classes-6.24.1.tgz";
        sha1 = "5a4c58a50c9c9461e564b4b2a3bfabc97a2584db";
      };
    }

    {
      name = "babel-plugin-transform-es2015-computed-properties-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-computed-properties-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-computed-properties/-/babel-plugin-transform-es2015-computed-properties-6.24.1.tgz";
        sha1 = "6fe2a8d16895d5634f4cd999b6d3480a308159b3";
      };
    }

    {
      name = "babel-plugin-transform-es2015-destructuring-6.23.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-destructuring-6.23.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-destructuring/-/babel-plugin-transform-es2015-destructuring-6.23.0.tgz";
        sha1 = "997bb1f1ab967f682d2b0876fe358d60e765c56d";
      };
    }

    {
      name = "babel-plugin-transform-es2015-duplicate-keys-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-duplicate-keys-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-duplicate-keys/-/babel-plugin-transform-es2015-duplicate-keys-6.24.1.tgz";
        sha1 = "73eb3d310ca969e3ef9ec91c53741a6f1576423e";
      };
    }

    {
      name = "babel-plugin-transform-es2015-for-of-6.23.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-for-of-6.23.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-for-of/-/babel-plugin-transform-es2015-for-of-6.23.0.tgz";
        sha1 = "f47c95b2b613df1d3ecc2fdb7573623c75248691";
      };
    }

    {
      name = "babel-plugin-transform-es2015-function-name-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-function-name-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-function-name/-/babel-plugin-transform-es2015-function-name-6.24.1.tgz";
        sha1 = "834c89853bc36b1af0f3a4c5dbaa94fd8eacaa8b";
      };
    }

    {
      name = "babel-plugin-transform-es2015-literals-6.22.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-literals-6.22.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-literals/-/babel-plugin-transform-es2015-literals-6.22.0.tgz";
        sha1 = "4f54a02d6cd66cf915280019a31d31925377ca2e";
      };
    }

    {
      name = "babel-plugin-transform-es2015-modules-amd-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-modules-amd-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-modules-amd/-/babel-plugin-transform-es2015-modules-amd-6.24.1.tgz";
        sha1 = "3b3e54017239842d6d19c3011c4bd2f00a00d154";
      };
    }

    {
      name = "babel-plugin-transform-es2015-modules-commonjs-6.26.2.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-modules-commonjs-6.26.2.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-modules-commonjs/-/babel-plugin-transform-es2015-modules-commonjs-6.26.2.tgz";
        sha1 = "58a793863a9e7ca870bdc5a881117ffac27db6f3";
      };
    }

    {
      name = "babel-plugin-transform-es2015-modules-systemjs-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-modules-systemjs-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-modules-systemjs/-/babel-plugin-transform-es2015-modules-systemjs-6.24.1.tgz";
        sha1 = "ff89a142b9119a906195f5f106ecf305d9407d23";
      };
    }

    {
      name = "babel-plugin-transform-es2015-modules-umd-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-modules-umd-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-modules-umd/-/babel-plugin-transform-es2015-modules-umd-6.24.1.tgz";
        sha1 = "ac997e6285cd18ed6176adb607d602344ad38468";
      };
    }

    {
      name = "babel-plugin-transform-es2015-object-super-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-object-super-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-object-super/-/babel-plugin-transform-es2015-object-super-6.24.1.tgz";
        sha1 = "24cef69ae21cb83a7f8603dad021f572eb278f8d";
      };
    }

    {
      name = "babel-plugin-transform-es2015-parameters-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-parameters-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-parameters/-/babel-plugin-transform-es2015-parameters-6.24.1.tgz";
        sha1 = "57ac351ab49caf14a97cd13b09f66fdf0a625f2b";
      };
    }

    {
      name = "babel-plugin-transform-es2015-shorthand-properties-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-shorthand-properties-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-shorthand-properties/-/babel-plugin-transform-es2015-shorthand-properties-6.24.1.tgz";
        sha1 = "24f875d6721c87661bbd99a4622e51f14de38aa0";
      };
    }

    {
      name = "babel-plugin-transform-es2015-spread-6.22.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-spread-6.22.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-spread/-/babel-plugin-transform-es2015-spread-6.22.0.tgz";
        sha1 = "d6d68a99f89aedc4536c81a542e8dd9f1746f8d1";
      };
    }

    {
      name = "babel-plugin-transform-es2015-sticky-regex-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-sticky-regex-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-sticky-regex/-/babel-plugin-transform-es2015-sticky-regex-6.24.1.tgz";
        sha1 = "00c1cdb1aca71112cdf0cf6126c2ed6b457ccdbc";
      };
    }

    {
      name = "babel-plugin-transform-es2015-template-literals-6.22.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-template-literals-6.22.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-template-literals/-/babel-plugin-transform-es2015-template-literals-6.22.0.tgz";
        sha1 = "a84b3450f7e9f8f1f6839d6d687da84bb1236d8d";
      };
    }

    {
      name = "babel-plugin-transform-es2015-typeof-symbol-6.23.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-typeof-symbol-6.23.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-typeof-symbol/-/babel-plugin-transform-es2015-typeof-symbol-6.23.0.tgz";
        sha1 = "dec09f1cddff94b52ac73d505c84df59dcceb372";
      };
    }

    {
      name = "babel-plugin-transform-es2015-unicode-regex-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-es2015-unicode-regex-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-es2015-unicode-regex/-/babel-plugin-transform-es2015-unicode-regex-6.24.1.tgz";
        sha1 = "d38b12f42ea7323f729387f18a7c5ae1faeb35e9";
      };
    }

    {
      name = "babel-plugin-transform-exponentiation-operator-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-exponentiation-operator-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-exponentiation-operator/-/babel-plugin-transform-exponentiation-operator-6.24.1.tgz";
        sha1 = "2ab0c9c7f3098fa48907772bb813fe41e8de3a0e";
      };
    }

    {
      name = "babel-plugin-transform-export-extensions-6.22.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-export-extensions-6.22.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-export-extensions/-/babel-plugin-transform-export-extensions-6.22.0.tgz";
        sha1 = "53738b47e75e8218589eea946cbbd39109bbe653";
      };
    }

    {
      name = "babel-plugin-transform-flow-strip-types-6.22.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-flow-strip-types-6.22.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-flow-strip-types/-/babel-plugin-transform-flow-strip-types-6.22.0.tgz";
        sha1 = "84cb672935d43714fdc32bce84568d87441cf7cf";
      };
    }

    {
      name = "babel-plugin-transform-function-bind-6.22.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-function-bind-6.22.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-function-bind/-/babel-plugin-transform-function-bind-6.22.0.tgz";
        sha1 = "c6fb8e96ac296a310b8cf8ea401462407ddf6a97";
      };
    }

    {
      name = "babel-plugin-transform-inline-consecutive-adds-0.0.2.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-inline-consecutive-adds-0.0.2.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-inline-consecutive-adds/-/babel-plugin-transform-inline-consecutive-adds-0.0.2.tgz";
        sha1 = "a58fcecfc09c08fbf9373a5a3e70746c03d01fc1";
      };
    }

    {
      name = "babel-plugin-transform-inline-consecutive-adds-0.3.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-inline-consecutive-adds-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-inline-consecutive-adds/-/babel-plugin-transform-inline-consecutive-adds-0.3.0.tgz";
        sha1 = "f07d93689c0002ed2b2b62969bdd99f734e03f57";
      };
    }

    {
      name = "babel-plugin-transform-member-expression-literals-6.9.4.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-member-expression-literals-6.9.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-member-expression-literals/-/babel-plugin-transform-member-expression-literals-6.9.4.tgz";
        sha1 = "37039c9a0c3313a39495faac2ff3a6b5b9d038bf";
      };
    }

    {
      name = "babel-plugin-transform-merge-sibling-variables-6.9.4.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-merge-sibling-variables-6.9.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-merge-sibling-variables/-/babel-plugin-transform-merge-sibling-variables-6.9.4.tgz";
        sha1 = "85b422fc3377b449c9d1cde44087203532401dae";
      };
    }

    {
      name = "babel-plugin-transform-minify-booleans-6.9.4.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-minify-booleans-6.9.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-minify-booleans/-/babel-plugin-transform-minify-booleans-6.9.4.tgz";
        sha1 = "acbb3e56a3555dd23928e4b582d285162dd2b198";
      };
    }

    {
      name = "babel-plugin-transform-object-rest-spread-6.26.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-object-rest-spread-6.26.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-object-rest-spread/-/babel-plugin-transform-object-rest-spread-6.26.0.tgz";
        sha1 = "0f36692d50fef6b7e2d4b3ac1478137a963b7b06";
      };
    }

    {
      name = "babel-plugin-transform-property-literals-6.9.4.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-property-literals-6.9.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-property-literals/-/babel-plugin-transform-property-literals-6.9.4.tgz";
        sha1 = "98c1d21e255736573f93ece54459f6ce24985d39";
      };
    }

    {
      name = "babel-plugin-transform-react-display-name-6.25.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-react-display-name-6.25.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-react-display-name/-/babel-plugin-transform-react-display-name-6.25.0.tgz";
        sha1 = "67e2bf1f1e9c93ab08db96792e05392bf2cc28d1";
      };
    }

    {
      name = "babel-plugin-transform-react-jsx-self-6.22.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-react-jsx-self-6.22.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-react-jsx-self/-/babel-plugin-transform-react-jsx-self-6.22.0.tgz";
        sha1 = "df6d80a9da2612a121e6ddd7558bcbecf06e636e";
      };
    }

    {
      name = "babel-plugin-transform-react-jsx-source-6.22.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-react-jsx-source-6.22.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-react-jsx-source/-/babel-plugin-transform-react-jsx-source-6.22.0.tgz";
        sha1 = "66ac12153f5cd2d17b3c19268f4bf0197f44ecd6";
      };
    }

    {
      name = "babel-plugin-transform-react-jsx-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-react-jsx-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-react-jsx/-/babel-plugin-transform-react-jsx-6.24.1.tgz";
        sha1 = "840a028e7df460dfc3a2d29f0c0d91f6376e66a3";
      };
    }

    {
      name = "babel-plugin-transform-regenerator-6.26.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-regenerator-6.26.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-regenerator/-/babel-plugin-transform-regenerator-6.26.0.tgz";
        sha1 = "e0703696fbde27f0a3efcacf8b4dca2f7b3a8f2f";
      };
    }

    {
      name = "babel-plugin-transform-regexp-constructors-0.0.6.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-regexp-constructors-0.0.6.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-regexp-constructors/-/babel-plugin-transform-regexp-constructors-0.0.6.tgz";
        sha1 = "0d92607f0d26268296980cb7c1dea5f2dd3e1e20";
      };
    }

    {
      name = "babel-plugin-transform-regexp-constructors-0.3.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-regexp-constructors-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-regexp-constructors/-/babel-plugin-transform-regexp-constructors-0.3.0.tgz";
        sha1 = "9bb2c8dd082271a5cb1b3a441a7c52e8fd07e0f5";
      };
    }

    {
      name = "babel-plugin-transform-remove-console-6.9.4.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-remove-console-6.9.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-remove-console/-/babel-plugin-transform-remove-console-6.9.4.tgz";
        sha1 = "b980360c067384e24b357a588d807d3c83527780";
      };
    }

    {
      name = "babel-plugin-transform-remove-debugger-6.9.4.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-remove-debugger-6.9.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-remove-debugger/-/babel-plugin-transform-remove-debugger-6.9.4.tgz";
        sha1 = "42b727631c97978e1eb2d199a7aec84a18339ef2";
      };
    }

    {
      name = "babel-plugin-transform-remove-undefined-0.0.5.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-remove-undefined-0.0.5.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-remove-undefined/-/babel-plugin-transform-remove-undefined-0.0.5.tgz";
        sha1 = "12ef11805e06e861dd2eb0c7cc041d2184b8f410";
      };
    }

    {
      name = "babel-plugin-transform-remove-undefined-0.3.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-remove-undefined-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-remove-undefined/-/babel-plugin-transform-remove-undefined-0.3.0.tgz";
        sha1 = "03f5f0071867781e9beabbc7b77bf8095fd3f3ec";
      };
    }

    {
      name = "babel-plugin-transform-runtime-6.23.0.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-runtime-6.23.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-runtime/-/babel-plugin-transform-runtime-6.23.0.tgz";
        sha1 = "88490d446502ea9b8e7efb0fe09ec4d99479b1ee";
      };
    }

    {
      name = "babel-plugin-transform-simplify-comparison-operators-6.9.4.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-simplify-comparison-operators-6.9.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-simplify-comparison-operators/-/babel-plugin-transform-simplify-comparison-operators-6.9.4.tgz";
        sha1 = "f62afe096cab0e1f68a2d753fdf283888471ceb9";
      };
    }

    {
      name = "babel-plugin-transform-strict-mode-6.24.1.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-strict-mode-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-strict-mode/-/babel-plugin-transform-strict-mode-6.24.1.tgz";
        sha1 = "d5faf7aa578a65bbe591cf5edae04a0c67020758";
      };
    }

    {
      name = "babel-plugin-transform-undefined-to-void-6.9.4.tgz";
      path = fetchurl {
        name = "babel-plugin-transform-undefined-to-void-6.9.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-plugin-transform-undefined-to-void/-/babel-plugin-transform-undefined-to-void-6.9.4.tgz";
        sha1 = "be241ca81404030678b748717322b89d0c8fe280";
      };
    }

    {
      name = "babel-preset-babili-0.0.12.tgz";
      path = fetchurl {
        name = "babel-preset-babili-0.0.12.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-babili/-/babel-preset-babili-0.0.12.tgz";
        sha1 = "74d79205d54feae6470bc84231da0b9ac9fc7de9";
      };
    }

    {
      name = "babel-preset-env-1.7.0.tgz";
      path = fetchurl {
        name = "babel-preset-env-1.7.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-env/-/babel-preset-env-1.7.0.tgz";
        sha1 = "dea79fa4ebeb883cd35dab07e260c1c9c04df77a";
      };
    }

    {
      name = "babel-preset-es2015-native-modules-6.9.4.tgz";
      path = fetchurl {
        name = "babel-preset-es2015-native-modules-6.9.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-es2015-native-modules/-/babel-preset-es2015-native-modules-6.9.4.tgz";
        sha1 = "ad2e0ff3a2cd879c1d8fc994ab33b4b80d2b5057";
      };
    }

    {
      name = "babel-preset-es2015-6.24.1.tgz";
      path = fetchurl {
        name = "babel-preset-es2015-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-es2015/-/babel-preset-es2015-6.24.1.tgz";
        sha1 = "d44050d6bc2c9feea702aaf38d727a0210538939";
      };
    }

    {
      name = "babel-preset-flow-6.23.0.tgz";
      path = fetchurl {
        name = "babel-preset-flow-6.23.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-flow/-/babel-preset-flow-6.23.0.tgz";
        sha1 = "e71218887085ae9a24b5be4169affb599816c49d";
      };
    }

    {
      name = "babel-preset-jest-18.0.0.tgz";
      path = fetchurl {
        name = "babel-preset-jest-18.0.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-jest/-/babel-preset-jest-18.0.0.tgz";
        sha1 = "84faf8ca3ec65aba7d5e3f59bbaed935ab24049e";
      };
    }

    {
      name = "babel-preset-jest-20.0.3.tgz";
      path = fetchurl {
        name = "babel-preset-jest-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-jest/-/babel-preset-jest-20.0.3.tgz";
        sha1 = "cbacaadecb5d689ca1e1de1360ebfc66862c178a";
      };
    }

    {
      name = "babel-preset-jest-21.2.0.tgz";
      path = fetchurl {
        name = "babel-preset-jest-21.2.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-jest/-/babel-preset-jest-21.2.0.tgz";
        sha1 = "ff9d2bce08abd98e8a36d9a8a5189b9173b85638";
      };
    }

    {
      name = "babel-preset-jest-22.4.4.tgz";
      path = fetchurl {
        name = "babel-preset-jest-22.4.4.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-jest/-/babel-preset-jest-22.4.4.tgz";
        sha1 = "ec9fbd8bcd7dfd24b8b5320e0e688013235b7c39";
      };
    }

    {
      name = "babel-preset-minify-0.3.0.tgz";
      path = fetchurl {
        name = "babel-preset-minify-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-minify/-/babel-preset-minify-0.3.0.tgz";
        sha1 = "7db64afa75f16f6e06c0aa5f25195f6f36784d77";
      };
    }

    {
      name = "babel-preset-react-6.24.1.tgz";
      path = fetchurl {
        name = "babel-preset-react-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-react/-/babel-preset-react-6.24.1.tgz";
        sha1 = "ba69dfaea45fc3ec639b6a4ecea6e17702c91380";
      };
    }

    {
      name = "babel-preset-stage-0-6.24.1.tgz";
      path = fetchurl {
        name = "babel-preset-stage-0-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-stage-0/-/babel-preset-stage-0-6.24.1.tgz";
        sha1 = "5642d15042f91384d7e5af8bc88b1db95b039e6a";
      };
    }

    {
      name = "babel-preset-stage-1-6.24.1.tgz";
      path = fetchurl {
        name = "babel-preset-stage-1-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-stage-1/-/babel-preset-stage-1-6.24.1.tgz";
        sha1 = "7692cd7dcd6849907e6ae4a0a85589cfb9e2bfb0";
      };
    }

    {
      name = "babel-preset-stage-2-6.24.1.tgz";
      path = fetchurl {
        name = "babel-preset-stage-2-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-stage-2/-/babel-preset-stage-2-6.24.1.tgz";
        sha1 = "d9e2960fb3d71187f0e64eec62bc07767219bdc1";
      };
    }

    {
      name = "babel-preset-stage-3-6.24.1.tgz";
      path = fetchurl {
        name = "babel-preset-stage-3-6.24.1.tgz";
        url  = "https://registry.yarnpkg.com/babel-preset-stage-3/-/babel-preset-stage-3-6.24.1.tgz";
        sha1 = "836ada0a9e7a7fa37cb138fb9326f87934a48395";
      };
    }

    {
      name = "babel-register-6.26.0.tgz";
      path = fetchurl {
        name = "babel-register-6.26.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-register/-/babel-register-6.26.0.tgz";
        sha1 = "6ed021173e2fcb486d7acb45c6009a856f647071";
      };
    }

    {
      name = "babel-runtime-5.8.38.tgz";
      path = fetchurl {
        name = "babel-runtime-5.8.38.tgz";
        url  = "https://registry.yarnpkg.com/babel-runtime/-/babel-runtime-5.8.38.tgz";
        sha1 = "1c0b02eb63312f5f087ff20450827b425c9d4c19";
      };
    }

    {
      name = "babel-runtime-6.26.0.tgz";
      path = fetchurl {
        name = "babel-runtime-6.26.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-runtime/-/babel-runtime-6.26.0.tgz";
        sha1 = "965c7058668e82b55d7bfe04ff2337bc8b5647fe";
      };
    }

    {
      name = "babel-template-6.26.0.tgz";
      path = fetchurl {
        name = "babel-template-6.26.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-template/-/babel-template-6.26.0.tgz";
        sha1 = "de03e2d16396b069f46dd9fff8521fb1a0e35e02";
      };
    }

    {
      name = "babel-traverse-6.26.0.tgz";
      path = fetchurl {
        name = "babel-traverse-6.26.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-traverse/-/babel-traverse-6.26.0.tgz";
        sha1 = "46a9cbd7edcc62c8e5c064e2d2d8d0f4035766ee";
      };
    }

    {
      name = "babel-types-6.26.0.tgz";
      path = fetchurl {
        name = "babel-types-6.26.0.tgz";
        url  = "https://registry.yarnpkg.com/babel-types/-/babel-types-6.26.0.tgz";
        sha1 = "a3b073f94ab49eb6fa55cd65227a334380632497";
      };
    }

    {
      name = "babili-webpack-plugin-0.0.11.tgz";
      path = fetchurl {
        name = "babili-webpack-plugin-0.0.11.tgz";
        url  = "https://registry.yarnpkg.com/babili-webpack-plugin/-/babili-webpack-plugin-0.0.11.tgz";
        sha1 = "09571593b81bbcc3033e8570540b391e98801803";
      };
    }

    {
      name = "babylon-7.0.0-beta.19.tgz";
      path = fetchurl {
        name = "babylon-7.0.0-beta.19.tgz";
        url  = "https://registry.yarnpkg.com/babylon/-/babylon-7.0.0-beta.19.tgz";
        sha1 = "e928c7e807e970e0536b078ab3e0c48f9e052503";
      };
    }

    {
      name = "babylon-7.0.0-beta.31.tgz";
      path = fetchurl {
        name = "babylon-7.0.0-beta.31.tgz";
        url  = "https://registry.yarnpkg.com/babylon/-/babylon-7.0.0-beta.31.tgz";
        sha1 = "7ec10f81e0e456fd0f855ad60fa30c2ac454283f";
      };
    }

    {
      name = "babylon-7.0.0-beta.44.tgz";
      path = fetchurl {
        name = "babylon-7.0.0-beta.44.tgz";
        url  = "https://registry.yarnpkg.com/babylon/-/babylon-7.0.0-beta.44.tgz";
        sha1 = "89159e15e6e30c5096e22d738d8c0af8a0e8ca1d";
      };
    }

    {
      name = "babylon-6.18.0.tgz";
      path = fetchurl {
        name = "babylon-6.18.0.tgz";
        url  = "https://registry.yarnpkg.com/babylon/-/babylon-6.18.0.tgz";
        sha1 = "af2f3b88fa6f5c1e4c634d1a0f8eac4f55b395e3";
      };
    }

    {
      name = "bail-1.0.3.tgz";
      path = fetchurl {
        name = "bail-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/bail/-/bail-1.0.3.tgz";
        sha1 = "63cfb9ddbac829b02a3128cd53224be78e6c21a3";
      };
    }

    {
      name = "balanced-match-0.4.2.tgz";
      path = fetchurl {
        name = "balanced-match-0.4.2.tgz";
        url  = "https://registry.yarnpkg.com/balanced-match/-/balanced-match-0.4.2.tgz";
        sha1 = "cb3f3e3c732dc0f01ee70b403f302e61d7709838";
      };
    }

    {
      name = "balanced-match-1.0.0.tgz";
      path = fetchurl {
        name = "balanced-match-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/balanced-match/-/balanced-match-1.0.0.tgz";
        sha1 = "89b4d199ab2bee49de164ea02b89ce462d71b767";
      };
    }

    {
      name = "base32.js-0.1.0.tgz";
      path = fetchurl {
        name = "base32.js-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/base32.js/-/base32.js-0.1.0.tgz";
        sha1 = "b582dec693c2f11e893cf064ee6ac5b6131a2202";
      };
    }

    {
      name = "base64-js-1.3.0.tgz";
      path = fetchurl {
        name = "base64-js-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/base64-js/-/base64-js-1.3.0.tgz";
        sha1 = "cab1e6118f051095e58b5281aea8c1cd22bfc0e3";
      };
    }

    {
      name = "base-0.11.2.tgz";
      path = fetchurl {
        name = "base-0.11.2.tgz";
        url  = "https://registry.yarnpkg.com/base/-/base-0.11.2.tgz";
        sha1 = "7bde5ced145b6d551a90db87f83c558b4eb48a8f";
      };
    }

    {
      name = "basic-auth-2.0.0.tgz";
      path = fetchurl {
        name = "basic-auth-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/basic-auth/-/basic-auth-2.0.0.tgz";
        sha1 = "015db3f353e02e56377755f962742e8981e7bbba";
      };
    }

    {
      name = "batch-0.6.1.tgz";
      path = fetchurl {
        name = "batch-0.6.1.tgz";
        url  = "https://registry.yarnpkg.com/batch/-/batch-0.6.1.tgz";
        sha1 = "dc34314f4e679318093fc760272525f94bf25c16";
      };
    }

    {
      name = "bcrypt-pbkdf-1.0.2.tgz";
      path = fetchurl {
        name = "bcrypt-pbkdf-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/bcrypt-pbkdf/-/bcrypt-pbkdf-1.0.2.tgz";
        sha1 = "a4301d389b6a43f9b67ff3ca11a3f6637e360e9e";
      };
    }

    {
      name = "bcrypt-2.0.1.tgz";
      path = fetchurl {
        name = "bcrypt-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/bcrypt/-/bcrypt-2.0.1.tgz";
        sha1 = "229c5afe09379789f918efe86e5e5b682e509f85";
      };
    }

    {
      name = "big-integer-1.6.32.tgz";
      path = fetchurl {
        name = "big-integer-1.6.32.tgz";
        url  = "https://registry.yarnpkg.com/big-integer/-/big-integer-1.6.32.tgz";
        sha1 = "5867458b25ecd5bcb36b627c30bb501a13c07e89";
      };
    }

    {
      name = "big.js-3.2.0.tgz";
      path = fetchurl {
        name = "big.js-3.2.0.tgz";
        url  = "https://registry.yarnpkg.com/big.js/-/big.js-3.2.0.tgz";
        sha1 = "a5fc298b81b9e0dca2e458824784b65c52ba588e";
      };
    }

    {
      name = "bin-v8-flags-filter-1.1.3.tgz";
      path = fetchurl {
        name = "bin-v8-flags-filter-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/bin-v8-flags-filter/-/bin-v8-flags-filter-1.1.3.tgz";
        sha1 = "14c018c6cca7529767c1f42f12bd3bb20d61e4d3";
      };
    }

    {
      name = "binary-extensions-1.11.0.tgz";
      path = fetchurl {
        name = "binary-extensions-1.11.0.tgz";
        url  = "https://registry.yarnpkg.com/binary-extensions/-/binary-extensions-1.11.0.tgz";
        sha1 = "46aa1751fb6a2f93ee5e689bb1087d4b14c6c205";
      };
    }

    {
      name = "binary-0.3.0.tgz";
      path = fetchurl {
        name = "binary-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/binary/-/binary-0.3.0.tgz";
        sha1 = "9f60553bc5ce8c3386f3b553cff47462adecaa79";
      };
    }

    {
      name = "bl-1.2.2.tgz";
      path = fetchurl {
        name = "bl-1.2.2.tgz";
        url  = "https://registry.yarnpkg.com/bl/-/bl-1.2.2.tgz";
        sha1 = "a160911717103c07410cef63ef51b397c025af9c";
      };
    }

    {
      name = "block-stream-0.0.9.tgz";
      path = fetchurl {
        name = "block-stream-0.0.9.tgz";
        url  = "https://registry.yarnpkg.com/block-stream/-/block-stream-0.0.9.tgz";
        sha1 = "13ebfe778a03205cfe03751481ebb4b3300c126a";
      };
    }

    {
      name = "bluebird-3.5.1.tgz";
      path = fetchurl {
        name = "bluebird-3.5.1.tgz";
        url  = "https://registry.yarnpkg.com/bluebird/-/bluebird-3.5.1.tgz";
        sha1 = "d9551f9de98f1fcda1e683d17ee91a0602ee2eb9";
      };
    }

    {
      name = "bluebird-3.4.7.tgz";
      path = fetchurl {
        name = "bluebird-3.4.7.tgz";
        url  = "https://registry.yarnpkg.com/bluebird/-/bluebird-3.4.7.tgz";
        sha1 = "f72d760be09b7f76d08ed8fae98b289a8d05fab3";
      };
    }

    {
      name = "bn.js-4.11.8.tgz";
      path = fetchurl {
        name = "bn.js-4.11.8.tgz";
        url  = "https://registry.yarnpkg.com/bn.js/-/bn.js-4.11.8.tgz";
        sha1 = "2cde09eb5ee341f484746bb0309b3253b1b1442f";
      };
    }

    {
      name = "body-parser-1.18.2.tgz";
      path = fetchurl {
        name = "body-parser-1.18.2.tgz";
        url  = "https://registry.yarnpkg.com/body-parser/-/body-parser-1.18.2.tgz";
        sha1 = "87678a19d84b47d859b83199bd59bce222b10454";
      };
    }

    {
      name = "body-parser-1.18.3.tgz";
      path = fetchurl {
        name = "body-parser-1.18.3.tgz";
        url  = "https://registry.yarnpkg.com/body-parser/-/body-parser-1.18.3.tgz";
        sha1 = "5b292198ffdd553b3a0f20ded0592b956955c8b4";
      };
    }

    {
      name = "bonjour-3.5.0.tgz";
      path = fetchurl {
        name = "bonjour-3.5.0.tgz";
        url  = "https://registry.yarnpkg.com/bonjour/-/bonjour-3.5.0.tgz";
        sha1 = "8e890a183d8ee9a2393b3844c691a42bcf7bc9f5";
      };
    }

    {
      name = "boolbase-1.0.0.tgz";
      path = fetchurl {
        name = "boolbase-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/boolbase/-/boolbase-1.0.0.tgz";
        sha1 = "68dff5fbe60c51eb37725ea9e3ed310dcc1e776e";
      };
    }

    {
      name = "boom-2.10.1.tgz";
      path = fetchurl {
        name = "boom-2.10.1.tgz";
        url  = "https://registry.yarnpkg.com/boom/-/boom-2.10.1.tgz";
        sha1 = "39c8918ceff5799f83f9492a848f625add0c766f";
      };
    }

    {
      name = "bootstrap-sass-3.3.7.tgz";
      path = fetchurl {
        name = "bootstrap-sass-3.3.7.tgz";
        url  = "https://registry.yarnpkg.com/bootstrap-sass/-/bootstrap-sass-3.3.7.tgz";
        sha1 = "6596c7ab40f6637393323ab0bc80d064fc630498";
      };
    }

    {
      name = "bowser-1.6.0.tgz";
      path = fetchurl {
        name = "bowser-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/bowser/-/bowser-1.6.0.tgz";
        sha1 = "37fc387b616cb6aef370dab4d6bd402b74c5c54d";
      };
    }

    {
      name = "brace-expansion-1.1.11.tgz";
      path = fetchurl {
        name = "brace-expansion-1.1.11.tgz";
        url  = "https://registry.yarnpkg.com/brace-expansion/-/brace-expansion-1.1.11.tgz";
        sha1 = "3c7fcbf529d87226f3d2f52b966ff5271eb441dd";
      };
    }

    {
      name = "braces-1.8.5.tgz";
      path = fetchurl {
        name = "braces-1.8.5.tgz";
        url  = "https://registry.yarnpkg.com/braces/-/braces-1.8.5.tgz";
        sha1 = "ba77962e12dff969d6b76711e914b737857bf6a7";
      };
    }

    {
      name = "braces-2.3.2.tgz";
      path = fetchurl {
        name = "braces-2.3.2.tgz";
        url  = "https://registry.yarnpkg.com/braces/-/braces-2.3.2.tgz";
        sha1 = "5979fd3f14cd531565e5fa2df1abfff1dfaee729";
      };
    }

    {
      name = "broadway-0.3.6.tgz";
      path = fetchurl {
        name = "broadway-0.3.6.tgz";
        url  = "https://registry.yarnpkg.com/broadway/-/broadway-0.3.6.tgz";
        sha1 = "7dbef068b954b7907925fd544963b578a902ba7a";
      };
    }

    {
      name = "brorand-1.1.0.tgz";
      path = fetchurl {
        name = "brorand-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/brorand/-/brorand-1.1.0.tgz";
        sha1 = "12c25efe40a45e3c323eb8675a0a0ce57b22371f";
      };
    }

    {
      name = "brotli-1.3.2.tgz";
      path = fetchurl {
        name = "brotli-1.3.2.tgz";
        url  = "https://registry.yarnpkg.com/brotli/-/brotli-1.3.2.tgz";
        sha1 = "525a9cad4fcba96475d7d388f6aecb13eed52f46";
      };
    }

    {
      name = "browser-process-hrtime-0.1.2.tgz";
      path = fetchurl {
        name = "browser-process-hrtime-0.1.2.tgz";
        url  = "https://registry.yarnpkg.com/browser-process-hrtime/-/browser-process-hrtime-0.1.2.tgz";
        sha1 = "425d68a58d3447f02a04aa894187fce8af8b7b8e";
      };
    }

    {
      name = "browser-resolve-1.11.3.tgz";
      path = fetchurl {
        name = "browser-resolve-1.11.3.tgz";
        url  = "https://registry.yarnpkg.com/browser-resolve/-/browser-resolve-1.11.3.tgz";
        sha1 = "9b7cbb3d0f510e4cb86bdbd796124d28b5890af6";
      };
    }

    {
      name = "browserify-aes-1.2.0.tgz";
      path = fetchurl {
        name = "browserify-aes-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/browserify-aes/-/browserify-aes-1.2.0.tgz";
        sha1 = "326734642f403dabc3003209853bb70ad428ef48";
      };
    }

    {
      name = "browserify-cipher-1.0.1.tgz";
      path = fetchurl {
        name = "browserify-cipher-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/browserify-cipher/-/browserify-cipher-1.0.1.tgz";
        sha1 = "8d6474c1b870bfdabcd3bcfcc1934a10e94f15f0";
      };
    }

    {
      name = "browserify-des-1.0.2.tgz";
      path = fetchurl {
        name = "browserify-des-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/browserify-des/-/browserify-des-1.0.2.tgz";
        sha1 = "3af4f1f59839403572f1c66204375f7a7f703e9c";
      };
    }

    {
      name = "browserify-rsa-4.0.1.tgz";
      path = fetchurl {
        name = "browserify-rsa-4.0.1.tgz";
        url  = "https://registry.yarnpkg.com/browserify-rsa/-/browserify-rsa-4.0.1.tgz";
        sha1 = "21e0abfaf6f2029cf2fafb133567a701d4135524";
      };
    }

    {
      name = "browserify-sign-4.0.4.tgz";
      path = fetchurl {
        name = "browserify-sign-4.0.4.tgz";
        url  = "https://registry.yarnpkg.com/browserify-sign/-/browserify-sign-4.0.4.tgz";
        sha1 = "aa4eb68e5d7b658baa6bf6a57e630cbd7a93d298";
      };
    }

    {
      name = "browserify-zlib-0.2.0.tgz";
      path = fetchurl {
        name = "browserify-zlib-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/browserify-zlib/-/browserify-zlib-0.2.0.tgz";
        sha1 = "2869459d9aa3be245fe8fe2ca1f46e2e7f54d73f";
      };
    }

    {
      name = "browserslist-1.7.7.tgz";
      path = fetchurl {
        name = "browserslist-1.7.7.tgz";
        url  = "https://registry.yarnpkg.com/browserslist/-/browserslist-1.7.7.tgz";
        sha1 = "0bd76704258be829b2398bb50e4b62d1a166b0b9";
      };
    }

    {
      name = "browserslist-2.11.3.tgz";
      path = fetchurl {
        name = "browserslist-2.11.3.tgz";
        url  = "https://registry.yarnpkg.com/browserslist/-/browserslist-2.11.3.tgz";
        sha1 = "fe36167aed1bbcde4827ebfe71347a2cc70b99b2";
      };
    }

    {
      name = "browserslist-3.2.8.tgz";
      path = fetchurl {
        name = "browserslist-3.2.8.tgz";
        url  = "https://registry.yarnpkg.com/browserslist/-/browserslist-3.2.8.tgz";
        sha1 = "b0005361d6471f0f5952797a76fc985f1f978fc6";
      };
    }

    {
      name = "bser-1.0.2.tgz";
      path = fetchurl {
        name = "bser-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/bser/-/bser-1.0.2.tgz";
        sha1 = "381116970b2a6deea5646dd15dd7278444b56169";
      };
    }

    {
      name = "bser-2.0.0.tgz";
      path = fetchurl {
        name = "bser-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/bser/-/bser-2.0.0.tgz";
        sha1 = "9ac78d3ed5d915804fd87acb158bc797147a1719";
      };
    }

    {
      name = "buble-0.19.3.tgz";
      path = fetchurl {
        name = "buble-0.19.3.tgz";
        url  = "https://registry.yarnpkg.com/buble/-/buble-0.19.3.tgz";
        sha1 = "01e9412062cff1da6f20342b6ecd72e7bf699d02";
      };
    }

    {
      name = "buffer-alloc-unsafe-1.1.0.tgz";
      path = fetchurl {
        name = "buffer-alloc-unsafe-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/buffer-alloc-unsafe/-/buffer-alloc-unsafe-1.1.0.tgz";
        sha1 = "bd7dc26ae2972d0eda253be061dba992349c19f0";
      };
    }

    {
      name = "buffer-alloc-1.2.0.tgz";
      path = fetchurl {
        name = "buffer-alloc-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/buffer-alloc/-/buffer-alloc-1.2.0.tgz";
        sha1 = "890dd90d923a873e08e10e5fd51a57e5b7cce0ec";
      };
    }

    {
      name = "buffer-crc32-0.2.13.tgz";
      path = fetchurl {
        name = "buffer-crc32-0.2.13.tgz";
        url  = "https://registry.yarnpkg.com/buffer-crc32/-/buffer-crc32-0.2.13.tgz";
        sha1 = "0d333e3f00eac50aa1454abd30ef8c2a5d9a7242";
      };
    }

    {
      name = "buffer-equal-constant-time-1.0.1.tgz";
      path = fetchurl {
        name = "buffer-equal-constant-time-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/buffer-equal-constant-time/-/buffer-equal-constant-time-1.0.1.tgz";
        sha1 = "f8e71132f7ffe6e01a5c9697a4c6f3e48d5cc819";
      };
    }

    {
      name = "buffer-fill-1.0.0.tgz";
      path = fetchurl {
        name = "buffer-fill-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/buffer-fill/-/buffer-fill-1.0.0.tgz";
        sha1 = "f8f78b76789888ef39f205cd637f68e702122b2c";
      };
    }

    {
      name = "buffer-from-0.1.1.tgz";
      path = fetchurl {
        name = "buffer-from-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/buffer-from/-/buffer-from-0.1.1.tgz";
        sha1 = "57b18b1da0a19ec06f33837a5275a242351bd75e";
      };
    }

    {
      name = "buffer-from-1.1.0.tgz";
      path = fetchurl {
        name = "buffer-from-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/buffer-from/-/buffer-from-1.1.0.tgz";
        sha1 = "87fcaa3a298358e0ade6e442cfce840740d1ad04";
      };
    }

    {
      name = "buffer-indexof-polyfill-1.0.1.tgz";
      path = fetchurl {
        name = "buffer-indexof-polyfill-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/buffer-indexof-polyfill/-/buffer-indexof-polyfill-1.0.1.tgz";
        sha1 = "a9fb806ce8145d5428510ce72f278bb363a638bf";
      };
    }

    {
      name = "buffer-indexof-1.1.1.tgz";
      path = fetchurl {
        name = "buffer-indexof-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/buffer-indexof/-/buffer-indexof-1.1.1.tgz";
        sha1 = "52fabcc6a606d1a00302802648ef68f639da268c";
      };
    }

    {
      name = "buffer-shims-1.0.0.tgz";
      path = fetchurl {
        name = "buffer-shims-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/buffer-shims/-/buffer-shims-1.0.0.tgz";
        sha1 = "9978ce317388c649ad8793028c3477ef044a8b51";
      };
    }

    {
      name = "buffer-writer-1.0.1.tgz";
      path = fetchurl {
        name = "buffer-writer-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/buffer-writer/-/buffer-writer-1.0.1.tgz";
        sha1 = "22a936901e3029afcd7547eb4487ceb697a3bf08";
      };
    }

    {
      name = "buffer-xor-1.0.3.tgz";
      path = fetchurl {
        name = "buffer-xor-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/buffer-xor/-/buffer-xor-1.0.3.tgz";
        sha1 = "26e61ed1422fb70dd42e6e36729ed51d855fe8d9";
      };
    }

    {
      name = "buffer-4.9.1.tgz";
      path = fetchurl {
        name = "buffer-4.9.1.tgz";
        url  = "https://registry.yarnpkg.com/buffer/-/buffer-4.9.1.tgz";
        sha1 = "6d1bb601b07a4efced97094132093027c95bc298";
      };
    }

    {
      name = "buffer-5.1.0.tgz";
      path = fetchurl {
        name = "buffer-5.1.0.tgz";
        url  = "https://registry.yarnpkg.com/buffer/-/buffer-5.1.0.tgz";
        sha1 = "c913e43678c7cb7c8bd16afbcddb6c5505e8f9fe";
      };
    }

    {
      name = "buffers-0.1.1.tgz";
      path = fetchurl {
        name = "buffers-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/buffers/-/buffers-0.1.1.tgz";
        sha1 = "b24579c3bed4d6d396aeee6d9a8ae7f5482ab7bb";
      };
    }

    {
      name = "builtin-modules-1.1.1.tgz";
      path = fetchurl {
        name = "builtin-modules-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/builtin-modules/-/builtin-modules-1.1.1.tgz";
        sha1 = "270f076c5a72c02f5b65a47df94c5fe3a278892f";
      };
    }

    {
      name = "builtin-status-codes-3.0.0.tgz";
      path = fetchurl {
        name = "builtin-status-codes-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/builtin-status-codes/-/builtin-status-codes-3.0.0.tgz";
        sha1 = "85982878e21b98e1c66425e03d0174788f569ee8";
      };
    }

    {
      name = "busboy-0.2.14.tgz";
      path = fetchurl {
        name = "busboy-0.2.14.tgz";
        url  = "https://registry.yarnpkg.com/busboy/-/busboy-0.2.14.tgz";
        sha1 = "6c2a622efcf47c57bbbe1e2a9c37ad36c7925453";
      };
    }

    {
      name = "byline-5.0.0.tgz";
      path = fetchurl {
        name = "byline-5.0.0.tgz";
        url  = "https://registry.yarnpkg.com/byline/-/byline-5.0.0.tgz";
        sha1 = "741c5216468eadc457b03410118ad77de8c1ddb1";
      };
    }

    {
      name = "bytes-3.0.0.tgz";
      path = fetchurl {
        name = "bytes-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/bytes/-/bytes-3.0.0.tgz";
        sha1 = "d32815404d689699f85a4ea4fa8755dd13a96048";
      };
    }

    {
      name = "cacache-10.0.4.tgz";
      path = fetchurl {
        name = "cacache-10.0.4.tgz";
        url  = "https://registry.yarnpkg.com/cacache/-/cacache-10.0.4.tgz";
        sha1 = "6452367999eff9d4188aefd9a14e9d7c6a263460";
      };
    }

    {
      name = "cache-base-1.0.1.tgz";
      path = fetchurl {
        name = "cache-base-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/cache-base/-/cache-base-1.0.1.tgz";
        sha1 = "0a7f46416831c8b662ee36fe4e7c59d76f666ab2";
      };
    }

    {
      name = "cache-point-0.4.1.tgz";
      path = fetchurl {
        name = "cache-point-0.4.1.tgz";
        url  = "https://registry.yarnpkg.com/cache-point/-/cache-point-0.4.1.tgz";
        sha1 = "cc8c9cbd99d90d7b0c66910cd33d77a1aab8840e";
      };
    }

    {
      name = "cached-constructors-x-1.0.2.tgz";
      path = fetchurl {
        name = "cached-constructors-x-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/cached-constructors-x/-/cached-constructors-x-1.0.2.tgz";
        sha1 = "d8a7b79b43fdcf13fd861bb763f38b627b0ccf91";
      };
    }

    {
      name = "caller-path-0.1.0.tgz";
      path = fetchurl {
        name = "caller-path-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/caller-path/-/caller-path-0.1.0.tgz";
        sha1 = "94085ef63581ecd3daa92444a8fe94e82577751f";
      };
    }

    {
      name = "callsite-record-4.1.3.tgz";
      path = fetchurl {
        name = "callsite-record-4.1.3.tgz";
        url  = "https://registry.yarnpkg.com/callsite-record/-/callsite-record-4.1.3.tgz";
        sha1 = "3041d2a1c72aff86b00b151e47d25566520c4207";
      };
    }

    {
      name = "callsite-1.0.0.tgz";
      path = fetchurl {
        name = "callsite-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/callsite/-/callsite-1.0.0.tgz";
        sha1 = "280398e5d664bd74038b6f0905153e6e8af1bc20";
      };
    }

    {
      name = "callsites-0.2.0.tgz";
      path = fetchurl {
        name = "callsites-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/callsites/-/callsites-0.2.0.tgz";
        sha1 = "afab96262910a7f33c19a5775825c69f34e350ca";
      };
    }

    {
      name = "callsites-2.0.0.tgz";
      path = fetchurl {
        name = "callsites-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/callsites/-/callsites-2.0.0.tgz";
        sha1 = "06eb84f00eea413da86affefacbffb36093b3c50";
      };
    }

    {
      name = "camel-case-3.0.0.tgz";
      path = fetchurl {
        name = "camel-case-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/camel-case/-/camel-case-3.0.0.tgz";
        sha1 = "ca3c3688a4e9cf3a4cda777dc4dcbc713249cf73";
      };
    }

    {
      name = "camelcase-keys-2.1.0.tgz";
      path = fetchurl {
        name = "camelcase-keys-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/camelcase-keys/-/camelcase-keys-2.1.0.tgz";
        sha1 = "308beeaffdf28119051efa1d932213c91b8f92e7";
      };
    }

    {
      name = "camelcase-keys-4.2.0.tgz";
      path = fetchurl {
        name = "camelcase-keys-4.2.0.tgz";
        url  = "https://registry.yarnpkg.com/camelcase-keys/-/camelcase-keys-4.2.0.tgz";
        sha1 = "a2aa5fb1af688758259c32c141426d78923b9b77";
      };
    }

    {
      name = "camelcase-1.2.1.tgz";
      path = fetchurl {
        name = "camelcase-1.2.1.tgz";
        url  = "https://registry.yarnpkg.com/camelcase/-/camelcase-1.2.1.tgz";
        sha1 = "9bb5304d2e0b56698b2c758b08a3eaa9daa58a39";
      };
    }

    {
      name = "camelcase-2.1.1.tgz";
      path = fetchurl {
        name = "camelcase-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/camelcase/-/camelcase-2.1.1.tgz";
        sha1 = "7c1d16d679a1bbe59ca02cacecfb011e201f5a1f";
      };
    }

    {
      name = "camelcase-3.0.0.tgz";
      path = fetchurl {
        name = "camelcase-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/camelcase/-/camelcase-3.0.0.tgz";
        sha1 = "32fc4b9fcdaf845fcdf7e73bb97cac2261f0ab0a";
      };
    }

    {
      name = "camelcase-4.1.0.tgz";
      path = fetchurl {
        name = "camelcase-4.1.0.tgz";
        url  = "https://registry.yarnpkg.com/camelcase/-/camelcase-4.1.0.tgz";
        sha1 = "d545635be1e33c542649c69173e5de6acfae34dd";
      };
    }

    {
      name = "camelize-1.0.0.tgz";
      path = fetchurl {
        name = "camelize-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/camelize/-/camelize-1.0.0.tgz";
        sha1 = "164a5483e630fa4321e5af07020e531831b2609b";
      };
    }

    {
      name = "caniuse-api-1.6.1.tgz";
      path = fetchurl {
        name = "caniuse-api-1.6.1.tgz";
        url  = "https://registry.yarnpkg.com/caniuse-api/-/caniuse-api-1.6.1.tgz";
        sha1 = "b534e7c734c4f81ec5fbe8aca2ad24354b962c6c";
      };
    }

    {
      name = "caniuse-db-1.0.30000865.tgz";
      path = fetchurl {
        name = "caniuse-db-1.0.30000865.tgz";
        url  = "https://registry.yarnpkg.com/caniuse-db/-/caniuse-db-1.0.30000865.tgz";
        sha1 = "82ffb64d40f7567620aac02d3a632079689abc6b";
      };
    }

    {
      name = "caniuse-lite-1.0.30000865.tgz";
      path = fetchurl {
        name = "caniuse-lite-1.0.30000865.tgz";
        url  = "https://registry.yarnpkg.com/caniuse-lite/-/caniuse-lite-1.0.30000865.tgz";
        sha1 = "70026616e8afe6e1442f8bb4e1092987d81a2f25";
      };
    }

    {
      name = "capture-exit-1.2.0.tgz";
      path = fetchurl {
        name = "capture-exit-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/capture-exit/-/capture-exit-1.2.0.tgz";
        sha1 = "1c5fcc489fd0ab00d4f1ac7ae1072e3173fbab6f";
      };
    }

    {
      name = "capture-stack-trace-1.0.0.tgz";
      path = fetchurl {
        name = "capture-stack-trace-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/capture-stack-trace/-/capture-stack-trace-1.0.0.tgz";
        sha1 = "4a6fa07399c26bba47f0b2496b4d0fb408c5550d";
      };
    }

    {
      name = "cardinal-1.0.0.tgz";
      path = fetchurl {
        name = "cardinal-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/cardinal/-/cardinal-1.0.0.tgz";
        sha1 = "50e21c1b0aa37729f9377def196b5a9cec932ee9";
      };
    }

    {
      name = "caseless-0.12.0.tgz";
      path = fetchurl {
        name = "caseless-0.12.0.tgz";
        url  = "https://registry.yarnpkg.com/caseless/-/caseless-0.12.0.tgz";
        sha1 = "1b681c21ff84033c826543090689420d187151dc";
      };
    }

    {
      name = "catharsis-0.8.9.tgz";
      path = fetchurl {
        name = "catharsis-0.8.9.tgz";
        url  = "https://registry.yarnpkg.com/catharsis/-/catharsis-0.8.9.tgz";
        sha1 = "98cc890ca652dd2ef0e70b37925310ff9e90fc8b";
      };
    }

    {
      name = "ccount-1.0.3.tgz";
      path = fetchurl {
        name = "ccount-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/ccount/-/ccount-1.0.3.tgz";
        sha1 = "f1cec43f332e2ea5a569fd46f9f5bde4e6102aff";
      };
    }

    {
      name = "center-align-0.1.3.tgz";
      path = fetchurl {
        name = "center-align-0.1.3.tgz";
        url  = "https://registry.yarnpkg.com/center-align/-/center-align-0.1.3.tgz";
        sha1 = "aa0d32629b6ee972200411cbd4461c907bc2b7ad";
      };
    }

    {
      name = "chai-3.5.0.tgz";
      path = fetchurl {
        name = "chai-3.5.0.tgz";
        url  = "https://registry.yarnpkg.com/chai/-/chai-3.5.0.tgz";
        sha1 = "4d02637b067fe958bdbfdd3a40ec56fef7373247";
      };
    }

    {
      name = "chainsaw-0.1.0.tgz";
      path = fetchurl {
        name = "chainsaw-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/chainsaw/-/chainsaw-0.1.0.tgz";
        sha1 = "5eab50b28afe58074d0d58291388828b5e5fbc98";
      };
    }

    {
      name = "chalk-1.1.3.tgz";
      path = fetchurl {
        name = "chalk-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/chalk/-/chalk-1.1.3.tgz";
        sha1 = "a8115c55e4a702fe4d150abd3872822a7e09fc98";
      };
    }

    {
      name = "chalk-2.4.1.tgz";
      path = fetchurl {
        name = "chalk-2.4.1.tgz";
        url  = "https://registry.yarnpkg.com/chalk/-/chalk-2.4.1.tgz";
        sha1 = "18c49ab16a037b6eb0152cc83e3471338215b66e";
      };
    }

    {
      name = "change-emitter-0.1.6.tgz";
      path = fetchurl {
        name = "change-emitter-0.1.6.tgz";
        url  = "https://registry.yarnpkg.com/change-emitter/-/change-emitter-0.1.6.tgz";
        sha1 = "e8b2fe3d7f1ab7d69a32199aff91ea6931409515";
      };
    }

    {
      name = "character-entities-html4-1.1.2.tgz";
      path = fetchurl {
        name = "character-entities-html4-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/character-entities-html4/-/character-entities-html4-1.1.2.tgz";
        sha1 = "c44fdde3ce66b52e8d321d6c1bf46101f0150610";
      };
    }

    {
      name = "character-entities-legacy-1.1.2.tgz";
      path = fetchurl {
        name = "character-entities-legacy-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/character-entities-legacy/-/character-entities-legacy-1.1.2.tgz";
        sha1 = "7c6defb81648498222c9855309953d05f4d63a9c";
      };
    }

    {
      name = "character-entities-1.2.2.tgz";
      path = fetchurl {
        name = "character-entities-1.2.2.tgz";
        url  = "https://registry.yarnpkg.com/character-entities/-/character-entities-1.2.2.tgz";
        sha1 = "58c8f371c0774ef0ba9b2aca5f00d8f100e6e363";
      };
    }

    {
      name = "character-reference-invalid-1.1.2.tgz";
      path = fetchurl {
        name = "character-reference-invalid-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/character-reference-invalid/-/character-reference-invalid-1.1.2.tgz";
        sha1 = "21e421ad3d84055952dab4a43a04e73cd425d3ed";
      };
    }

    {
      name = "chardet-0.4.2.tgz";
      path = fetchurl {
        name = "chardet-0.4.2.tgz";
        url  = "https://registry.yarnpkg.com/chardet/-/chardet-0.4.2.tgz";
        sha1 = "b5473b33dc97c424e5d98dc87d55d4d8a29c8bf2";
      };
    }

    {
      name = "cheerio-0.22.0.tgz";
      path = fetchurl {
        name = "cheerio-0.22.0.tgz";
        url  = "https://registry.yarnpkg.com/cheerio/-/cheerio-0.22.0.tgz";
        sha1 = "a9baa860a3f9b595a6b81b1a86873121ed3a269e";
      };
    }

    {
      name = "cheerio-1.0.0-rc.2.tgz";
      path = fetchurl {
        name = "cheerio-1.0.0-rc.2.tgz";
        url  = "https://registry.yarnpkg.com/cheerio/-/cheerio-1.0.0-rc.2.tgz";
        sha1 = "4b9f53a81b27e4d5dac31c0ffd0cfa03cc6830db";
      };
    }

    {
      name = "chokidar-1.7.0.tgz";
      path = fetchurl {
        name = "chokidar-1.7.0.tgz";
        url  = "https://registry.yarnpkg.com/chokidar/-/chokidar-1.7.0.tgz";
        sha1 = "798e689778151c8076b4b360e5edd28cda2bb468";
      };
    }

    {
      name = "chokidar-2.0.4.tgz";
      path = fetchurl {
        name = "chokidar-2.0.4.tgz";
        url  = "https://registry.yarnpkg.com/chokidar/-/chokidar-2.0.4.tgz";
        sha1 = "356ff4e2b0e8e43e322d18a372460bbcf3accd26";
      };
    }

    {
      name = "chownr-1.0.1.tgz";
      path = fetchurl {
        name = "chownr-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/chownr/-/chownr-1.0.1.tgz";
        sha1 = "e2a75042a9551908bebd25b8523d5f9769d79181";
      };
    }

    {
      name = "chrome-emulated-devices-list-0.1.1.tgz";
      path = fetchurl {
        name = "chrome-emulated-devices-list-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/chrome-emulated-devices-list/-/chrome-emulated-devices-list-0.1.1.tgz";
        sha1 = "9ee030c21aa6d065fbe562f3ce41ee257585fd60";
      };
    }

    {
      name = "chrome-remote-interface-0.25.7.tgz";
      path = fetchurl {
        name = "chrome-remote-interface-0.25.7.tgz";
        url  = "https://registry.yarnpkg.com/chrome-remote-interface/-/chrome-remote-interface-0.25.7.tgz";
        sha1 = "827e85fbef3cc561a9ef2404eb7eee355968c5bc";
      };
    }

    {
      name = "ci-info-1.1.3.tgz";
      path = fetchurl {
        name = "ci-info-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/ci-info/-/ci-info-1.1.3.tgz";
        sha1 = "710193264bb05c77b8c90d02f5aaf22216a667b2";
      };
    }

    {
      name = "cipher-base-1.0.4.tgz";
      path = fetchurl {
        name = "cipher-base-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/cipher-base/-/cipher-base-1.0.4.tgz";
        sha1 = "8760e4ecc272f4c363532f926d874aae2c1397de";
      };
    }

    {
      name = "circular-json-0.3.3.tgz";
      path = fetchurl {
        name = "circular-json-0.3.3.tgz";
        url  = "https://registry.yarnpkg.com/circular-json/-/circular-json-0.3.3.tgz";
        sha1 = "815c99ea84f6809529d2f45791bdf82711352d66";
      };
    }

    {
      name = "clap-1.2.3.tgz";
      path = fetchurl {
        name = "clap-1.2.3.tgz";
        url  = "https://registry.yarnpkg.com/clap/-/clap-1.2.3.tgz";
        sha1 = "4f36745b32008492557f46412d66d50cb99bce51";
      };
    }

    {
      name = "class-utils-0.3.6.tgz";
      path = fetchurl {
        name = "class-utils-0.3.6.tgz";
        url  = "https://registry.yarnpkg.com/class-utils/-/class-utils-0.3.6.tgz";
        sha1 = "f93369ae8b9a7ce02fd41faad0ca83033190c463";
      };
    }

    {
      name = "classnames-2.2.6.tgz";
      path = fetchurl {
        name = "classnames-2.2.6.tgz";
        url  = "https://registry.yarnpkg.com/classnames/-/classnames-2.2.6.tgz";
        sha1 = "43935bffdd291f326dad0a205309b38d00f650ce";
      };
    }

    {
      name = "clean-css-4.1.11.tgz";
      path = fetchurl {
        name = "clean-css-4.1.11.tgz";
        url  = "https://registry.yarnpkg.com/clean-css/-/clean-css-4.1.11.tgz";
        sha1 = "2ecdf145aba38f54740f26cefd0ff3e03e125d6a";
      };
    }

    {
      name = "clean-webpack-plugin-0.1.19.tgz";
      path = fetchurl {
        name = "clean-webpack-plugin-0.1.19.tgz";
        url  = "https://registry.yarnpkg.com/clean-webpack-plugin/-/clean-webpack-plugin-0.1.19.tgz";
        sha1 = "ceda8bb96b00fe168e9b080272960d20fdcadd6d";
      };
    }

    {
      name = "cli-cursor-1.0.2.tgz";
      path = fetchurl {
        name = "cli-cursor-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/cli-cursor/-/cli-cursor-1.0.2.tgz";
        sha1 = "64da3f7d56a54412e59794bd62dc35295e8f2987";
      };
    }

    {
      name = "cli-cursor-2.1.0.tgz";
      path = fetchurl {
        name = "cli-cursor-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/cli-cursor/-/cli-cursor-2.1.0.tgz";
        sha1 = "b35dac376479facc3e94747d41d0d0f5238ffcb5";
      };
    }

    {
      name = "cli-spinners-0.1.2.tgz";
      path = fetchurl {
        name = "cli-spinners-0.1.2.tgz";
        url  = "https://registry.yarnpkg.com/cli-spinners/-/cli-spinners-0.1.2.tgz";
        sha1 = "bb764d88e185fb9e1e6a2a1f19772318f605e31c";
      };
    }

    {
      name = "cli-spinners-1.3.1.tgz";
      path = fetchurl {
        name = "cli-spinners-1.3.1.tgz";
        url  = "https://registry.yarnpkg.com/cli-spinners/-/cli-spinners-1.3.1.tgz";
        sha1 = "002c1990912d0d59580c93bd36c056de99e4259a";
      };
    }

    {
      name = "cli-table-0.3.1.tgz";
      path = fetchurl {
        name = "cli-table-0.3.1.tgz";
        url  = "https://registry.yarnpkg.com/cli-table/-/cli-table-0.3.1.tgz";
        sha1 = "f53b05266a8b1a0b934b3d0821e6e2dc5914ae23";
      };
    }

    {
      name = "cli-truncate-0.2.1.tgz";
      path = fetchurl {
        name = "cli-truncate-0.2.1.tgz";
        url  = "https://registry.yarnpkg.com/cli-truncate/-/cli-truncate-0.2.1.tgz";
        sha1 = "9f15cfbb0705005369216c626ac7d05ab90dd574";
      };
    }

    {
      name = "cli-usage-0.1.7.tgz";
      path = fetchurl {
        name = "cli-usage-0.1.7.tgz";
        url  = "https://registry.yarnpkg.com/cli-usage/-/cli-usage-0.1.7.tgz";
        sha1 = "eaf1c9d5b91e22482333072a12127f05cd99a3ba";
      };
    }

    {
      name = "cli-width-2.2.0.tgz";
      path = fetchurl {
        name = "cli-width-2.2.0.tgz";
        url  = "https://registry.yarnpkg.com/cli-width/-/cli-width-2.2.0.tgz";
        sha1 = "ff19ede8a9a5e579324147b0c11f0fbcbabed639";
      };
    }

    {
      name = "cliff-0.1.9.tgz";
      path = fetchurl {
        name = "cliff-0.1.9.tgz";
        url  = "https://registry.yarnpkg.com/cliff/-/cliff-0.1.9.tgz";
        sha1 = "a211e09c6a3de3ba1af27d049d301250d18812bc";
      };
    }

    {
      name = "clipboard-copy-2.0.0.tgz";
      path = fetchurl {
        name = "clipboard-copy-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/clipboard-copy/-/clipboard-copy-2.0.0.tgz";
        sha1 = "663abcd8be9c641de6e92a2eb9afef6e0afa727e";
      };
    }

    {
      name = "cliui-2.1.0.tgz";
      path = fetchurl {
        name = "cliui-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/cliui/-/cliui-2.1.0.tgz";
        sha1 = "4b475760ff80264c762c3a1719032e91c7fea0d1";
      };
    }

    {
      name = "cliui-3.2.0.tgz";
      path = fetchurl {
        name = "cliui-3.2.0.tgz";
        url  = "https://registry.yarnpkg.com/cliui/-/cliui-3.2.0.tgz";
        sha1 = "120601537a916d29940f934da3b48d585a39213d";
      };
    }

    {
      name = "cliui-4.1.0.tgz";
      path = fetchurl {
        name = "cliui-4.1.0.tgz";
        url  = "https://registry.yarnpkg.com/cliui/-/cliui-4.1.0.tgz";
        sha1 = "348422dbe82d800b3022eef4f6ac10bf2e4d1b49";
      };
    }

    {
      name = "clone-buffer-1.0.0.tgz";
      path = fetchurl {
        name = "clone-buffer-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/clone-buffer/-/clone-buffer-1.0.0.tgz";
        sha1 = "e3e25b207ac4e701af721e2cb5a16792cac3dc58";
      };
    }

    {
      name = "clone-deep-2.0.2.tgz";
      path = fetchurl {
        name = "clone-deep-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/clone-deep/-/clone-deep-2.0.2.tgz";
        sha1 = "00db3a1e173656730d1188c3d6aced6d7ea97713";
      };
    }

    {
      name = "clone-regexp-1.0.1.tgz";
      path = fetchurl {
        name = "clone-regexp-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/clone-regexp/-/clone-regexp-1.0.1.tgz";
        sha1 = "051805cd33173375d82118fc0918606da39fd60f";
      };
    }

    {
      name = "clone-1.0.4.tgz";
      path = fetchurl {
        name = "clone-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/clone/-/clone-1.0.4.tgz";
        sha1 = "da309cc263df15994c688ca902179ca3c7cd7c7e";
      };
    }

    {
      name = "cmd-shim-2.0.2.tgz";
      path = fetchurl {
        name = "cmd-shim-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/cmd-shim/-/cmd-shim-2.0.2.tgz";
        sha1 = "6fcbda99483a8fd15d7d30a196ca69d688a2efdb";
      };
    }

    {
      name = "co-4.6.0.tgz";
      path = fetchurl {
        name = "co-4.6.0.tgz";
        url  = "https://registry.yarnpkg.com/co/-/co-4.6.0.tgz";
        sha1 = "6ea6bdf3d853ae54ccb8e47bfa0bf3f9031fb184";
      };
    }

    {
      name = "coa-1.0.4.tgz";
      path = fetchurl {
        name = "coa-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/coa/-/coa-1.0.4.tgz";
        sha1 = "a9ef153660d6a86a8bdec0289a5c684d217432fd";
      };
    }

    {
      name = "code-point-at-1.1.0.tgz";
      path = fetchurl {
        name = "code-point-at-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/code-point-at/-/code-point-at-1.1.0.tgz";
        sha1 = "0d070b4d043a5bea33a2f1a40e2edb3d9a4ccf77";
      };
    }

    {
      name = "codemirror-5.39.0.tgz";
      path = fetchurl {
        name = "codemirror-5.39.0.tgz";
        url  = "https://registry.yarnpkg.com/codemirror/-/codemirror-5.39.0.tgz";
        sha1 = "4654f7d2f7e525e04a62e72d9482348ccb37dce5";
      };
    }

    {
      name = "collapse-white-space-1.0.4.tgz";
      path = fetchurl {
        name = "collapse-white-space-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/collapse-white-space/-/collapse-white-space-1.0.4.tgz";
        sha1 = "ce05cf49e54c3277ae573036a26851ba430a0091";
      };
    }

    {
      name = "collect-all-1.0.3.tgz";
      path = fetchurl {
        name = "collect-all-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/collect-all/-/collect-all-1.0.3.tgz";
        sha1 = "1abcc20448b58a1447487fcf34130e9512b0acf8";
      };
    }

    {
      name = "collection-visit-1.0.0.tgz";
      path = fetchurl {
        name = "collection-visit-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/collection-visit/-/collection-visit-1.0.0.tgz";
        sha1 = "4bc0373c164bc3291b4d368c829cf1a80a59dca0";
      };
    }

    {
      name = "color-convert-1.9.2.tgz";
      path = fetchurl {
        name = "color-convert-1.9.2.tgz";
        url  = "https://registry.yarnpkg.com/color-convert/-/color-convert-1.9.2.tgz";
        sha1 = "49881b8fba67df12a96bdf3f56c0aab9e7913147";
      };
    }

    {
      name = "color-name-1.1.1.tgz";
      path = fetchurl {
        name = "color-name-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/color-name/-/color-name-1.1.1.tgz";
        sha1 = "4b1415304cf50028ea81643643bd82ea05803689";
      };
    }

    {
      name = "color-name-1.1.3.tgz";
      path = fetchurl {
        name = "color-name-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/color-name/-/color-name-1.1.3.tgz";
        sha1 = "a7d0558bd89c42f795dd42328f740831ca53bc25";
      };
    }

    {
      name = "color-string-0.3.0.tgz";
      path = fetchurl {
        name = "color-string-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/color-string/-/color-string-0.3.0.tgz";
        sha1 = "27d46fb67025c5c2fa25993bfbf579e47841b991";
      };
    }

    {
      name = "color-0.11.4.tgz";
      path = fetchurl {
        name = "color-0.11.4.tgz";
        url  = "https://registry.yarnpkg.com/color/-/color-0.11.4.tgz";
        sha1 = "6d7b5c74fb65e841cd48792ad1ed5e07b904d764";
      };
    }

    {
      name = "colormin-1.1.2.tgz";
      path = fetchurl {
        name = "colormin-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/colormin/-/colormin-1.1.2.tgz";
        sha1 = "ea2f7420a72b96881a38aae59ec124a6f7298133";
      };
    }

    {
      name = "colors-0.5.1.tgz";
      path = fetchurl {
        name = "colors-0.5.1.tgz";
        url  = "https://registry.yarnpkg.com/colors/-/colors-0.5.1.tgz";
        sha1 = "7d0023eaeb154e8ee9fce75dcb923d0ed1667774";
      };
    }

    {
      name = "colors-0.6.2.tgz";
      path = fetchurl {
        name = "colors-0.6.2.tgz";
        url  = "https://registry.yarnpkg.com/colors/-/colors-0.6.2.tgz";
        sha1 = "2423fe6678ac0c5dae8852e5d0e5be08c997abcc";
      };
    }

    {
      name = "colors-1.0.3.tgz";
      path = fetchurl {
        name = "colors-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/colors/-/colors-1.0.3.tgz";
        sha1 = "0433f44d809680fdeb60ed260f1b0c262e82a40b";
      };
    }

    {
      name = "colors-1.3.0.tgz";
      path = fetchurl {
        name = "colors-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/colors/-/colors-1.3.0.tgz";
        sha1 = "5f20c9fef6945cb1134260aab33bfbdc8295e04e";
      };
    }

    {
      name = "colors-1.1.2.tgz";
      path = fetchurl {
        name = "colors-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/colors/-/colors-1.1.2.tgz";
        sha1 = "168a4701756b6a7f51a12ce0c97bfa28c084ed63";
      };
    }

    {
      name = "columnify-1.5.4.tgz";
      path = fetchurl {
        name = "columnify-1.5.4.tgz";
        url  = "https://registry.yarnpkg.com/columnify/-/columnify-1.5.4.tgz";
        sha1 = "4737ddf1c7b69a8a7c340570782e947eec8e78bb";
      };
    }

    {
      name = "combined-stream-1.0.6.tgz";
      path = fetchurl {
        name = "combined-stream-1.0.6.tgz";
        url  = "https://registry.yarnpkg.com/combined-stream/-/combined-stream-1.0.6.tgz";
        sha1 = "723e7df6e801ac5613113a7e445a9b69cb632818";
      };
    }

    {
      name = "command-join-2.0.0.tgz";
      path = fetchurl {
        name = "command-join-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/command-join/-/command-join-2.0.0.tgz";
        sha1 = "52e8b984f4872d952ff1bdc8b98397d27c7144cf";
      };
    }

    {
      name = "command-line-args-5.0.2.tgz";
      path = fetchurl {
        name = "command-line-args-5.0.2.tgz";
        url  = "https://registry.yarnpkg.com/command-line-args/-/command-line-args-5.0.2.tgz";
        sha1 = "c4e56b016636af1323cf485aa25c3cb203dfbbe4";
      };
    }

    {
      name = "command-line-tool-0.8.0.tgz";
      path = fetchurl {
        name = "command-line-tool-0.8.0.tgz";
        url  = "https://registry.yarnpkg.com/command-line-tool/-/command-line-tool-0.8.0.tgz";
        sha1 = "b00290ef1dfc11cc731dd1f43a92cfa5f21e715b";
      };
    }

    {
      name = "command-line-usage-4.1.0.tgz";
      path = fetchurl {
        name = "command-line-usage-4.1.0.tgz";
        url  = "https://registry.yarnpkg.com/command-line-usage/-/command-line-usage-4.1.0.tgz";
        sha1 = "a6b3b2e2703b4dcf8bd46ae19e118a9a52972882";
      };
    }

    {
      name = "commander-2.11.0.tgz";
      path = fetchurl {
        name = "commander-2.11.0.tgz";
        url  = "https://registry.yarnpkg.com/commander/-/commander-2.11.0.tgz";
        sha1 = "157152fd1e7a6c8d98a5b715cf376df928004563";
      };
    }

    {
      name = "commander-2.16.0.tgz";
      path = fetchurl {
        name = "commander-2.16.0.tgz";
        url  = "https://registry.yarnpkg.com/commander/-/commander-2.16.0.tgz";
        sha1 = "f16390593996ceb4f3eeb020b31d78528f7f8a50";
      };
    }

    {
      name = "commander-2.1.0.tgz";
      path = fetchurl {
        name = "commander-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/commander/-/commander-2.1.0.tgz";
        sha1 = "d121bbae860d9992a3d517ba96f56588e47c6781";
      };
    }

    {
      name = "commander-2.13.0.tgz";
      path = fetchurl {
        name = "commander-2.13.0.tgz";
        url  = "https://registry.yarnpkg.com/commander/-/commander-2.13.0.tgz";
        sha1 = "6964bca67685df7c1f1430c584f07d7597885b9c";
      };
    }

    {
      name = "common-dir-1.0.1.tgz";
      path = fetchurl {
        name = "common-dir-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/common-dir/-/common-dir-1.0.1.tgz";
        sha1 = "4fd872085ebc5f262d9cc23b0ff34b3e457677f0";
      };
    }

    {
      name = "common-sequence-1.0.2.tgz";
      path = fetchurl {
        name = "common-sequence-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/common-sequence/-/common-sequence-1.0.2.tgz";
        sha1 = "30e07f3f8f6f7f9b3dee854f20b2d39eee086de8";
      };
    }

    {
      name = "commondir-1.0.1.tgz";
      path = fetchurl {
        name = "commondir-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/commondir/-/commondir-1.0.1.tgz";
        sha1 = "ddd800da0c66127393cca5950ea968a3aaf1253b";
      };
    }

    {
      name = "compare-func-1.3.2.tgz";
      path = fetchurl {
        name = "compare-func-1.3.2.tgz";
        url  = "https://registry.yarnpkg.com/compare-func/-/compare-func-1.3.2.tgz";
        sha1 = "99dd0ba457e1f9bc722b12c08ec33eeab31fa648";
      };
    }

    {
      name = "compare-versions-3.3.0.tgz";
      path = fetchurl {
        name = "compare-versions-3.3.0.tgz";
        url  = "https://registry.yarnpkg.com/compare-versions/-/compare-versions-3.3.0.tgz";
        sha1 = "af93ea705a96943f622ab309578b9b90586f39c3";
      };
    }

    {
      name = "component-emitter-1.2.1.tgz";
      path = fetchurl {
        name = "component-emitter-1.2.1.tgz";
        url  = "https://registry.yarnpkg.com/component-emitter/-/component-emitter-1.2.1.tgz";
        sha1 = "137918d6d78283f7df7a6b7c5a63e140e69425e6";
      };
    }

    {
      name = "compress-commons-1.2.2.tgz";
      path = fetchurl {
        name = "compress-commons-1.2.2.tgz";
        url  = "https://registry.yarnpkg.com/compress-commons/-/compress-commons-1.2.2.tgz";
        sha1 = "524a9f10903f3a813389b0225d27c48bb751890f";
      };
    }

    {
      name = "compressible-2.0.14.tgz";
      path = fetchurl {
        name = "compressible-2.0.14.tgz";
        url  = "https://registry.yarnpkg.com/compressible/-/compressible-2.0.14.tgz";
        sha1 = "326c5f507fbb055f54116782b969a81b67a29da7";
      };
    }

    {
      name = "compression-webpack-plugin-1.1.11.tgz";
      path = fetchurl {
        name = "compression-webpack-plugin-1.1.11.tgz";
        url  = "https://registry.yarnpkg.com/compression-webpack-plugin/-/compression-webpack-plugin-1.1.11.tgz";
        sha1 = "8384c7a6ead1d2e2efb190bdfcdcf35878ed8266";
      };
    }

    {
      name = "compression-1.7.2.tgz";
      path = fetchurl {
        name = "compression-1.7.2.tgz";
        url  = "http://registry.npmjs.org/compression/-/compression-1.7.2.tgz";
        sha1 = "aaffbcd6aaf854b44ebb280353d5ad1651f59a69";
      };
    }

    {
      name = "concat-map-0.0.1.tgz";
      path = fetchurl {
        name = "concat-map-0.0.1.tgz";
        url  = "https://registry.yarnpkg.com/concat-map/-/concat-map-0.0.1.tgz";
        sha1 = "d8a96bd77fd68df7793a73036a3ba0d5405d477b";
      };
    }

    {
      name = "concat-stream-1.6.0.tgz";
      path = fetchurl {
        name = "concat-stream-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/concat-stream/-/concat-stream-1.6.0.tgz";
        sha1 = "0aac662fd52be78964d5532f694784e70110acf7";
      };
    }

    {
      name = "concat-stream-1.6.2.tgz";
      path = fetchurl {
        name = "concat-stream-1.6.2.tgz";
        url  = "https://registry.yarnpkg.com/concat-stream/-/concat-stream-1.6.2.tgz";
        sha1 = "904bdf194cd3122fc675c77fc4ac3d4ff0fd1a34";
      };
    }

    {
      name = "config-master-3.1.0.tgz";
      path = fetchurl {
        name = "config-master-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/config-master/-/config-master-3.1.0.tgz";
        sha1 = "667663590505a283bf26a484d68489d74c5485da";
      };
    }

    {
      name = "config-1.30.0.tgz";
      path = fetchurl {
        name = "config-1.30.0.tgz";
        url  = "https://registry.yarnpkg.com/config/-/config-1.30.0.tgz";
        sha1 = "1d60a9f35348a13c175798d384e81a5a16c3ba6e";
      };
    }

    {
      name = "connect-history-api-fallback-1.5.0.tgz";
      path = fetchurl {
        name = "connect-history-api-fallback-1.5.0.tgz";
        url  = "https://registry.yarnpkg.com/connect-history-api-fallback/-/connect-history-api-fallback-1.5.0.tgz";
        sha1 = "b06873934bc5e344fef611a196a6faae0aee015a";
      };
    }

    {
      name = "connected-domain-1.0.0.tgz";
      path = fetchurl {
        name = "connected-domain-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/connected-domain/-/connected-domain-1.0.0.tgz";
        sha1 = "bfe77238c74be453a79f0cb6058deeb4f2358e93";
      };
    }

    {
      name = "console-browserify-1.1.0.tgz";
      path = fetchurl {
        name = "console-browserify-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/console-browserify/-/console-browserify-1.1.0.tgz";
        sha1 = "f0241c45730a9fc6323b206dbf38edc741d0bb10";
      };
    }

    {
      name = "console-control-strings-1.1.0.tgz";
      path = fetchurl {
        name = "console-control-strings-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/console-control-strings/-/console-control-strings-1.1.0.tgz";
        sha1 = "3d7cf4464db6446ea644bf4b39507f9851008e8e";
      };
    }

    {
      name = "constants-browserify-1.0.0.tgz";
      path = fetchurl {
        name = "constants-browserify-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/constants-browserify/-/constants-browserify-1.0.0.tgz";
        sha1 = "c20b96d8c617748aaf1c16021760cd27fcb8cb75";
      };
    }

    {
      name = "contains-path-0.1.0.tgz";
      path = fetchurl {
        name = "contains-path-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/contains-path/-/contains-path-0.1.0.tgz";
        sha1 = "fe8cf184ff6670b6baef01a9d4861a5cbec4120a";
      };
    }

    {
      name = "content-disposition-0.5.2.tgz";
      path = fetchurl {
        name = "content-disposition-0.5.2.tgz";
        url  = "https://registry.yarnpkg.com/content-disposition/-/content-disposition-0.5.2.tgz";
        sha1 = "0cf68bb9ddf5f2be7961c3a85178cb85dba78cb4";
      };
    }

    {
      name = "content-security-policy-builder-2.0.0.tgz";
      path = fetchurl {
        name = "content-security-policy-builder-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/content-security-policy-builder/-/content-security-policy-builder-2.0.0.tgz";
        sha1 = "8749a1d542fcbe82237281ea9f716ce68b394dd2";
      };
    }

    {
      name = "content-type-parser-1.0.2.tgz";
      path = fetchurl {
        name = "content-type-parser-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/content-type-parser/-/content-type-parser-1.0.2.tgz";
        sha1 = "caabe80623e63638b2502fd4c7f12ff4ce2352e7";
      };
    }

    {
      name = "content-type-1.0.4.tgz";
      path = fetchurl {
        name = "content-type-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/content-type/-/content-type-1.0.4.tgz";
        sha1 = "e138cc75e040c727b1966fe5e5f8c9aee256fe3b";
      };
    }

    {
      name = "conventional-changelog-angular-1.6.6.tgz";
      path = fetchurl {
        name = "conventional-changelog-angular-1.6.6.tgz";
        url  = "https://registry.yarnpkg.com/conventional-changelog-angular/-/conventional-changelog-angular-1.6.6.tgz";
        sha1 = "b27f2b315c16d0a1f23eb181309d0e6a4698ea0f";
      };
    }

    {
      name = "conventional-changelog-atom-0.2.8.tgz";
      path = fetchurl {
        name = "conventional-changelog-atom-0.2.8.tgz";
        url  = "https://registry.yarnpkg.com/conventional-changelog-atom/-/conventional-changelog-atom-0.2.8.tgz";
        sha1 = "8037693455990e3256f297320a45fa47ee553a14";
      };
    }

    {
      name = "conventional-changelog-cli-1.3.22.tgz";
      path = fetchurl {
        name = "conventional-changelog-cli-1.3.22.tgz";
        url  = "https://registry.yarnpkg.com/conventional-changelog-cli/-/conventional-changelog-cli-1.3.22.tgz";
        sha1 = "13570fe1728f56f013ff7a88878ff49d5162a405";
      };
    }

    {
      name = "conventional-changelog-codemirror-0.3.8.tgz";
      path = fetchurl {
        name = "conventional-changelog-codemirror-0.3.8.tgz";
        url  = "https://registry.yarnpkg.com/conventional-changelog-codemirror/-/conventional-changelog-codemirror-0.3.8.tgz";
        sha1 = "a1982c8291f4ee4d6f2f62817c6b2ecd2c4b7b47";
      };
    }

    {
      name = "conventional-changelog-core-2.0.11.tgz";
      path = fetchurl {
        name = "conventional-changelog-core-2.0.11.tgz";
        url  = "https://registry.yarnpkg.com/conventional-changelog-core/-/conventional-changelog-core-2.0.11.tgz";
        sha1 = "19b5fbd55a9697773ed6661f4e32030ed7e30287";
      };
    }

    {
      name = "conventional-changelog-ember-0.3.12.tgz";
      path = fetchurl {
        name = "conventional-changelog-ember-0.3.12.tgz";
        url  = "https://registry.yarnpkg.com/conventional-changelog-ember/-/conventional-changelog-ember-0.3.12.tgz";
        sha1 = "b7d31851756d0fcb49b031dffeb6afa93b202400";
      };
    }

    {
      name = "conventional-changelog-eslint-1.0.9.tgz";
      path = fetchurl {
        name = "conventional-changelog-eslint-1.0.9.tgz";
        url  = "https://registry.yarnpkg.com/conventional-changelog-eslint/-/conventional-changelog-eslint-1.0.9.tgz";
        sha1 = "b13cc7e4b472c819450ede031ff1a75c0e3d07d3";
      };
    }

    {
      name = "conventional-changelog-express-0.3.6.tgz";
      path = fetchurl {
        name = "conventional-changelog-express-0.3.6.tgz";
        url  = "https://registry.yarnpkg.com/conventional-changelog-express/-/conventional-changelog-express-0.3.6.tgz";
        sha1 = "4a6295cb11785059fb09202180d0e59c358b9c2c";
      };
    }

    {
      name = "conventional-changelog-jquery-0.1.0.tgz";
      path = fetchurl {
        name = "conventional-changelog-jquery-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/conventional-changelog-jquery/-/conventional-changelog-jquery-0.1.0.tgz";
        sha1 = "0208397162e3846986e71273b6c79c5b5f80f510";
      };
    }

    {
      name = "conventional-changelog-jscs-0.1.0.tgz";
      path = fetchurl {
        name = "conventional-changelog-jscs-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/conventional-changelog-jscs/-/conventional-changelog-jscs-0.1.0.tgz";
        sha1 = "0479eb443cc7d72c58bf0bcf0ef1d444a92f0e5c";
      };
    }

    {
      name = "conventional-changelog-jshint-0.3.8.tgz";
      path = fetchurl {
        name = "conventional-changelog-jshint-0.3.8.tgz";
        url  = "https://registry.yarnpkg.com/conventional-changelog-jshint/-/conventional-changelog-jshint-0.3.8.tgz";
        sha1 = "9051c1ac0767abaf62a31f74d2fe8790e8acc6c8";
      };
    }

    {
      name = "conventional-changelog-preset-loader-1.1.8.tgz";
      path = fetchurl {
        name = "conventional-changelog-preset-loader-1.1.8.tgz";
        url  = "https://registry.yarnpkg.com/conventional-changelog-preset-loader/-/conventional-changelog-preset-loader-1.1.8.tgz";
        sha1 = "40bb0f142cd27d16839ec6c74ee8db418099b373";
      };
    }

    {
      name = "conventional-changelog-writer-3.0.9.tgz";
      path = fetchurl {
        name = "conventional-changelog-writer-3.0.9.tgz";
        url  = "https://registry.yarnpkg.com/conventional-changelog-writer/-/conventional-changelog-writer-3.0.9.tgz";
        sha1 = "4aecdfef33ff2a53bb0cf3b8071ce21f0e994634";
      };
    }

    {
      name = "conventional-changelog-1.1.24.tgz";
      path = fetchurl {
        name = "conventional-changelog-1.1.24.tgz";
        url  = "https://registry.yarnpkg.com/conventional-changelog/-/conventional-changelog-1.1.24.tgz";
        sha1 = "3d94c29c960f5261c002678315b756cdd3d7d1f0";
      };
    }

    {
      name = "conventional-commits-filter-1.1.6.tgz";
      path = fetchurl {
        name = "conventional-commits-filter-1.1.6.tgz";
        url  = "https://registry.yarnpkg.com/conventional-commits-filter/-/conventional-commits-filter-1.1.6.tgz";
        sha1 = "4389cd8e58fe89750c0b5fb58f1d7f0cc8ad3831";
      };
    }

    {
      name = "conventional-commits-parser-2.1.7.tgz";
      path = fetchurl {
        name = "conventional-commits-parser-2.1.7.tgz";
        url  = "https://registry.yarnpkg.com/conventional-commits-parser/-/conventional-commits-parser-2.1.7.tgz";
        sha1 = "eca45ed6140d72ba9722ee4132674d639e644e8e";
      };
    }

    {
      name = "conventional-recommended-bump-1.2.1.tgz";
      path = fetchurl {
        name = "conventional-recommended-bump-1.2.1.tgz";
        url  = "https://registry.yarnpkg.com/conventional-recommended-bump/-/conventional-recommended-bump-1.2.1.tgz";
        sha1 = "1b7137efb5091f99fe009e2fe9ddb7cc490e9375";
      };
    }

    {
      name = "convert-source-map-1.5.1.tgz";
      path = fetchurl {
        name = "convert-source-map-1.5.1.tgz";
        url  = "https://registry.yarnpkg.com/convert-source-map/-/convert-source-map-1.5.1.tgz";
        sha1 = "b8278097b9bc229365de5c62cf5fcaed8b5599e5";
      };
    }

    {
      name = "cookie-parser-1.4.3.tgz";
      path = fetchurl {
        name = "cookie-parser-1.4.3.tgz";
        url  = "https://registry.yarnpkg.com/cookie-parser/-/cookie-parser-1.4.3.tgz";
        sha1 = "0fe31fa19d000b95f4aadf1f53fdc2b8a203baa5";
      };
    }

    {
      name = "cookie-signature-1.0.6.tgz";
      path = fetchurl {
        name = "cookie-signature-1.0.6.tgz";
        url  = "https://registry.yarnpkg.com/cookie-signature/-/cookie-signature-1.0.6.tgz";
        sha1 = "e303a882b342cc3ee8ca513a79999734dab3ae2c";
      };
    }

    {
      name = "cookie-0.3.1.tgz";
      path = fetchurl {
        name = "cookie-0.3.1.tgz";
        url  = "https://registry.yarnpkg.com/cookie/-/cookie-0.3.1.tgz";
        sha1 = "e7e0a1f9ef43b4c8ba925c5c5a96e806d16873bb";
      };
    }

    {
      name = "cookiejar-2.1.2.tgz";
      path = fetchurl {
        name = "cookiejar-2.1.2.tgz";
        url  = "https://registry.yarnpkg.com/cookiejar/-/cookiejar-2.1.2.tgz";
        sha1 = "dd8a235530752f988f9a0844f3fc589e3111125c";
      };
    }

    {
      name = "copy-concurrently-1.0.5.tgz";
      path = fetchurl {
        name = "copy-concurrently-1.0.5.tgz";
        url  = "https://registry.yarnpkg.com/copy-concurrently/-/copy-concurrently-1.0.5.tgz";
        sha1 = "92297398cae34937fcafd6ec8139c18051f0b5e0";
      };
    }

    {
      name = "copy-descriptor-0.1.1.tgz";
      path = fetchurl {
        name = "copy-descriptor-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/copy-descriptor/-/copy-descriptor-0.1.1.tgz";
        sha1 = "676f6eb3c39997c2ee1ac3a924fd6124748f578d";
      };
    }

    {
      name = "copy-webpack-plugin-4.5.2.tgz";
      path = fetchurl {
        name = "copy-webpack-plugin-4.5.2.tgz";
        url  = "https://registry.yarnpkg.com/copy-webpack-plugin/-/copy-webpack-plugin-4.5.2.tgz";
        sha1 = "d53444a8fea2912d806e78937390ddd7e632ee5c";
      };
    }

    {
      name = "core-js-1.2.7.tgz";
      path = fetchurl {
        name = "core-js-1.2.7.tgz";
        url  = "https://registry.yarnpkg.com/core-js/-/core-js-1.2.7.tgz";
        sha1 = "652294c14651db28fa93bd2d5ff2983a4f08c636";
      };
    }

    {
      name = "core-js-2.5.7.tgz";
      path = fetchurl {
        name = "core-js-2.5.7.tgz";
        url  = "https://registry.yarnpkg.com/core-js/-/core-js-2.5.7.tgz";
        sha1 = "f972608ff0cead68b841a16a932d0b183791814e";
      };
    }

    {
      name = "core-util-is-1.0.2.tgz";
      path = fetchurl {
        name = "core-util-is-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/core-util-is/-/core-util-is-1.0.2.tgz";
        sha1 = "b5fd54220aa2bc5ab57aab7140c940754503c1a7";
      };
    }

    {
      name = "cosmiconfig-1.1.0.tgz";
      path = fetchurl {
        name = "cosmiconfig-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/cosmiconfig/-/cosmiconfig-1.1.0.tgz";
        sha1 = "0dea0f9804efdfb929fbb1b188e25553ea053d37";
      };
    }

    {
      name = "cosmiconfig-3.1.0.tgz";
      path = fetchurl {
        name = "cosmiconfig-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/cosmiconfig/-/cosmiconfig-3.1.0.tgz";
        sha1 = "640a94bf9847f321800403cd273af60665c73397";
      };
    }

    {
      name = "cosmiconfig-4.0.0.tgz";
      path = fetchurl {
        name = "cosmiconfig-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/cosmiconfig/-/cosmiconfig-4.0.0.tgz";
        sha1 = "760391549580bbd2df1e562bc177b13c290972dc";
      };
    }

    {
      name = "crc32-stream-2.0.0.tgz";
      path = fetchurl {
        name = "crc32-stream-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/crc32-stream/-/crc32-stream-2.0.0.tgz";
        sha1 = "e3cdd3b4df3168dd74e3de3fbbcb7b297fe908f4";
      };
    }

    {
      name = "crc-3.5.0.tgz";
      path = fetchurl {
        name = "crc-3.5.0.tgz";
        url  = "https://registry.yarnpkg.com/crc/-/crc-3.5.0.tgz";
        sha1 = "98b8ba7d489665ba3979f59b21381374101a1964";
      };
    }

    {
      name = "create-ecdh-4.0.3.tgz";
      path = fetchurl {
        name = "create-ecdh-4.0.3.tgz";
        url  = "https://registry.yarnpkg.com/create-ecdh/-/create-ecdh-4.0.3.tgz";
        sha1 = "c9111b6f33045c4697f144787f9254cdc77c45ff";
      };
    }

    {
      name = "create-error-class-3.0.2.tgz";
      path = fetchurl {
        name = "create-error-class-3.0.2.tgz";
        url  = "https://registry.yarnpkg.com/create-error-class/-/create-error-class-3.0.2.tgz";
        sha1 = "06be7abef947a3f14a30fd610671d401bca8b7b6";
      };
    }

    {
      name = "create-hash-1.2.0.tgz";
      path = fetchurl {
        name = "create-hash-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/create-hash/-/create-hash-1.2.0.tgz";
        sha1 = "889078af11a63756bcfb59bd221996be3a9ef196";
      };
    }

    {
      name = "create-hmac-1.1.7.tgz";
      path = fetchurl {
        name = "create-hmac-1.1.7.tgz";
        url  = "https://registry.yarnpkg.com/create-hmac/-/create-hmac-1.1.7.tgz";
        sha1 = "69170c78b3ab957147b2b8b04572e47ead2243ff";
      };
    }

    {
      name = "create-react-class-15.6.3.tgz";
      path = fetchurl {
        name = "create-react-class-15.6.3.tgz";
        url  = "https://registry.yarnpkg.com/create-react-class/-/create-react-class-15.6.3.tgz";
        sha1 = "2d73237fb3f970ae6ebe011a9e66f46dbca80036";
      };
    }

    {
      name = "create-thenable-1.0.2.tgz";
      path = fetchurl {
        name = "create-thenable-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/create-thenable/-/create-thenable-1.0.2.tgz";
        sha1 = "e2031720ccc9575d8cfa31f5c146e762a80c0534";
      };
    }

    {
      name = "cross-spawn-5.1.0.tgz";
      path = fetchurl {
        name = "cross-spawn-5.1.0.tgz";
        url  = "https://registry.yarnpkg.com/cross-spawn/-/cross-spawn-5.1.0.tgz";
        sha1 = "e8bd0efee58fcff6f8f94510a0a554bbfa235449";
      };
    }

    {
      name = "cross-spawn-3.0.1.tgz";
      path = fetchurl {
        name = "cross-spawn-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/cross-spawn/-/cross-spawn-3.0.1.tgz";
        sha1 = "1256037ecb9f0c5f79e3d6ef135e30770184b982";
      };
    }

    {
      name = "cryptiles-2.0.5.tgz";
      path = fetchurl {
        name = "cryptiles-2.0.5.tgz";
        url  = "https://registry.yarnpkg.com/cryptiles/-/cryptiles-2.0.5.tgz";
        sha1 = "3bdfecdc608147c1c67202fa291e7dca59eaa3b8";
      };
    }

    {
      name = "crypto-browserify-3.12.0.tgz";
      path = fetchurl {
        name = "crypto-browserify-3.12.0.tgz";
        url  = "https://registry.yarnpkg.com/crypto-browserify/-/crypto-browserify-3.12.0.tgz";
        sha1 = "396cf9f3137f03e4b8e532c58f698254e00f80ec";
      };
    }

    {
      name = "crypto-md5-1.0.0.tgz";
      path = fetchurl {
        name = "crypto-md5-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/crypto-md5/-/crypto-md5-1.0.0.tgz";
        sha1 = "ccc8da750c753c7edcbabc542967472a384e86bb";
      };
    }

    {
      name = "css-color-keywords-1.0.0.tgz";
      path = fetchurl {
        name = "css-color-keywords-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/css-color-keywords/-/css-color-keywords-1.0.0.tgz";
        sha1 = "fea2616dc676b2962686b3af8dbdbe180b244e05";
      };
    }

    {
      name = "css-color-names-0.0.4.tgz";
      path = fetchurl {
        name = "css-color-names-0.0.4.tgz";
        url  = "https://registry.yarnpkg.com/css-color-names/-/css-color-names-0.0.4.tgz";
        sha1 = "808adc2e79cf84738069b646cb20ec27beb629e0";
      };
    }

    {
      name = "css-initials-0.2.0.tgz";
      path = fetchurl {
        name = "css-initials-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/css-initials/-/css-initials-0.2.0.tgz";
        sha1 = "14c225bd8656255a6baee07231ef82fa55aacaa3";
      };
    }

    {
      name = "css-loader-0.28.11.tgz";
      path = fetchurl {
        name = "css-loader-0.28.11.tgz";
        url  = "https://registry.yarnpkg.com/css-loader/-/css-loader-0.28.11.tgz";
        sha1 = "c3f9864a700be2711bb5a2462b2389b1a392dab7";
      };
    }

    {
      name = "css-select-1.2.0.tgz";
      path = fetchurl {
        name = "css-select-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/css-select/-/css-select-1.2.0.tgz";
        sha1 = "2b3a110539c5355f1cd8d314623e870b121ec858";
      };
    }

    {
      name = "css-selector-tokenizer-0.7.0.tgz";
      path = fetchurl {
        name = "css-selector-tokenizer-0.7.0.tgz";
        url  = "https://registry.yarnpkg.com/css-selector-tokenizer/-/css-selector-tokenizer-0.7.0.tgz";
        sha1 = "e6988474ae8c953477bf5e7efecfceccd9cf4c86";
      };
    }

    {
      name = "css-to-react-native-2.2.1.tgz";
      path = fetchurl {
        name = "css-to-react-native-2.2.1.tgz";
        url  = "https://registry.yarnpkg.com/css-to-react-native/-/css-to-react-native-2.2.1.tgz";
        sha1 = "7f3f4c95de65501b8720c87bf0caf1f39073b88e";
      };
    }

    {
      name = "css-what-2.1.0.tgz";
      path = fetchurl {
        name = "css-what-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/css-what/-/css-what-2.1.0.tgz";
        sha1 = "9467d032c38cfaefb9f2d79501253062f87fa1bd";
      };
    }

    {
      name = "css-2.2.1.tgz";
      path = fetchurl {
        name = "css-2.2.1.tgz";
        url  = "https://registry.yarnpkg.com/css/-/css-2.2.1.tgz";
        sha1 = "73a4c81de85db664d4ee674f7d47085e3b2d55dc";
      };
    }

    {
      name = "cssesc-0.1.0.tgz";
      path = fetchurl {
        name = "cssesc-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/cssesc/-/cssesc-0.1.0.tgz";
        sha1 = "c814903e45623371a0477b40109aaafbeeaddbb4";
      };
    }

    {
      name = "cssnano-3.10.0.tgz";
      path = fetchurl {
        name = "cssnano-3.10.0.tgz";
        url  = "https://registry.yarnpkg.com/cssnano/-/cssnano-3.10.0.tgz";
        sha1 = "4f38f6cea2b9b17fa01490f23f1dc68ea65c1c38";
      };
    }

    {
      name = "csso-2.3.2.tgz";
      path = fetchurl {
        name = "csso-2.3.2.tgz";
        url  = "https://registry.yarnpkg.com/csso/-/csso-2.3.2.tgz";
        sha1 = "ddd52c587033f49e94b71fc55569f252e8ff5f85";
      };
    }

    {
      name = "cssom-0.3.4.tgz";
      path = fetchurl {
        name = "cssom-0.3.4.tgz";
        url  = "https://registry.yarnpkg.com/cssom/-/cssom-0.3.4.tgz";
        sha1 = "8cd52e8a3acfd68d3aed38ee0a640177d2f9d797";
      };
    }

    {
      name = "cssstyle-0.2.37.tgz";
      path = fetchurl {
        name = "cssstyle-0.2.37.tgz";
        url  = "https://registry.yarnpkg.com/cssstyle/-/cssstyle-0.2.37.tgz";
        sha1 = "541097234cb2513c83ceed3acddc27ff27987d54";
      };
    }

    {
      name = "cssstyle-0.3.1.tgz";
      path = fetchurl {
        name = "cssstyle-0.3.1.tgz";
        url  = "https://registry.yarnpkg.com/cssstyle/-/cssstyle-0.3.1.tgz";
        sha1 = "6da9b4cff1bc5d716e6e5fe8e04fcb1b50a49adf";
      };
    }

    {
      name = "currently-unhandled-0.4.1.tgz";
      path = fetchurl {
        name = "currently-unhandled-0.4.1.tgz";
        url  = "https://registry.yarnpkg.com/currently-unhandled/-/currently-unhandled-0.4.1.tgz";
        sha1 = "988df33feab191ef799a61369dd76c17adf957ea";
      };
    }

    {
      name = "cycle-1.0.3.tgz";
      path = fetchurl {
        name = "cycle-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/cycle/-/cycle-1.0.3.tgz";
        sha1 = "21e80b2be8580f98b468f379430662b046c34ad2";
      };
    }

    {
      name = "cyclist-0.2.2.tgz";
      path = fetchurl {
        name = "cyclist-0.2.2.tgz";
        url  = "https://registry.yarnpkg.com/cyclist/-/cyclist-0.2.2.tgz";
        sha1 = "1b33792e11e914a2fd6d6ed6447464444e5fa640";
      };
    }

    {
      name = "d-1.0.0.tgz";
      path = fetchurl {
        name = "d-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/d/-/d-1.0.0.tgz";
        sha1 = "754bb5bfe55451da69a58b94d45f4c5b0462d58f";
      };
    }

    {
      name = "damerau-levenshtein-1.0.4.tgz";
      path = fetchurl {
        name = "damerau-levenshtein-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/damerau-levenshtein/-/damerau-levenshtein-1.0.4.tgz";
        sha1 = "03191c432cb6eea168bb77f3a55ffdccb8978514";
      };
    }

    {
      name = "dargs-4.1.0.tgz";
      path = fetchurl {
        name = "dargs-4.1.0.tgz";
        url  = "https://registry.yarnpkg.com/dargs/-/dargs-4.1.0.tgz";
        sha1 = "03a9dbb4b5c2f139bf14ae53f0b8a2a6a86f4e17";
      };
    }

    {
      name = "dashdash-1.14.1.tgz";
      path = fetchurl {
        name = "dashdash-1.14.1.tgz";
        url  = "https://registry.yarnpkg.com/dashdash/-/dashdash-1.14.1.tgz";
        sha1 = "853cfa0f7cbe2fed5de20326b8dd581035f6e2f0";
      };
    }

    {
      name = "dasherize-2.0.0.tgz";
      path = fetchurl {
        name = "dasherize-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/dasherize/-/dasherize-2.0.0.tgz";
        sha1 = "6d809c9cd0cf7bb8952d80fc84fa13d47ddb1308";
      };
    }

    {
      name = "data-urls-1.0.0.tgz";
      path = fetchurl {
        name = "data-urls-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/data-urls/-/data-urls-1.0.0.tgz";
        sha1 = "24802de4e81c298ea8a9388bb0d8e461c774684f";
      };
    }

    {
      name = "date-fns-1.29.0.tgz";
      path = fetchurl {
        name = "date-fns-1.29.0.tgz";
        url  = "https://registry.yarnpkg.com/date-fns/-/date-fns-1.29.0.tgz";
        sha1 = "12e609cdcb935127311d04d33334e2960a2a54e6";
      };
    }

    {
      name = "date-now-0.1.4.tgz";
      path = fetchurl {
        name = "date-now-0.1.4.tgz";
        url  = "https://registry.yarnpkg.com/date-now/-/date-now-0.1.4.tgz";
        sha1 = "eaf439fd4d4848ad74e5cc7dbef200672b9e345b";
      };
    }

    {
      name = "dateformat-3.0.3.tgz";
      path = fetchurl {
        name = "dateformat-3.0.3.tgz";
        url  = "https://registry.yarnpkg.com/dateformat/-/dateformat-3.0.3.tgz";
        sha1 = "a6e37499a4d9a9cf85ef5872044d62901c9889ae";
      };
    }

    {
      name = "debug-log-1.0.1.tgz";
      path = fetchurl {
        name = "debug-log-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/debug-log/-/debug-log-1.0.1.tgz";
        sha1 = "2307632d4c04382b8df8a32f70b895046d52745f";
      };
    }

    {
      name = "debug-2.6.9.tgz";
      path = fetchurl {
        name = "debug-2.6.9.tgz";
        url  = "https://registry.yarnpkg.com/debug/-/debug-2.6.9.tgz";
        sha1 = "5d128515df134ff327e90a4c93f4e077a536341f";
      };
    }

    {
      name = "debug-3.1.0.tgz";
      path = fetchurl {
        name = "debug-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/debug/-/debug-3.1.0.tgz";
        sha1 = "5bb5a0672628b64149566ba16819e61518c67261";
      };
    }

    {
      name = "decamelize-keys-1.1.0.tgz";
      path = fetchurl {
        name = "decamelize-keys-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/decamelize-keys/-/decamelize-keys-1.1.0.tgz";
        sha1 = "d171a87933252807eb3cb61dc1c1445d078df2d9";
      };
    }

    {
      name = "decamelize-1.2.0.tgz";
      path = fetchurl {
        name = "decamelize-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/decamelize/-/decamelize-1.2.0.tgz";
        sha1 = "f6534d15148269b20352e7bee26f501f9a191290";
      };
    }

    {
      name = "decode-uri-component-0.2.0.tgz";
      path = fetchurl {
        name = "decode-uri-component-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/decode-uri-component/-/decode-uri-component-0.2.0.tgz";
        sha1 = "eb3913333458775cb84cd1a1fae062106bb87545";
      };
    }

    {
      name = "dedent-0.4.0.tgz";
      path = fetchurl {
        name = "dedent-0.4.0.tgz";
        url  = "https://registry.yarnpkg.com/dedent/-/dedent-0.4.0.tgz";
        sha1 = "87defd040bd4c1595d963282ec57f3c2a8525642";
      };
    }

    {
      name = "dedent-0.6.0.tgz";
      path = fetchurl {
        name = "dedent-0.6.0.tgz";
        url  = "https://registry.yarnpkg.com/dedent/-/dedent-0.6.0.tgz";
        sha1 = "0e6da8f0ce52838ef5cec5c8f9396b0c1b64a3cb";
      };
    }

    {
      name = "dedent-0.7.0.tgz";
      path = fetchurl {
        name = "dedent-0.7.0.tgz";
        url  = "https://registry.yarnpkg.com/dedent/-/dedent-0.7.0.tgz";
        sha1 = "2495ddbaf6eb874abb0e1be9df22d2e5a544326c";
      };
    }

    {
      name = "deep-diff-0.3.8.tgz";
      path = fetchurl {
        name = "deep-diff-0.3.8.tgz";
        url  = "https://registry.yarnpkg.com/deep-diff/-/deep-diff-0.3.8.tgz";
        sha1 = "c01de63efb0eec9798801d40c7e0dae25b582c84";
      };
    }

    {
      name = "deep-eql-0.1.3.tgz";
      path = fetchurl {
        name = "deep-eql-0.1.3.tgz";
        url  = "https://registry.yarnpkg.com/deep-eql/-/deep-eql-0.1.3.tgz";
        sha1 = "ef558acab8de25206cd713906d74e56930eb69f2";
      };
    }

    {
      name = "deep-equal-1.0.1.tgz";
      path = fetchurl {
        name = "deep-equal-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/deep-equal/-/deep-equal-1.0.1.tgz";
        sha1 = "f5d260292b660e084eff4cdbc9f08ad3247448b5";
      };
    }

    {
      name = "deep-equal-0.2.2.tgz";
      path = fetchurl {
        name = "deep-equal-0.2.2.tgz";
        url  = "https://registry.yarnpkg.com/deep-equal/-/deep-equal-0.2.2.tgz";
        sha1 = "84b745896f34c684e98f2ce0e42abaf43bba017d";
      };
    }

    {
      name = "deep-extend-0.6.0.tgz";
      path = fetchurl {
        name = "deep-extend-0.6.0.tgz";
        url  = "https://registry.yarnpkg.com/deep-extend/-/deep-extend-0.6.0.tgz";
        sha1 = "c4fa7c95404a17a9c3e8ca7e1537312b736330ac";
      };
    }

    {
      name = "deep-is-0.1.3.tgz";
      path = fetchurl {
        name = "deep-is-0.1.3.tgz";
        url  = "https://registry.yarnpkg.com/deep-is/-/deep-is-0.1.3.tgz";
        sha1 = "b369d6fb5dbc13eecf524f91b070feedc357cf34";
      };
    }

    {
      name = "default-require-extensions-2.0.0.tgz";
      path = fetchurl {
        name = "default-require-extensions-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/default-require-extensions/-/default-require-extensions-2.0.0.tgz";
        sha1 = "f5f8fbb18a7d6d50b21f641f649ebb522cfe24f7";
      };
    }

    {
      name = "defaults-1.0.3.tgz";
      path = fetchurl {
        name = "defaults-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/defaults/-/defaults-1.0.3.tgz";
        sha1 = "c656051e9817d9ff08ed881477f3fe4019f3ef7d";
      };
    }

    {
      name = "deferred-leveldown-2.0.3.tgz";
      path = fetchurl {
        name = "deferred-leveldown-2.0.3.tgz";
        url  = "https://registry.yarnpkg.com/deferred-leveldown/-/deferred-leveldown-2.0.3.tgz";
        sha1 = "91fbc7699ac85f3920df035792d96d97cbf50c0f";
      };
    }

    {
      name = "define-properties-1.1.2.tgz";
      path = fetchurl {
        name = "define-properties-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/define-properties/-/define-properties-1.1.2.tgz";
        sha1 = "83a73f2fea569898fb737193c8f873caf6d45c94";
      };
    }

    {
      name = "define-property-0.2.5.tgz";
      path = fetchurl {
        name = "define-property-0.2.5.tgz";
        url  = "https://registry.yarnpkg.com/define-property/-/define-property-0.2.5.tgz";
        sha1 = "c35b1ef918ec3c990f9a5bc57be04aacec5c8116";
      };
    }

    {
      name = "define-property-1.0.0.tgz";
      path = fetchurl {
        name = "define-property-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/define-property/-/define-property-1.0.0.tgz";
        sha1 = "769ebaaf3f4a63aad3af9e8d304c9bbe79bfb0e6";
      };
    }

    {
      name = "define-property-2.0.2.tgz";
      path = fetchurl {
        name = "define-property-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/define-property/-/define-property-2.0.2.tgz";
        sha1 = "d459689e8d654ba77e02a817f8710d702cb16e9d";
      };
    }

    {
      name = "defined-1.0.0.tgz";
      path = fetchurl {
        name = "defined-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/defined/-/defined-1.0.0.tgz";
        sha1 = "c98d9bcef75674188e110969151199e39b1fa693";
      };
    }

    {
      name = "deglob-2.1.1.tgz";
      path = fetchurl {
        name = "deglob-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/deglob/-/deglob-2.1.1.tgz";
        sha1 = "d268e168727799862e8eac07042e165957c1f3be";
      };
    }

    {
      name = "del-2.2.2.tgz";
      path = fetchurl {
        name = "del-2.2.2.tgz";
        url  = "https://registry.yarnpkg.com/del/-/del-2.2.2.tgz";
        sha1 = "c12c981d067846c84bcaf862cff930d907ffd1a8";
      };
    }

    {
      name = "del-3.0.0.tgz";
      path = fetchurl {
        name = "del-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/del/-/del-3.0.0.tgz";
        sha1 = "53ecf699ffcbcb39637691ab13baf160819766e5";
      };
    }

    {
      name = "delayed-stream-1.0.0.tgz";
      path = fetchurl {
        name = "delayed-stream-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/delayed-stream/-/delayed-stream-1.0.0.tgz";
        sha1 = "df3ae199acadfb7d440aaae0b29e2272b24ec619";
      };
    }

    {
      name = "delegates-1.0.0.tgz";
      path = fetchurl {
        name = "delegates-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/delegates/-/delegates-1.0.0.tgz";
        sha1 = "84c6e159b81904fdca59a0ef44cd870d31250f9a";
      };
    }

    {
      name = "depd-1.1.1.tgz";
      path = fetchurl {
        name = "depd-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/depd/-/depd-1.1.1.tgz";
        sha1 = "5783b4e1c459f06fa5ca27f991f3d06e7a310359";
      };
    }

    {
      name = "depd-1.1.2.tgz";
      path = fetchurl {
        name = "depd-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/depd/-/depd-1.1.2.tgz";
        sha1 = "9bcd52e14c097763e749b274c4346ed2e560b5a9";
      };
    }

    {
      name = "deprecated-decorator-0.1.6.tgz";
      path = fetchurl {
        name = "deprecated-decorator-0.1.6.tgz";
        url  = "https://registry.yarnpkg.com/deprecated-decorator/-/deprecated-decorator-0.1.6.tgz";
        sha1 = "00966317b7a12fe92f3cc831f7583af329b86c37";
      };
    }

    {
      name = "des.js-1.0.0.tgz";
      path = fetchurl {
        name = "des.js-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/des.js/-/des.js-1.0.0.tgz";
        sha1 = "c074d2e2aa6a8a9a07dbd61f9a15c2cd83ec8ecc";
      };
    }

    {
      name = "destroy-1.0.4.tgz";
      path = fetchurl {
        name = "destroy-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/destroy/-/destroy-1.0.4.tgz";
        sha1 = "978857442c44749e4206613e37946205826abd80";
      };
    }

    {
      name = "detect-indent-4.0.0.tgz";
      path = fetchurl {
        name = "detect-indent-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/detect-indent/-/detect-indent-4.0.0.tgz";
        sha1 = "f76d064352cdf43a1cb6ce619c4ee3a9475de208";
      };
    }

    {
      name = "detect-indent-5.0.0.tgz";
      path = fetchurl {
        name = "detect-indent-5.0.0.tgz";
        url  = "https://registry.yarnpkg.com/detect-indent/-/detect-indent-5.0.0.tgz";
        sha1 = "3871cc0a6a002e8c3e5b3cf7f336264675f06b9d";
      };
    }

    {
      name = "detect-libc-1.0.3.tgz";
      path = fetchurl {
        name = "detect-libc-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/detect-libc/-/detect-libc-1.0.3.tgz";
        sha1 = "fa137c4bd698edf55cd5cd02ac559f91a4c4ba9b";
      };
    }

    {
      name = "detect-newline-2.1.0.tgz";
      path = fetchurl {
        name = "detect-newline-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/detect-newline/-/detect-newline-2.1.0.tgz";
        sha1 = "f41f1c10be4b00e87b5f13da680759f2c5bfd3e2";
      };
    }

    {
      name = "detect-node-2.0.3.tgz";
      path = fetchurl {
        name = "detect-node-2.0.3.tgz";
        url  = "https://registry.yarnpkg.com/detect-node/-/detect-node-2.0.3.tgz";
        sha1 = "a2033c09cc8e158d37748fbde7507832bd6ce127";
      };
    }

    {
      name = "detect-port-alt-1.1.6.tgz";
      path = fetchurl {
        name = "detect-port-alt-1.1.6.tgz";
        url  = "https://registry.yarnpkg.com/detect-port-alt/-/detect-port-alt-1.1.6.tgz";
        sha1 = "24707deabe932d4a3cf621302027c2b266568275";
      };
    }

    {
      name = "dicer-0.2.5.tgz";
      path = fetchurl {
        name = "dicer-0.2.5.tgz";
        url  = "https://registry.yarnpkg.com/dicer/-/dicer-0.2.5.tgz";
        sha1 = "5996c086bb33218c812c090bddc09cd12facb70f";
      };
    }

    {
      name = "diff-3.5.0.tgz";
      path = fetchurl {
        name = "diff-3.5.0.tgz";
        url  = "https://registry.yarnpkg.com/diff/-/diff-3.5.0.tgz";
        sha1 = "800c0dd1e0a8bfbc95835c202ad220fe317e5a12";
      };
    }

    {
      name = "diffie-hellman-5.0.3.tgz";
      path = fetchurl {
        name = "diffie-hellman-5.0.3.tgz";
        url  = "https://registry.yarnpkg.com/diffie-hellman/-/diffie-hellman-5.0.3.tgz";
        sha1 = "40e8ee98f55a2149607146921c63e1ae5f3d2875";
      };
    }

    {
      name = "dir-glob-2.0.0.tgz";
      path = fetchurl {
        name = "dir-glob-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/dir-glob/-/dir-glob-2.0.0.tgz";
        sha1 = "0b205d2b6aef98238ca286598a8204d29d0a0034";
      };
    }

    {
      name = "discontinuous-range-1.0.0.tgz";
      path = fetchurl {
        name = "discontinuous-range-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/discontinuous-range/-/discontinuous-range-1.0.0.tgz";
        sha1 = "e38331f0844bba49b9a9cb71c771585aab1bc65a";
      };
    }

    {
      name = "disposables-1.0.2.tgz";
      path = fetchurl {
        name = "disposables-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/disposables/-/disposables-1.0.2.tgz";
        sha1 = "36c6a674475f55a2d6913567a601444e487b4b6e";
      };
    }

    {
      name = "dmd-3.0.12.tgz";
      path = fetchurl {
        name = "dmd-3.0.12.tgz";
        url  = "https://registry.yarnpkg.com/dmd/-/dmd-3.0.12.tgz";
        sha1 = "2aad884cd582287f7dc748435017c7dbd510fe0c";
      };
    }

    {
      name = "dnd-core-2.6.0.tgz";
      path = fetchurl {
        name = "dnd-core-2.6.0.tgz";
        url  = "https://registry.yarnpkg.com/dnd-core/-/dnd-core-2.6.0.tgz";
        sha1 = "12bad66d58742c6e5f7cf2943fb6859440f809c4";
      };
    }

    {
      name = "dns-equal-1.0.0.tgz";
      path = fetchurl {
        name = "dns-equal-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/dns-equal/-/dns-equal-1.0.0.tgz";
        sha1 = "b39e7f1da6eb0a75ba9c17324b34753c47e0654d";
      };
    }

    {
      name = "dns-packet-1.3.1.tgz";
      path = fetchurl {
        name = "dns-packet-1.3.1.tgz";
        url  = "https://registry.yarnpkg.com/dns-packet/-/dns-packet-1.3.1.tgz";
        sha1 = "12aa426981075be500b910eedcd0b47dd7deda5a";
      };
    }

    {
      name = "dns-prefetch-control-0.1.0.tgz";
      path = fetchurl {
        name = "dns-prefetch-control-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/dns-prefetch-control/-/dns-prefetch-control-0.1.0.tgz";
        sha1 = "60ddb457774e178f1f9415f0cabb0e85b0b300b2";
      };
    }

    {
      name = "dns-txt-2.0.2.tgz";
      path = fetchurl {
        name = "dns-txt-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/dns-txt/-/dns-txt-2.0.2.tgz";
        sha1 = "b91d806f5d27188e4ab3e7d107d881a1cc4642b6";
      };
    }

    {
      name = "doctrine-1.5.0.tgz";
      path = fetchurl {
        name = "doctrine-1.5.0.tgz";
        url  = "https://registry.yarnpkg.com/doctrine/-/doctrine-1.5.0.tgz";
        sha1 = "379dce730f6166f76cefa4e6707a159b02c5a6fa";
      };
    }

    {
      name = "doctrine-2.1.0.tgz";
      path = fetchurl {
        name = "doctrine-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/doctrine/-/doctrine-2.1.0.tgz";
        sha1 = "5cd01fc101621b42c4cd7f5d1a66243716d3f39d";
      };
    }

    {
      name = "dom-converter-0.1.4.tgz";
      path = fetchurl {
        name = "dom-converter-0.1.4.tgz";
        url  = "https://registry.yarnpkg.com/dom-converter/-/dom-converter-0.1.4.tgz";
        sha1 = "a45ef5727b890c9bffe6d7c876e7b19cb0e17f3b";
      };
    }

    {
      name = "dom-helpers-3.3.1.tgz";
      path = fetchurl {
        name = "dom-helpers-3.3.1.tgz";
        url  = "https://registry.yarnpkg.com/dom-helpers/-/dom-helpers-3.3.1.tgz";
        sha1 = "fc1a4e15ffdf60ddde03a480a9c0fece821dd4a6";
      };
    }

    {
      name = "dom-serializer-0.1.0.tgz";
      path = fetchurl {
        name = "dom-serializer-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/dom-serializer/-/dom-serializer-0.1.0.tgz";
        sha1 = "073c697546ce0780ce23be4a28e293e40bc30c82";
      };
    }

    {
      name = "dom-walk-0.1.1.tgz";
      path = fetchurl {
        name = "dom-walk-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/dom-walk/-/dom-walk-0.1.1.tgz";
        sha1 = "672226dc74c8f799ad35307df936aba11acd6018";
      };
    }

    {
      name = "domain-browser-1.2.0.tgz";
      path = fetchurl {
        name = "domain-browser-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/domain-browser/-/domain-browser-1.2.0.tgz";
        sha1 = "3d31f50191a6749dd1375a7f522e823d42e54eda";
      };
    }

    {
      name = "domelementtype-1.3.0.tgz";
      path = fetchurl {
        name = "domelementtype-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/domelementtype/-/domelementtype-1.3.0.tgz";
        sha1 = "b17aed82e8ab59e52dd9c19b1756e0fc187204c2";
      };
    }

    {
      name = "domelementtype-1.1.3.tgz";
      path = fetchurl {
        name = "domelementtype-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/domelementtype/-/domelementtype-1.1.3.tgz";
        sha1 = "bd28773e2642881aec51544924299c5cd822185b";
      };
    }

    {
      name = "domexception-1.0.1.tgz";
      path = fetchurl {
        name = "domexception-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/domexception/-/domexception-1.0.1.tgz";
        sha1 = "937442644ca6a31261ef36e3ec677fe805582c90";
      };
    }

    {
      name = "domhandler-2.1.0.tgz";
      path = fetchurl {
        name = "domhandler-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/domhandler/-/domhandler-2.1.0.tgz";
        sha1 = "d2646f5e57f6c3bab11cf6cb05d3c0acf7412594";
      };
    }

    {
      name = "domhandler-2.4.2.tgz";
      path = fetchurl {
        name = "domhandler-2.4.2.tgz";
        url  = "https://registry.yarnpkg.com/domhandler/-/domhandler-2.4.2.tgz";
        sha1 = "8805097e933d65e85546f726d60f5eb88b44f803";
      };
    }

    {
      name = "domutils-1.1.6.tgz";
      path = fetchurl {
        name = "domutils-1.1.6.tgz";
        url  = "https://registry.yarnpkg.com/domutils/-/domutils-1.1.6.tgz";
        sha1 = "bddc3de099b9a2efacc51c623f28f416ecc57485";
      };
    }

    {
      name = "domutils-1.5.1.tgz";
      path = fetchurl {
        name = "domutils-1.5.1.tgz";
        url  = "https://registry.yarnpkg.com/domutils/-/domutils-1.5.1.tgz";
        sha1 = "dcd8488a26f563d61079e48c9f7b7e32373682cf";
      };
    }

    {
      name = "domutils-1.7.0.tgz";
      path = fetchurl {
        name = "domutils-1.7.0.tgz";
        url  = "https://registry.yarnpkg.com/domutils/-/domutils-1.7.0.tgz";
        sha1 = "56ea341e834e06e6748af7a1cb25da67ea9f8c2a";
      };
    }

    {
      name = "dont-sniff-mimetype-1.0.0.tgz";
      path = fetchurl {
        name = "dont-sniff-mimetype-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/dont-sniff-mimetype/-/dont-sniff-mimetype-1.0.0.tgz";
        sha1 = "5932890dc9f4e2f19e5eb02a20026e5e5efc8f58";
      };
    }

    {
      name = "dot-prop-3.0.0.tgz";
      path = fetchurl {
        name = "dot-prop-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/dot-prop/-/dot-prop-3.0.0.tgz";
        sha1 = "1b708af094a49c9a0e7dbcad790aba539dac1177";
      };
    }

    {
      name = "dot-prop-4.2.0.tgz";
      path = fetchurl {
        name = "dot-prop-4.2.0.tgz";
        url  = "https://registry.yarnpkg.com/dot-prop/-/dot-prop-4.2.0.tgz";
        sha1 = "1f19e0c2e1aa0e32797c49799f2837ac6af69c57";
      };
    }

    {
      name = "dotenv-4.0.0.tgz";
      path = fetchurl {
        name = "dotenv-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/dotenv/-/dotenv-4.0.0.tgz";
        sha1 = "864ef1379aced55ce6f95debecdce179f7a0cd1d";
      };
    }

    {
      name = "double-ended-queue-2.1.0-0.tgz";
      path = fetchurl {
        name = "double-ended-queue-2.1.0-0.tgz";
        url  = "https://registry.yarnpkg.com/double-ended-queue/-/double-ended-queue-2.1.0-0.tgz";
        sha1 = "103d3527fd31528f40188130c841efdd78264e5c";
      };
    }

    {
      name = "duplexer2-0.1.4.tgz";
      path = fetchurl {
        name = "duplexer2-0.1.4.tgz";
        url  = "https://registry.yarnpkg.com/duplexer2/-/duplexer2-0.1.4.tgz";
        sha1 = "8b12dab878c0d69e3e7891051662a32fc6bddcc1";
      };
    }

    {
      name = "duplexer3-0.1.4.tgz";
      path = fetchurl {
        name = "duplexer3-0.1.4.tgz";
        url  = "https://registry.yarnpkg.com/duplexer3/-/duplexer3-0.1.4.tgz";
        sha1 = "ee01dd1cac0ed3cbc7fdbea37dc0a8f1ce002ce2";
      };
    }

    {
      name = "duplexer-0.1.1.tgz";
      path = fetchurl {
        name = "duplexer-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/duplexer/-/duplexer-0.1.1.tgz";
        sha1 = "ace6ff808c1ce66b57d1ebf97977acb02334cfc1";
      };
    }

    {
      name = "duplexify-3.6.0.tgz";
      path = fetchurl {
        name = "duplexify-3.6.0.tgz";
        url  = "https://registry.yarnpkg.com/duplexify/-/duplexify-3.6.0.tgz";
        sha1 = "592903f5d80b38d037220541264d69a198fb3410";
      };
    }

    {
      name = "ecc-jsbn-0.1.1.tgz";
      path = fetchurl {
        name = "ecc-jsbn-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/ecc-jsbn/-/ecc-jsbn-0.1.1.tgz";
        sha1 = "0fc73a9ed5f0d53c38193398523ef7e543777505";
      };
    }

    {
      name = "ecdsa-sig-formatter-1.0.10.tgz";
      path = fetchurl {
        name = "ecdsa-sig-formatter-1.0.10.tgz";
        url  = "https://registry.yarnpkg.com/ecdsa-sig-formatter/-/ecdsa-sig-formatter-1.0.10.tgz";
        sha1 = "1c595000f04a8897dfb85000892a0f4c33af86c3";
      };
    }

    {
      name = "ee-first-1.1.1.tgz";
      path = fetchurl {
        name = "ee-first-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/ee-first/-/ee-first-1.1.1.tgz";
        sha1 = "590c61156b0ae2f4f0255732a158b266bc56b21d";
      };
    }

    {
      name = "electron-to-chromium-1.3.52.tgz";
      path = fetchurl {
        name = "electron-to-chromium-1.3.52.tgz";
        url  = "https://registry.yarnpkg.com/electron-to-chromium/-/electron-to-chromium-1.3.52.tgz";
        sha1 = "d2d9f1270ba4a3b967b831c40ef71fb4d9ab5ce0";
      };
    }

    {
      name = "elegant-spinner-1.0.1.tgz";
      path = fetchurl {
        name = "elegant-spinner-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/elegant-spinner/-/elegant-spinner-1.0.1.tgz";
        sha1 = "db043521c95d7e303fd8f345bedc3349cfb0729e";
      };
    }

    {
      name = "elliptic-6.4.0.tgz";
      path = fetchurl {
        name = "elliptic-6.4.0.tgz";
        url  = "https://registry.yarnpkg.com/elliptic/-/elliptic-6.4.0.tgz";
        sha1 = "cac9af8762c85836187003c8dfe193e5e2eae5df";
      };
    }

    {
      name = "emoji-regex-6.1.1.tgz";
      path = fetchurl {
        name = "emoji-regex-6.1.1.tgz";
        url  = "https://registry.yarnpkg.com/emoji-regex/-/emoji-regex-6.1.1.tgz";
        sha1 = "c6cd0ec1b0642e2a3c67a1137efc5e796da4f88e";
      };
    }

    {
      name = "emoji-regex-6.5.1.tgz";
      path = fetchurl {
        name = "emoji-regex-6.5.1.tgz";
        url  = "https://registry.yarnpkg.com/emoji-regex/-/emoji-regex-6.5.1.tgz";
        sha1 = "9baea929b155565c11ea41c6626eaa65cef992c2";
      };
    }

    {
      name = "emojis-list-2.1.0.tgz";
      path = fetchurl {
        name = "emojis-list-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/emojis-list/-/emojis-list-2.1.0.tgz";
        sha1 = "4daa4d9db00f9819880c79fa457ae5b09a1fd389";
      };
    }

    {
      name = "encodeurl-1.0.2.tgz";
      path = fetchurl {
        name = "encodeurl-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/encodeurl/-/encodeurl-1.0.2.tgz";
        sha1 = "ad3ff4c86ec2d029322f5a02c3a9a606c95b3f59";
      };
    }

    {
      name = "encoding-0.1.12.tgz";
      path = fetchurl {
        name = "encoding-0.1.12.tgz";
        url  = "https://registry.yarnpkg.com/encoding/-/encoding-0.1.12.tgz";
        sha1 = "538b66f3ee62cd1ab51ec323829d1f9480c74beb";
      };
    }

    {
      name = "end-of-stream-1.4.1.tgz";
      path = fetchurl {
        name = "end-of-stream-1.4.1.tgz";
        url  = "https://registry.yarnpkg.com/end-of-stream/-/end-of-stream-1.4.1.tgz";
        sha1 = "ed29634d19baba463b6ce6b80a37213eab71ec43";
      };
    }

    {
      name = "endpoint-utils-1.0.2.tgz";
      path = fetchurl {
        name = "endpoint-utils-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/endpoint-utils/-/endpoint-utils-1.0.2.tgz";
        sha1 = "0808c3369a727cd7967a39ff34ebc926b88146a8";
      };
    }

    {
      name = "enhanced-resolve-3.4.1.tgz";
      path = fetchurl {
        name = "enhanced-resolve-3.4.1.tgz";
        url  = "https://registry.yarnpkg.com/enhanced-resolve/-/enhanced-resolve-3.4.1.tgz";
        sha1 = "0421e339fd71419b3da13d129b3979040230476e";
      };
    }

    {
      name = "entities-1.1.1.tgz";
      path = fetchurl {
        name = "entities-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/entities/-/entities-1.1.1.tgz";
        sha1 = "6e5c2d0a5621b5dadaecef80b90edfb5cd7772f0";
      };
    }

    {
      name = "enzyme-adapter-react-16-1.1.1.tgz";
      path = fetchurl {
        name = "enzyme-adapter-react-16-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/enzyme-adapter-react-16/-/enzyme-adapter-react-16-1.1.1.tgz";
        sha1 = "a8f4278b47e082fbca14f5bfb1ee50ee650717b4";
      };
    }

    {
      name = "enzyme-adapter-utils-1.4.0.tgz";
      path = fetchurl {
        name = "enzyme-adapter-utils-1.4.0.tgz";
        url  = "https://registry.yarnpkg.com/enzyme-adapter-utils/-/enzyme-adapter-utils-1.4.0.tgz";
        sha1 = "c403b81e8eb9953658569e539780964bdc98de62";
      };
    }

    {
      name = "enzyme-to-json-1.6.0.tgz";
      path = fetchurl {
        name = "enzyme-to-json-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/enzyme-to-json/-/enzyme-to-json-1.6.0.tgz";
        sha1 = "9d9bba706e8b500c673b7a4fa9ff7ce57b8b9254";
      };
    }

    {
      name = "enzyme-2.9.1.tgz";
      path = fetchurl {
        name = "enzyme-2.9.1.tgz";
        url  = "https://registry.yarnpkg.com/enzyme/-/enzyme-2.9.1.tgz";
        sha1 = "07d5ce691241240fb817bf2c4b18d6e530240df6";
      };
    }

    {
      name = "enzyme-3.3.0.tgz";
      path = fetchurl {
        name = "enzyme-3.3.0.tgz";
        url  = "https://registry.yarnpkg.com/enzyme/-/enzyme-3.3.0.tgz";
        sha1 = "0971abd167f2d4bf3f5bd508229e1c4b6dc50479";
      };
    }

    {
      name = "errno-0.1.7.tgz";
      path = fetchurl {
        name = "errno-0.1.7.tgz";
        url  = "https://registry.yarnpkg.com/errno/-/errno-0.1.7.tgz";
        sha1 = "4684d71779ad39af177e3f007996f7c67c852618";
      };
    }

    {
      name = "error-ex-1.3.2.tgz";
      path = fetchurl {
        name = "error-ex-1.3.2.tgz";
        url  = "https://registry.yarnpkg.com/error-ex/-/error-ex-1.3.2.tgz";
        sha1 = "b4ac40648107fdcdcfae242f428bea8a14d4f1bf";
      };
    }

    {
      name = "error-stack-parser-1.3.6.tgz";
      path = fetchurl {
        name = "error-stack-parser-1.3.6.tgz";
        url  = "https://registry.yarnpkg.com/error-stack-parser/-/error-stack-parser-1.3.6.tgz";
        sha1 = "e0e73b93e417138d1cd7c0b746b1a4a14854c292";
      };
    }

    {
      name = "es-abstract-1.12.0.tgz";
      path = fetchurl {
        name = "es-abstract-1.12.0.tgz";
        url  = "https://registry.yarnpkg.com/es-abstract/-/es-abstract-1.12.0.tgz";
        sha1 = "9dbbdd27c6856f0001421ca18782d786bf8a6165";
      };
    }

    {
      name = "es-to-primitive-1.1.1.tgz";
      path = fetchurl {
        name = "es-to-primitive-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/es-to-primitive/-/es-to-primitive-1.1.1.tgz";
        sha1 = "45355248a88979034b6792e19bb81f2b7975dd0d";
      };
    }

    {
      name = "es5-ext-0.10.45.tgz";
      path = fetchurl {
        name = "es5-ext-0.10.45.tgz";
        url  = "https://registry.yarnpkg.com/es5-ext/-/es5-ext-0.10.45.tgz";
        sha1 = "0bfdf7b473da5919d5adf3bd25ceb754fccc3653";
      };
    }

    {
      name = "es6-error-4.1.1.tgz";
      path = fetchurl {
        name = "es6-error-4.1.1.tgz";
        url  = "https://registry.yarnpkg.com/es6-error/-/es6-error-4.1.1.tgz";
        sha1 = "9e3af407459deed47e9a91f9b885a84eb05c561d";
      };
    }

    {
      name = "es6-iterator-2.0.3.tgz";
      path = fetchurl {
        name = "es6-iterator-2.0.3.tgz";
        url  = "https://registry.yarnpkg.com/es6-iterator/-/es6-iterator-2.0.3.tgz";
        sha1 = "a7de889141a05a94b0854403b2d0a0fbfa98f3b7";
      };
    }

    {
      name = "es6-map-0.1.5.tgz";
      path = fetchurl {
        name = "es6-map-0.1.5.tgz";
        url  = "https://registry.yarnpkg.com/es6-map/-/es6-map-0.1.5.tgz";
        sha1 = "9136e0503dcc06a301690f0bb14ff4e364e949f0";
      };
    }

    {
      name = "es6-object-assign-1.1.0.tgz";
      path = fetchurl {
        name = "es6-object-assign-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/es6-object-assign/-/es6-object-assign-1.1.0.tgz";
        sha1 = "c2c3582656247c39ea107cb1e6652b6f9f24523c";
      };
    }

    {
      name = "es6-promise-4.2.4.tgz";
      path = fetchurl {
        name = "es6-promise-4.2.4.tgz";
        url  = "https://registry.yarnpkg.com/es6-promise/-/es6-promise-4.2.4.tgz";
        sha1 = "dc4221c2b16518760bd8c39a52d8f356fc00ed29";
      };
    }

    {
      name = "es6-set-0.1.5.tgz";
      path = fetchurl {
        name = "es6-set-0.1.5.tgz";
        url  = "https://registry.yarnpkg.com/es6-set/-/es6-set-0.1.5.tgz";
        sha1 = "d2b3ec5d4d800ced818db538d28974db0a73ccb1";
      };
    }

    {
      name = "es6-symbol-3.1.1.tgz";
      path = fetchurl {
        name = "es6-symbol-3.1.1.tgz";
        url  = "https://registry.yarnpkg.com/es6-symbol/-/es6-symbol-3.1.1.tgz";
        sha1 = "bf00ef4fdab6ba1b46ecb7b629b4c7ed5715cc77";
      };
    }

    {
      name = "es6-weak-map-2.0.2.tgz";
      path = fetchurl {
        name = "es6-weak-map-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/es6-weak-map/-/es6-weak-map-2.0.2.tgz";
        sha1 = "5e3ab32251ffd1538a1f8e5ffa1357772f92d96f";
      };
    }

    {
      name = "escape-html-1.0.3.tgz";
      path = fetchurl {
        name = "escape-html-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/escape-html/-/escape-html-1.0.3.tgz";
        sha1 = "0258eae4d3d0c0974de1c169188ef0051d1d1988";
      };
    }

    {
      name = "escape-string-regexp-1.0.5.tgz";
      path = fetchurl {
        name = "escape-string-regexp-1.0.5.tgz";
        url  = "https://registry.yarnpkg.com/escape-string-regexp/-/escape-string-regexp-1.0.5.tgz";
        sha1 = "1b61c0562190a8dff6ae3bb2cf0200ca130b86d4";
      };
    }

    {
      name = "escodegen-1.10.0.tgz";
      path = fetchurl {
        name = "escodegen-1.10.0.tgz";
        url  = "https://registry.yarnpkg.com/escodegen/-/escodegen-1.10.0.tgz";
        sha1 = "f647395de22519fbd0d928ffcf1d17e0dec2603e";
      };
    }

    {
      name = "escope-3.6.0.tgz";
      path = fetchurl {
        name = "escope-3.6.0.tgz";
        url  = "https://registry.yarnpkg.com/escope/-/escope-3.6.0.tgz";
        sha1 = "e01975e812781a163a6dadfdd80398dc64c889c3";
      };
    }

    {
      name = "eslint-config-airbnb-base-12.1.0.tgz";
      path = fetchurl {
        name = "eslint-config-airbnb-base-12.1.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-config-airbnb-base/-/eslint-config-airbnb-base-12.1.0.tgz";
        sha1 = "386441e54a12ccd957b0a92564a4bafebd747944";
      };
    }

    {
      name = "eslint-config-airbnb-16.1.0.tgz";
      path = fetchurl {
        name = "eslint-config-airbnb-16.1.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-config-airbnb/-/eslint-config-airbnb-16.1.0.tgz";
        sha1 = "2546bfb02cc9fe92284bf1723ccf2e87bc45ca46";
      };
    }

    {
      name = "eslint-config-prettier-2.9.0.tgz";
      path = fetchurl {
        name = "eslint-config-prettier-2.9.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-config-prettier/-/eslint-config-prettier-2.9.0.tgz";
        sha1 = "5ecd65174d486c22dff389fe036febf502d468a3";
      };
    }

    {
      name = "eslint-config-pubsweet-0.0.6.tgz";
      path = fetchurl {
        name = "eslint-config-pubsweet-0.0.6.tgz";
        url  = "https://registry.yarnpkg.com/eslint-config-pubsweet/-/eslint-config-pubsweet-0.0.6.tgz";
        sha1 = "cb29cd241a33efab96f9ba8947d56f4b4b4cd5aa";
      };
    }

    {
      name = "eslint-config-standard-jsx-4.0.2.tgz";
      path = fetchurl {
        name = "eslint-config-standard-jsx-4.0.2.tgz";
        url  = "https://registry.yarnpkg.com/eslint-config-standard-jsx/-/eslint-config-standard-jsx-4.0.2.tgz";
        sha1 = "009e53c4ddb1e9ee70b4650ffe63a7f39f8836e1";
      };
    }

    {
      name = "eslint-config-standard-react-5.0.0.tgz";
      path = fetchurl {
        name = "eslint-config-standard-react-5.0.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-config-standard-react/-/eslint-config-standard-react-5.0.0.tgz";
        sha1 = "64c7b8140172852be810a53d48ee87649ff178e3";
      };
    }

    {
      name = "eslint-config-standard-10.2.1.tgz";
      path = fetchurl {
        name = "eslint-config-standard-10.2.1.tgz";
        url  = "https://registry.yarnpkg.com/eslint-config-standard/-/eslint-config-standard-10.2.1.tgz";
        sha1 = "c061e4d066f379dc17cd562c64e819b4dd454591";
      };
    }

    {
      name = "eslint-import-resolver-node-0.2.3.tgz";
      path = fetchurl {
        name = "eslint-import-resolver-node-0.2.3.tgz";
        url  = "https://registry.yarnpkg.com/eslint-import-resolver-node/-/eslint-import-resolver-node-0.2.3.tgz";
        sha1 = "5add8106e8c928db2cba232bcd9efa846e3da16c";
      };
    }

    {
      name = "eslint-import-resolver-node-0.3.2.tgz";
      path = fetchurl {
        name = "eslint-import-resolver-node-0.3.2.tgz";
        url  = "https://registry.yarnpkg.com/eslint-import-resolver-node/-/eslint-import-resolver-node-0.3.2.tgz";
        sha1 = "58f15fb839b8d0576ca980413476aab2472db66a";
      };
    }

    {
      name = "eslint-loader-1.9.0.tgz";
      path = fetchurl {
        name = "eslint-loader-1.9.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-loader/-/eslint-loader-1.9.0.tgz";
        sha1 = "7e1be9feddca328d3dcfaef1ad49d5beffe83a13";
      };
    }

    {
      name = "eslint-module-utils-2.2.0.tgz";
      path = fetchurl {
        name = "eslint-module-utils-2.2.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-module-utils/-/eslint-module-utils-2.2.0.tgz";
        sha1 = "b270362cd88b1a48ad308976ce7fa54e98411746";
      };
    }

    {
      name = "eslint-plugin-import-2.13.0.tgz";
      path = fetchurl {
        name = "eslint-plugin-import-2.13.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-plugin-import/-/eslint-plugin-import-2.13.0.tgz";
        sha1 = "df24f241175e312d91662dc91ca84064caec14ed";
      };
    }

    {
      name = "eslint-plugin-import-2.2.0.tgz";
      path = fetchurl {
        name = "eslint-plugin-import-2.2.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-plugin-import/-/eslint-plugin-import-2.2.0.tgz";
        sha1 = "72ba306fad305d67c4816348a4699a4229ac8b4e";
      };
    }

    {
      name = "eslint-plugin-jest-21.17.0.tgz";
      path = fetchurl {
        name = "eslint-plugin-jest-21.17.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-plugin-jest/-/eslint-plugin-jest-21.17.0.tgz";
        sha1 = "fdb00e2f9ff16987d6ebcf2c75c7add105760bbb";
      };
    }

    {
      name = "eslint-plugin-jsx-a11y-6.1.0.tgz";
      path = fetchurl {
        name = "eslint-plugin-jsx-a11y-6.1.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-plugin-jsx-a11y/-/eslint-plugin-jsx-a11y-6.1.0.tgz";
        sha1 = "569f6f2d29546cab82cedaa077ec829693b0c42d";
      };
    }

    {
      name = "eslint-plugin-node-5.2.1.tgz";
      path = fetchurl {
        name = "eslint-plugin-node-5.2.1.tgz";
        url  = "https://registry.yarnpkg.com/eslint-plugin-node/-/eslint-plugin-node-5.2.1.tgz";
        sha1 = "80df3253c4d7901045ec87fa660a284e32bdca29";
      };
    }

    {
      name = "eslint-plugin-node-4.2.3.tgz";
      path = fetchurl {
        name = "eslint-plugin-node-4.2.3.tgz";
        url  = "https://registry.yarnpkg.com/eslint-plugin-node/-/eslint-plugin-node-4.2.3.tgz";
        sha1 = "c04390ab8dbcbb6887174023d6f3a72769e63b97";
      };
    }

    {
      name = "eslint-plugin-prettier-2.6.2.tgz";
      path = fetchurl {
        name = "eslint-plugin-prettier-2.6.2.tgz";
        url  = "https://registry.yarnpkg.com/eslint-plugin-prettier/-/eslint-plugin-prettier-2.6.2.tgz";
        sha1 = "71998c60aedfa2141f7bfcbf9d1c459bf98b4fad";
      };
    }

    {
      name = "eslint-plugin-promise-3.8.0.tgz";
      path = fetchurl {
        name = "eslint-plugin-promise-3.8.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-plugin-promise/-/eslint-plugin-promise-3.8.0.tgz";
        sha1 = "65ebf27a845e3c1e9d6f6a5622ddd3801694b621";
      };
    }

    {
      name = "eslint-plugin-promise-3.5.0.tgz";
      path = fetchurl {
        name = "eslint-plugin-promise-3.5.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-plugin-promise/-/eslint-plugin-promise-3.5.0.tgz";
        sha1 = "78fbb6ffe047201627569e85a6c5373af2a68fca";
      };
    }

    {
      name = "eslint-plugin-react-7.10.0.tgz";
      path = fetchurl {
        name = "eslint-plugin-react-7.10.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-plugin-react/-/eslint-plugin-react-7.10.0.tgz";
        sha1 = "af5c1fef31c4704db02098f9be18202993828b50";
      };
    }

    {
      name = "eslint-plugin-react-6.10.3.tgz";
      path = fetchurl {
        name = "eslint-plugin-react-6.10.3.tgz";
        url  = "https://registry.yarnpkg.com/eslint-plugin-react/-/eslint-plugin-react-6.10.3.tgz";
        sha1 = "c5435beb06774e12c7db2f6abaddcbf900cd3f78";
      };
    }

    {
      name = "eslint-plugin-standard-3.1.0.tgz";
      path = fetchurl {
        name = "eslint-plugin-standard-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-plugin-standard/-/eslint-plugin-standard-3.1.0.tgz";
        sha1 = "2a9e21259ba4c47c02d53b2d0c9135d4b1022d47";
      };
    }

    {
      name = "eslint-plugin-standard-3.0.1.tgz";
      path = fetchurl {
        name = "eslint-plugin-standard-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/eslint-plugin-standard/-/eslint-plugin-standard-3.0.1.tgz";
        sha1 = "34d0c915b45edc6f010393c7eef3823b08565cf2";
      };
    }

    {
      name = "eslint-restricted-globals-0.1.1.tgz";
      path = fetchurl {
        name = "eslint-restricted-globals-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/eslint-restricted-globals/-/eslint-restricted-globals-0.1.1.tgz";
        sha1 = "35f0d5cbc64c2e3ed62e93b4b1a7af05ba7ed4d7";
      };
    }

    {
      name = "eslint-scope-3.7.1.tgz";
      path = fetchurl {
        name = "eslint-scope-3.7.1.tgz";
        url  = "https://registry.yarnpkg.com/eslint-scope/-/eslint-scope-3.7.1.tgz";
        sha1 = "3d63c3edfda02e06e01a452ad88caacc7cdcb6e8";
      };
    }

    {
      name = "eslint-visitor-keys-1.0.0.tgz";
      path = fetchurl {
        name = "eslint-visitor-keys-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint-visitor-keys/-/eslint-visitor-keys-1.0.0.tgz";
        sha1 = "3f3180fb2e291017716acb4c9d6d5b5c34a6a81d";
      };
    }

    {
      name = "eslint-4.19.1.tgz";
      path = fetchurl {
        name = "eslint-4.19.1.tgz";
        url  = "https://registry.yarnpkg.com/eslint/-/eslint-4.19.1.tgz";
        sha1 = "32d1d653e1d90408854bfb296f076ec7e186a300";
      };
    }

    {
      name = "eslint-3.19.0.tgz";
      path = fetchurl {
        name = "eslint-3.19.0.tgz";
        url  = "https://registry.yarnpkg.com/eslint/-/eslint-3.19.0.tgz";
        sha1 = "c8fc6201c7f40dd08941b87c085767386a679acc";
      };
    }

    {
      name = "espree-3.5.4.tgz";
      path = fetchurl {
        name = "espree-3.5.4.tgz";
        url  = "https://registry.yarnpkg.com/espree/-/espree-3.5.4.tgz";
        sha1 = "b0f447187c8a8bed944b815a660bddf5deb5d1a7";
      };
    }

    {
      name = "esprima-2.7.3.tgz";
      path = fetchurl {
        name = "esprima-2.7.3.tgz";
        url  = "https://registry.yarnpkg.com/esprima/-/esprima-2.7.3.tgz";
        sha1 = "96e3b70d5779f6ad49cd032673d1c312767ba581";
      };
    }

    {
      name = "esprima-3.1.3.tgz";
      path = fetchurl {
        name = "esprima-3.1.3.tgz";
        url  = "https://registry.yarnpkg.com/esprima/-/esprima-3.1.3.tgz";
        sha1 = "fdca51cee6133895e3c88d535ce49dbff62a4633";
      };
    }

    {
      name = "esprima-4.0.0.tgz";
      path = fetchurl {
        name = "esprima-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/esprima/-/esprima-4.0.0.tgz";
        sha1 = "4499eddcd1110e0b218bacf2fa7f7f59f55ca804";
      };
    }

    {
      name = "esprima-3.0.0.tgz";
      path = fetchurl {
        name = "esprima-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/esprima/-/esprima-3.0.0.tgz";
        sha1 = "53cf247acda77313e551c3aa2e73342d3fb4f7d9";
      };
    }

    {
      name = "esquery-1.0.1.tgz";
      path = fetchurl {
        name = "esquery-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/esquery/-/esquery-1.0.1.tgz";
        sha1 = "406c51658b1f5991a5f9b62b1dc25b00e3e5c708";
      };
    }

    {
      name = "esrecurse-4.2.1.tgz";
      path = fetchurl {
        name = "esrecurse-4.2.1.tgz";
        url  = "https://registry.yarnpkg.com/esrecurse/-/esrecurse-4.2.1.tgz";
        sha1 = "007a3b9fdbc2b3bb87e4879ea19c92fdbd3942cf";
      };
    }

    {
      name = "estraverse-4.2.0.tgz";
      path = fetchurl {
        name = "estraverse-4.2.0.tgz";
        url  = "https://registry.yarnpkg.com/estraverse/-/estraverse-4.2.0.tgz";
        sha1 = "0dee3fed31fcd469618ce7342099fc1afa0bdb13";
      };
    }

    {
      name = "esutils-2.0.2.tgz";
      path = fetchurl {
        name = "esutils-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/esutils/-/esutils-2.0.2.tgz";
        sha1 = "0abf4f1caa5bcb1f7a9d8acc6dea4faaa04bac9b";
      };
    }

    {
      name = "etag-1.8.1.tgz";
      path = fetchurl {
        name = "etag-1.8.1.tgz";
        url  = "https://registry.yarnpkg.com/etag/-/etag-1.8.1.tgz";
        sha1 = "41ae2eeb65efa62268aebfea83ac7d79299b0887";
      };
    }

    {
      name = "event-emitter-0.3.5.tgz";
      path = fetchurl {
        name = "event-emitter-0.3.5.tgz";
        url  = "https://registry.yarnpkg.com/event-emitter/-/event-emitter-0.3.5.tgz";
        sha1 = "df8c69eef1647923c7157b9ce83840610b02cc39";
      };
    }

    {
      name = "event-source-polyfill-0.0.10.tgz";
      path = fetchurl {
        name = "event-source-polyfill-0.0.10.tgz";
        url  = "https://registry.yarnpkg.com/event-source-polyfill/-/event-source-polyfill-0.0.10.tgz";
        sha1 = "e7e81863c333f5a842e3bf0a3b570bedaf042e09";
      };
    }

    {
      name = "event-stream-0.5.3.tgz";
      path = fetchurl {
        name = "event-stream-0.5.3.tgz";
        url  = "http://registry.npmjs.org/event-stream/-/event-stream-0.5.3.tgz";
        sha1 = "b77b9309f7107addfeab63f0c0eafd8db0bd8c1c";
      };
    }

    {
      name = "eventemitter2-0.4.14.tgz";
      path = fetchurl {
        name = "eventemitter2-0.4.14.tgz";
        url  = "https://registry.yarnpkg.com/eventemitter2/-/eventemitter2-0.4.14.tgz";
        sha1 = "8f61b75cde012b2e9eb284d4545583b5643b61ab";
      };
    }

    {
      name = "eventemitter3-3.1.0.tgz";
      path = fetchurl {
        name = "eventemitter3-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/eventemitter3/-/eventemitter3-3.1.0.tgz";
        sha1 = "090b4d6cdbd645ed10bf750d4b5407942d7ba163";
      };
    }

    {
      name = "events-1.1.1.tgz";
      path = fetchurl {
        name = "events-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/events/-/events-1.1.1.tgz";
        sha1 = "9ebdb7635ad099c70dcc4c2a1f5004288e8bd924";
      };
    }

    {
      name = "eventsource-0.1.6.tgz";
      path = fetchurl {
        name = "eventsource-0.1.6.tgz";
        url  = "https://registry.yarnpkg.com/eventsource/-/eventsource-0.1.6.tgz";
        sha1 = "0acede849ed7dd1ccc32c811bb11b944d4f29232";
      };
    }

    {
      name = "evp_bytestokey-1.0.3.tgz";
      path = fetchurl {
        name = "evp_bytestokey-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/evp_bytestokey/-/evp_bytestokey-1.0.3.tgz";
        sha1 = "7fcbdb198dc71959432efe13842684e0525acb02";
      };
    }

    {
      name = "exec-sh-0.2.2.tgz";
      path = fetchurl {
        name = "exec-sh-0.2.2.tgz";
        url  = "https://registry.yarnpkg.com/exec-sh/-/exec-sh-0.2.2.tgz";
        sha1 = "2a5e7ffcbd7d0ba2755bdecb16e5a427dfbdec36";
      };
    }

    {
      name = "execa-0.7.0.tgz";
      path = fetchurl {
        name = "execa-0.7.0.tgz";
        url  = "https://registry.yarnpkg.com/execa/-/execa-0.7.0.tgz";
        sha1 = "944becd34cc41ee32a63a9faf27ad5a65fc59777";
      };
    }

    {
      name = "execa-0.8.0.tgz";
      path = fetchurl {
        name = "execa-0.8.0.tgz";
        url  = "https://registry.yarnpkg.com/execa/-/execa-0.8.0.tgz";
        sha1 = "d8d76bbc1b55217ed190fd6dd49d3c774ecfc8da";
      };
    }

    {
      name = "execall-1.0.0.tgz";
      path = fetchurl {
        name = "execall-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/execall/-/execall-1.0.0.tgz";
        sha1 = "73d0904e395b3cab0658b08d09ec25307f29bb73";
      };
    }

    {
      name = "exit-hook-1.1.1.tgz";
      path = fetchurl {
        name = "exit-hook-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/exit-hook/-/exit-hook-1.1.1.tgz";
        sha1 = "f05ca233b48c05d54fff07765df8507e95c02ff8";
      };
    }

    {
      name = "exit-0.1.2.tgz";
      path = fetchurl {
        name = "exit-0.1.2.tgz";
        url  = "https://registry.yarnpkg.com/exit/-/exit-0.1.2.tgz";
        sha1 = "0632638f8d877cc82107d30a0fff1a17cba1cd0c";
      };
    }

    {
      name = "expand-brackets-0.1.5.tgz";
      path = fetchurl {
        name = "expand-brackets-0.1.5.tgz";
        url  = "https://registry.yarnpkg.com/expand-brackets/-/expand-brackets-0.1.5.tgz";
        sha1 = "df07284e342a807cd733ac5af72411e581d1177b";
      };
    }

    {
      name = "expand-brackets-2.1.4.tgz";
      path = fetchurl {
        name = "expand-brackets-2.1.4.tgz";
        url  = "https://registry.yarnpkg.com/expand-brackets/-/expand-brackets-2.1.4.tgz";
        sha1 = "b77735e315ce30f6b6eff0f83b04151a22449622";
      };
    }

    {
      name = "expand-range-1.8.2.tgz";
      path = fetchurl {
        name = "expand-range-1.8.2.tgz";
        url  = "https://registry.yarnpkg.com/expand-range/-/expand-range-1.8.2.tgz";
        sha1 = "a299effd335fe2721ebae8e257ec79644fc85337";
      };
    }

    {
      name = "expand-tilde-2.0.2.tgz";
      path = fetchurl {
        name = "expand-tilde-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/expand-tilde/-/expand-tilde-2.0.2.tgz";
        sha1 = "97e801aa052df02454de46b02bf621642cdc8502";
      };
    }

    {
      name = "expect-ct-0.1.1.tgz";
      path = fetchurl {
        name = "expect-ct-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/expect-ct/-/expect-ct-0.1.1.tgz";
        sha1 = "de84476a2dbcb85000d5903737e9bc8a5ba7b897";
      };
    }

    {
      name = "expect-22.4.3.tgz";
      path = fetchurl {
        name = "expect-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/expect/-/expect-22.4.3.tgz";
        sha1 = "d5a29d0a0e1fb2153557caef2674d4547e914674";
      };
    }

    {
      name = "express-4.16.3.tgz";
      path = fetchurl {
        name = "express-4.16.3.tgz";
        url  = "https://registry.yarnpkg.com/express/-/express-4.16.3.tgz";
        sha1 = "6af8a502350db3246ecc4becf6b5a34d22f7ed53";
      };
    }

    {
      name = "extend-shallow-2.0.1.tgz";
      path = fetchurl {
        name = "extend-shallow-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/extend-shallow/-/extend-shallow-2.0.1.tgz";
        sha1 = "51af7d614ad9a9f610ea1bafbb989d6b1c56890f";
      };
    }

    {
      name = "extend-shallow-3.0.2.tgz";
      path = fetchurl {
        name = "extend-shallow-3.0.2.tgz";
        url  = "https://registry.yarnpkg.com/extend-shallow/-/extend-shallow-3.0.2.tgz";
        sha1 = "26a71aaf073b39fb2127172746131c2704028db8";
      };
    }

    {
      name = "extend-3.0.1.tgz";
      path = fetchurl {
        name = "extend-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/extend/-/extend-3.0.1.tgz";
        sha1 = "a755ea7bc1adfcc5a31ce7e762dbaadc5e636444";
      };
    }

    {
      name = "external-editor-2.2.0.tgz";
      path = fetchurl {
        name = "external-editor-2.2.0.tgz";
        url  = "https://registry.yarnpkg.com/external-editor/-/external-editor-2.2.0.tgz";
        sha1 = "045511cfd8d133f3846673d1047c154e214ad3d5";
      };
    }

    {
      name = "extglob-0.3.2.tgz";
      path = fetchurl {
        name = "extglob-0.3.2.tgz";
        url  = "https://registry.yarnpkg.com/extglob/-/extglob-0.3.2.tgz";
        sha1 = "2e18ff3d2f49ab2765cec9023f011daa8d8349a1";
      };
    }

    {
      name = "extglob-2.0.4.tgz";
      path = fetchurl {
        name = "extglob-2.0.4.tgz";
        url  = "https://registry.yarnpkg.com/extglob/-/extglob-2.0.4.tgz";
        sha1 = "ad00fe4dc612a9232e8718711dc5cb5ab0285543";
      };
    }

    {
      name = "extract-files-3.1.0.tgz";
      path = fetchurl {
        name = "extract-files-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/extract-files/-/extract-files-3.1.0.tgz";
        sha1 = "b70424c9d4a1a4208efe22069388f428e4ae00f1";
      };
    }

    {
      name = "extract-text-webpack-plugin-3.0.2.tgz";
      path = fetchurl {
        name = "extract-text-webpack-plugin-3.0.2.tgz";
        url  = "https://registry.yarnpkg.com/extract-text-webpack-plugin/-/extract-text-webpack-plugin-3.0.2.tgz";
        sha1 = "5f043eaa02f9750a9258b78c0a6e0dc1408fb2f7";
      };
    }

    {
      name = "extract-zip-1.6.6.tgz";
      path = fetchurl {
        name = "extract-zip-1.6.6.tgz";
        url  = "https://registry.yarnpkg.com/extract-zip/-/extract-zip-1.6.6.tgz";
        sha1 = "1290ede8d20d0872b429fd3f351ca128ec5ef85c";
      };
    }

    {
      name = "extsprintf-1.3.0.tgz";
      path = fetchurl {
        name = "extsprintf-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/extsprintf/-/extsprintf-1.3.0.tgz";
        sha1 = "96918440e3041a7a414f8c52e3c574eb3c3e1e05";
      };
    }

    {
      name = "extsprintf-1.4.0.tgz";
      path = fetchurl {
        name = "extsprintf-1.4.0.tgz";
        url  = "https://registry.yarnpkg.com/extsprintf/-/extsprintf-1.4.0.tgz";
        sha1 = "e2689f8f356fad62cca65a3a91c5df5f9551692f";
      };
    }

    {
      name = "eyes-0.1.8.tgz";
      path = fetchurl {
        name = "eyes-0.1.8.tgz";
        url  = "https://registry.yarnpkg.com/eyes/-/eyes-0.1.8.tgz";
        sha1 = "62cf120234c683785d902348a800ef3e0cc20bc0";
      };
    }

    {
      name = "faker-4.1.0.tgz";
      path = fetchurl {
        name = "faker-4.1.0.tgz";
        url  = "https://registry.yarnpkg.com/faker/-/faker-4.1.0.tgz";
        sha1 = "1e45bbbecc6774b3c195fad2835109c6d748cc3f";
      };
    }

    {
      name = "fast-deep-equal-1.1.0.tgz";
      path = fetchurl {
        name = "fast-deep-equal-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/fast-deep-equal/-/fast-deep-equal-1.1.0.tgz";
        sha1 = "c053477817c86b51daa853c81e059b733d023614";
      };
    }

    {
      name = "fast-deep-equal-2.0.1.tgz";
      path = fetchurl {
        name = "fast-deep-equal-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/fast-deep-equal/-/fast-deep-equal-2.0.1.tgz";
        sha1 = "7b05218ddf9667bf7f370bf7fdb2cb15fdd0aa49";
      };
    }

    {
      name = "fast-diff-1.1.2.tgz";
      path = fetchurl {
        name = "fast-diff-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/fast-diff/-/fast-diff-1.1.2.tgz";
        sha1 = "4b62c42b8e03de3f848460b639079920695d0154";
      };
    }

    {
      name = "fast-json-stable-stringify-2.0.0.tgz";
      path = fetchurl {
        name = "fast-json-stable-stringify-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/fast-json-stable-stringify/-/fast-json-stable-stringify-2.0.0.tgz";
        sha1 = "d5142c0caee6b1189f87d3a76111064f86c8bbf2";
      };
    }

    {
      name = "fast-levenshtein-2.0.6.tgz";
      path = fetchurl {
        name = "fast-levenshtein-2.0.6.tgz";
        url  = "https://registry.yarnpkg.com/fast-levenshtein/-/fast-levenshtein-2.0.6.tgz";
        sha1 = "3d8a5c66883a16a30ca8643e851f19baa7797917";
      };
    }

    {
      name = "fast-safe-stringify-2.0.4.tgz";
      path = fetchurl {
        name = "fast-safe-stringify-2.0.4.tgz";
        url  = "https://registry.yarnpkg.com/fast-safe-stringify/-/fast-safe-stringify-2.0.4.tgz";
        sha1 = "4fe828718aa61dbcf9119c3c24e79cc4dea973b2";
      };
    }

    {
      name = "fastparse-1.1.1.tgz";
      path = fetchurl {
        name = "fastparse-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/fastparse/-/fastparse-1.1.1.tgz";
        sha1 = "d1e2643b38a94d7583b479060e6c4affc94071f8";
      };
    }

    {
      name = "faye-websocket-0.10.0.tgz";
      path = fetchurl {
        name = "faye-websocket-0.10.0.tgz";
        url  = "https://registry.yarnpkg.com/faye-websocket/-/faye-websocket-0.10.0.tgz";
        sha1 = "4e492f8d04dfb6f89003507f6edbf2d501e7c6f4";
      };
    }

    {
      name = "faye-websocket-0.11.1.tgz";
      path = fetchurl {
        name = "faye-websocket-0.11.1.tgz";
        url  = "https://registry.yarnpkg.com/faye-websocket/-/faye-websocket-0.11.1.tgz";
        sha1 = "f0efe18c4f56e4f40afc7e06c719fd5ee6188f38";
      };
    }

    {
      name = "fb-watchman-1.9.2.tgz";
      path = fetchurl {
        name = "fb-watchman-1.9.2.tgz";
        url  = "https://registry.yarnpkg.com/fb-watchman/-/fb-watchman-1.9.2.tgz";
        sha1 = "a24cf47827f82d38fb59a69ad70b76e3b6ae7383";
      };
    }

    {
      name = "fb-watchman-2.0.0.tgz";
      path = fetchurl {
        name = "fb-watchman-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/fb-watchman/-/fb-watchman-2.0.0.tgz";
        sha1 = "54e9abf7dfa2f26cd9b1636c588c1afc05de5d58";
      };
    }

    {
      name = "fbjs-0.8.17.tgz";
      path = fetchurl {
        name = "fbjs-0.8.17.tgz";
        url  = "https://registry.yarnpkg.com/fbjs/-/fbjs-0.8.17.tgz";
        sha1 = "c4d598ead6949112653d6588b01a5cdcd9f90fdd";
      };
    }

    {
      name = "fd-slicer-1.0.1.tgz";
      path = fetchurl {
        name = "fd-slicer-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/fd-slicer/-/fd-slicer-1.0.1.tgz";
        sha1 = "8b5bcbd9ec327c5041bf9ab023fd6750f1177e65";
      };
    }

    {
      name = "fecha-2.3.3.tgz";
      path = fetchurl {
        name = "fecha-2.3.3.tgz";
        url  = "https://registry.yarnpkg.com/fecha/-/fecha-2.3.3.tgz";
        sha1 = "948e74157df1a32fd1b12c3a3c3cdcb6ec9d96cd";
      };
    }

    {
      name = "figures-1.7.0.tgz";
      path = fetchurl {
        name = "figures-1.7.0.tgz";
        url  = "https://registry.yarnpkg.com/figures/-/figures-1.7.0.tgz";
        sha1 = "cbe1e3affcf1cd44b80cadfed28dc793a9701d2e";
      };
    }

    {
      name = "figures-2.0.0.tgz";
      path = fetchurl {
        name = "figures-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/figures/-/figures-2.0.0.tgz";
        sha1 = "3ab1a2d2a62c8bfb431a0c94cb797a2fce27c962";
      };
    }

    {
      name = "file-entry-cache-2.0.0.tgz";
      path = fetchurl {
        name = "file-entry-cache-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/file-entry-cache/-/file-entry-cache-2.0.0.tgz";
        sha1 = "c392990c3e684783d838b8c84a45d8a048458361";
      };
    }

    {
      name = "file-loader-0.11.2.tgz";
      path = fetchurl {
        name = "file-loader-0.11.2.tgz";
        url  = "https://registry.yarnpkg.com/file-loader/-/file-loader-0.11.2.tgz";
        sha1 = "4ff1df28af38719a6098093b88c82c71d1794a34";
      };
    }

    {
      name = "file-loader-1.1.11.tgz";
      path = fetchurl {
        name = "file-loader-1.1.11.tgz";
        url  = "https://registry.yarnpkg.com/file-loader/-/file-loader-1.1.11.tgz";
        sha1 = "6fe886449b0f2a936e43cabaac0cdbfb369506f8";
      };
    }

    {
      name = "file-set-2.0.0.tgz";
      path = fetchurl {
        name = "file-set-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/file-set/-/file-set-2.0.0.tgz";
        sha1 = "11831a388ec378aba881311a94f69814118849c3";
      };
    }

    {
      name = "file-stream-rotator-0.2.1.tgz";
      path = fetchurl {
        name = "file-stream-rotator-0.2.1.tgz";
        url  = "https://registry.yarnpkg.com/file-stream-rotator/-/file-stream-rotator-0.2.1.tgz";
        sha1 = "0d6fea1a9a7aba25a87cfd31b6e269e44e8f0af2";
      };
    }

    {
      name = "filename-regex-2.0.1.tgz";
      path = fetchurl {
        name = "filename-regex-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/filename-regex/-/filename-regex-2.0.1.tgz";
        sha1 = "c1c4b9bee3e09725ddb106b75c1e301fe2f18b26";
      };
    }

    {
      name = "fileset-2.0.3.tgz";
      path = fetchurl {
        name = "fileset-2.0.3.tgz";
        url  = "https://registry.yarnpkg.com/fileset/-/fileset-2.0.3.tgz";
        sha1 = "8e7548a96d3cc2327ee5e674168723a333bba2a0";
      };
    }

    {
      name = "filesize-3.5.11.tgz";
      path = fetchurl {
        name = "filesize-3.5.11.tgz";
        url  = "https://registry.yarnpkg.com/filesize/-/filesize-3.5.11.tgz";
        sha1 = "1919326749433bb3cf77368bd158caabcc19e9ee";
      };
    }

    {
      name = "fill-range-2.2.4.tgz";
      path = fetchurl {
        name = "fill-range-2.2.4.tgz";
        url  = "https://registry.yarnpkg.com/fill-range/-/fill-range-2.2.4.tgz";
        sha1 = "eb1e773abb056dcd8df2bfdf6af59b8b3a936565";
      };
    }

    {
      name = "fill-range-4.0.0.tgz";
      path = fetchurl {
        name = "fill-range-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/fill-range/-/fill-range-4.0.0.tgz";
        sha1 = "d544811d428f98eb06a63dc402d2403c328c38f7";
      };
    }

    {
      name = "finalhandler-1.1.1.tgz";
      path = fetchurl {
        name = "finalhandler-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/finalhandler/-/finalhandler-1.1.1.tgz";
        sha1 = "eebf4ed840079c83f4249038c9d703008301b105";
      };
    }

    {
      name = "find-cache-dir-0.1.1.tgz";
      path = fetchurl {
        name = "find-cache-dir-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/find-cache-dir/-/find-cache-dir-0.1.1.tgz";
        sha1 = "c8defae57c8a52a8a784f9e31c57c742e993a0b9";
      };
    }

    {
      name = "find-cache-dir-1.0.0.tgz";
      path = fetchurl {
        name = "find-cache-dir-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/find-cache-dir/-/find-cache-dir-1.0.0.tgz";
        sha1 = "9288e3e9e3cc3748717d39eade17cf71fc30ee6f";
      };
    }

    {
      name = "find-parent-dir-0.3.0.tgz";
      path = fetchurl {
        name = "find-parent-dir-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/find-parent-dir/-/find-parent-dir-0.3.0.tgz";
        sha1 = "33c44b429ab2b2f0646299c5f9f718f376ff8d54";
      };
    }

    {
      name = "find-replace-2.0.1.tgz";
      path = fetchurl {
        name = "find-replace-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/find-replace/-/find-replace-2.0.1.tgz";
        sha1 = "6d9683a7ca20f8f9aabeabad07e4e2580f528550";
      };
    }

    {
      name = "find-root-1.1.0.tgz";
      path = fetchurl {
        name = "find-root-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/find-root/-/find-root-1.1.0.tgz";
        sha1 = "abcfc8ba76f708c42a97b3d685b7e9450bfb9ce4";
      };
    }

    {
      name = "find-up-1.1.2.tgz";
      path = fetchurl {
        name = "find-up-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/find-up/-/find-up-1.1.2.tgz";
        sha1 = "6b2e9822b1a2ce0a60ab64d610eccad53cb24d0f";
      };
    }

    {
      name = "find-up-2.1.0.tgz";
      path = fetchurl {
        name = "find-up-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/find-up/-/find-up-2.1.0.tgz";
        sha1 = "45d1b7e506c717ddd482775a2b77920a3c0c57a7";
      };
    }

    {
      name = "findup-0.1.5.tgz";
      path = fetchurl {
        name = "findup-0.1.5.tgz";
        url  = "https://registry.yarnpkg.com/findup/-/findup-0.1.5.tgz";
        sha1 = "8ad929a3393bac627957a7e5de4623b06b0e2ceb";
      };
    }

    {
      name = "flat-cache-1.3.0.tgz";
      path = fetchurl {
        name = "flat-cache-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/flat-cache/-/flat-cache-1.3.0.tgz";
        sha1 = "d3030b32b38154f4e3b7e9c709f490f7ef97c481";
      };
    }

    {
      name = "flatten-1.0.2.tgz";
      path = fetchurl {
        name = "flatten-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/flatten/-/flatten-1.0.2.tgz";
        sha1 = "dae46a9d78fbe25292258cc1e780a41d95c03782";
      };
    }

    {
      name = "flush-write-stream-1.0.3.tgz";
      path = fetchurl {
        name = "flush-write-stream-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/flush-write-stream/-/flush-write-stream-1.0.3.tgz";
        sha1 = "c5d586ef38af6097650b49bc41b55fabb19f35bd";
      };
    }

    {
      name = "follow-redirects-1.5.1.tgz";
      path = fetchurl {
        name = "follow-redirects-1.5.1.tgz";
        url  = "https://registry.yarnpkg.com/follow-redirects/-/follow-redirects-1.5.1.tgz";
        sha1 = "67a8f14f5a1f67f962c2c46469c79eaec0a90291";
      };
    }

    {
      name = "font-awesome-4.7.0.tgz";
      path = fetchurl {
        name = "font-awesome-4.7.0.tgz";
        url  = "https://registry.yarnpkg.com/font-awesome/-/font-awesome-4.7.0.tgz";
        sha1 = "8fa8cf0411a1a31afd07b06d2902bb9fc815a133";
      };
    }

    {
      name = "for-in-0.1.8.tgz";
      path = fetchurl {
        name = "for-in-0.1.8.tgz";
        url  = "https://registry.yarnpkg.com/for-in/-/for-in-0.1.8.tgz";
        sha1 = "d8773908e31256109952b1fdb9b3fa867d2775e1";
      };
    }

    {
      name = "for-in-1.0.2.tgz";
      path = fetchurl {
        name = "for-in-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/for-in/-/for-in-1.0.2.tgz";
        sha1 = "81068d295a8142ec0ac726c6e2200c30fb6d5e80";
      };
    }

    {
      name = "for-own-0.1.5.tgz";
      path = fetchurl {
        name = "for-own-0.1.5.tgz";
        url  = "https://registry.yarnpkg.com/for-own/-/for-own-0.1.5.tgz";
        sha1 = "5265c681a4f294dabbf17c9509b6763aa84510ce";
      };
    }

    {
      name = "for-own-1.0.0.tgz";
      path = fetchurl {
        name = "for-own-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/for-own/-/for-own-1.0.0.tgz";
        sha1 = "c63332f415cedc4b04dbfe70cf836494c53cb44b";
      };
    }

    {
      name = "foreach-2.0.5.tgz";
      path = fetchurl {
        name = "foreach-2.0.5.tgz";
        url  = "https://registry.yarnpkg.com/foreach/-/foreach-2.0.5.tgz";
        sha1 = "0bee005018aeb260d0a3af3ae658dd0136ec1b99";
      };
    }

    {
      name = "forever-agent-0.6.1.tgz";
      path = fetchurl {
        name = "forever-agent-0.6.1.tgz";
        url  = "https://registry.yarnpkg.com/forever-agent/-/forever-agent-0.6.1.tgz";
        sha1 = "fbc71f0c41adeb37f96c577ad1ed42d8fdacca91";
      };
    }

    {
      name = "forever-monitor-1.7.1.tgz";
      path = fetchurl {
        name = "forever-monitor-1.7.1.tgz";
        url  = "https://registry.yarnpkg.com/forever-monitor/-/forever-monitor-1.7.1.tgz";
        sha1 = "5d820f4a3a78db2d81ae2671f158b9e86a091bb8";
      };
    }

    {
      name = "form-data-1.0.0-rc4.tgz";
      path = fetchurl {
        name = "form-data-1.0.0-rc4.tgz";
        url  = "https://registry.yarnpkg.com/form-data/-/form-data-1.0.0-rc4.tgz";
        sha1 = "05ac6bc22227b43e4461f488161554699d4f8b5e";
      };
    }

    {
      name = "form-data-2.1.4.tgz";
      path = fetchurl {
        name = "form-data-2.1.4.tgz";
        url  = "https://registry.yarnpkg.com/form-data/-/form-data-2.1.4.tgz";
        sha1 = "33c183acf193276ecaa98143a69e94bfee1750d1";
      };
    }

    {
      name = "form-data-2.3.2.tgz";
      path = fetchurl {
        name = "form-data-2.3.2.tgz";
        url  = "https://registry.yarnpkg.com/form-data/-/form-data-2.3.2.tgz";
        sha1 = "4970498be604c20c005d4f5c23aecd21d6b49099";
      };
    }

    {
      name = "formatio-1.1.1.tgz";
      path = fetchurl {
        name = "formatio-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/formatio/-/formatio-1.1.1.tgz";
        sha1 = "5ed3ccd636551097383465d996199100e86161e9";
      };
    }

    {
      name = "formatio-1.2.0.tgz";
      path = fetchurl {
        name = "formatio-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/formatio/-/formatio-1.2.0.tgz";
        sha1 = "f3b2167d9068c4698a8d51f4f760a39a54d818eb";
      };
    }

    {
      name = "formidable-1.2.1.tgz";
      path = fetchurl {
        name = "formidable-1.2.1.tgz";
        url  = "https://registry.yarnpkg.com/formidable/-/formidable-1.2.1.tgz";
        sha1 = "70fb7ca0290ee6ff961090415f4b3df3d2082659";
      };
    }

    {
      name = "forwarded-0.1.2.tgz";
      path = fetchurl {
        name = "forwarded-0.1.2.tgz";
        url  = "https://registry.yarnpkg.com/forwarded/-/forwarded-0.1.2.tgz";
        sha1 = "98c23dab1175657b8c0573e8ceccd91b0ff18c84";
      };
    }

    {
      name = "fragment-cache-0.2.1.tgz";
      path = fetchurl {
        name = "fragment-cache-0.2.1.tgz";
        url  = "https://registry.yarnpkg.com/fragment-cache/-/fragment-cache-0.2.1.tgz";
        sha1 = "4290fad27f13e89be7f33799c6bc5a0abfff0d19";
      };
    }

    {
      name = "frameguard-3.0.0.tgz";
      path = fetchurl {
        name = "frameguard-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/frameguard/-/frameguard-3.0.0.tgz";
        sha1 = "7bcad469ee7b96e91d12ceb3959c78235a9272e9";
      };
    }

    {
      name = "fresh-0.5.2.tgz";
      path = fetchurl {
        name = "fresh-0.5.2.tgz";
        url  = "https://registry.yarnpkg.com/fresh/-/fresh-0.5.2.tgz";
        sha1 = "3d8cadd90d976569fa835ab1f8e4b23a105605a7";
      };
    }

    {
      name = "from2-2.3.0.tgz";
      path = fetchurl {
        name = "from2-2.3.0.tgz";
        url  = "https://registry.yarnpkg.com/from2/-/from2-2.3.0.tgz";
        sha1 = "8bfb5502bde4a4d36cfdeea007fcca21d7e382af";
      };
    }

    {
      name = "fs-constants-1.0.0.tgz";
      path = fetchurl {
        name = "fs-constants-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/fs-constants/-/fs-constants-1.0.0.tgz";
        sha1 = "6be0de9be998ce16af8afc24497b9ee9b7ccd9ad";
      };
    }

    {
      name = "fs-extra-4.0.3.tgz";
      path = fetchurl {
        name = "fs-extra-4.0.3.tgz";
        url  = "https://registry.yarnpkg.com/fs-extra/-/fs-extra-4.0.3.tgz";
        sha1 = "0d852122e5bc5beb453fb028e9c0c9bf36340c94";
      };
    }

    {
      name = "fs-extra-5.0.0.tgz";
      path = fetchurl {
        name = "fs-extra-5.0.0.tgz";
        url  = "https://registry.yarnpkg.com/fs-extra/-/fs-extra-5.0.0.tgz";
        sha1 = "414d0110cdd06705734d055652c5411260c31abd";
      };
    }

    {
      name = "fs-minipass-1.2.5.tgz";
      path = fetchurl {
        name = "fs-minipass-1.2.5.tgz";
        url  = "https://registry.yarnpkg.com/fs-minipass/-/fs-minipass-1.2.5.tgz";
        sha1 = "06c277218454ec288df77ada54a03b8702aacb9d";
      };
    }

    {
      name = "fs-then-native-2.0.0.tgz";
      path = fetchurl {
        name = "fs-then-native-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/fs-then-native/-/fs-then-native-2.0.0.tgz";
        sha1 = "19a124d94d90c22c8e045f2e8dd6ebea36d48c67";
      };
    }

    {
      name = "fs-write-stream-atomic-1.0.10.tgz";
      path = fetchurl {
        name = "fs-write-stream-atomic-1.0.10.tgz";
        url  = "https://registry.yarnpkg.com/fs-write-stream-atomic/-/fs-write-stream-atomic-1.0.10.tgz";
        sha1 = "b47df53493ef911df75731e70a9ded0189db40c9";
      };
    }

    {
      name = "fs.realpath-1.0.0.tgz";
      path = fetchurl {
        name = "fs.realpath-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/fs.realpath/-/fs.realpath-1.0.0.tgz";
        sha1 = "1504ad2523158caa40db4a2787cb01411994ea4f";
      };
    }

    {
      name = "fsevents-1.2.4.tgz";
      path = fetchurl {
        name = "fsevents-1.2.4.tgz";
        url  = "https://registry.yarnpkg.com/fsevents/-/fsevents-1.2.4.tgz";
        sha1 = "f41dcb1af2582af3692da36fc55cbd8e1041c426";
      };
    }

    {
      name = "fstream-ignore-1.0.5.tgz";
      path = fetchurl {
        name = "fstream-ignore-1.0.5.tgz";
        url  = "https://registry.yarnpkg.com/fstream-ignore/-/fstream-ignore-1.0.5.tgz";
        sha1 = "9c31dae34767018fe1d249b24dada67d092da105";
      };
    }

    {
      name = "fstream-1.0.11.tgz";
      path = fetchurl {
        name = "fstream-1.0.11.tgz";
        url  = "https://registry.yarnpkg.com/fstream/-/fstream-1.0.11.tgz";
        sha1 = "5c1fb1f117477114f0632a0eb4b71b3cb0fd3171";
      };
    }

    {
      name = "function-bind-1.1.1.tgz";
      path = fetchurl {
        name = "function-bind-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/function-bind/-/function-bind-1.1.1.tgz";
        sha1 = "a56899d3ea3c9bab874bb9773b7c5ede92f4895d";
      };
    }

    {
      name = "function.name-polyfill-1.0.6.tgz";
      path = fetchurl {
        name = "function.name-polyfill-1.0.6.tgz";
        url  = "https://registry.yarnpkg.com/function.name-polyfill/-/function.name-polyfill-1.0.6.tgz";
        sha1 = "c54e37cae0a77dfcb49d47982815b0826b5c60d9";
      };
    }

    {
      name = "function.prototype.name-1.1.0.tgz";
      path = fetchurl {
        name = "function.prototype.name-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/function.prototype.name/-/function.prototype.name-1.1.0.tgz";
        sha1 = "8bd763cc0af860a859cc5d49384d74b932cd2327";
      };
    }

    {
      name = "functional-red-black-tree-1.0.1.tgz";
      path = fetchurl {
        name = "functional-red-black-tree-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/functional-red-black-tree/-/functional-red-black-tree-1.0.1.tgz";
        sha1 = "1b0ab3bd553b2a0d6399d29c0e3ea0b252078327";
      };
    }

    {
      name = "gauge-2.7.4.tgz";
      path = fetchurl {
        name = "gauge-2.7.4.tgz";
        url  = "https://registry.yarnpkg.com/gauge/-/gauge-2.7.4.tgz";
        sha1 = "2c03405c7538c39d7eb37b317022e325fb018bf7";
      };
    }

    {
      name = "gaze-1.1.3.tgz";
      path = fetchurl {
        name = "gaze-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/gaze/-/gaze-1.1.3.tgz";
        sha1 = "c441733e13b927ac8c0ff0b4c3b033f28812924a";
      };
    }

    {
      name = "generate-function-2.0.0.tgz";
      path = fetchurl {
        name = "generate-function-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/generate-function/-/generate-function-2.0.0.tgz";
        sha1 = "6858fe7c0969b7d4e9093337647ac79f60dfbe74";
      };
    }

    {
      name = "generate-object-property-1.2.0.tgz";
      path = fetchurl {
        name = "generate-object-property-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/generate-object-property/-/generate-object-property-1.2.0.tgz";
        sha1 = "9c0e1c40308ce804f4783618b937fa88f99d50d0";
      };
    }

    {
      name = "get-caller-file-1.0.2.tgz";
      path = fetchurl {
        name = "get-caller-file-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/get-caller-file/-/get-caller-file-1.0.2.tgz";
        sha1 = "f702e63127e7e231c160a80c1554acb70d5047e5";
      };
    }

    {
      name = "get-own-enumerable-property-symbols-2.0.1.tgz";
      path = fetchurl {
        name = "get-own-enumerable-property-symbols-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/get-own-enumerable-property-symbols/-/get-own-enumerable-property-symbols-2.0.1.tgz";
        sha1 = "5c4ad87f2834c4b9b4e84549dc1e0650fb38c24b";
      };
    }

    {
      name = "get-pkg-repo-1.4.0.tgz";
      path = fetchurl {
        name = "get-pkg-repo-1.4.0.tgz";
        url  = "https://registry.yarnpkg.com/get-pkg-repo/-/get-pkg-repo-1.4.0.tgz";
        sha1 = "c73b489c06d80cc5536c2c853f9e05232056972d";
      };
    }

    {
      name = "get-port-3.2.0.tgz";
      path = fetchurl {
        name = "get-port-3.2.0.tgz";
        url  = "https://registry.yarnpkg.com/get-port/-/get-port-3.2.0.tgz";
        sha1 = "dd7ce7de187c06c8bf353796ac71e099f0980ebc";
      };
    }

    {
      name = "get-stdin-4.0.1.tgz";
      path = fetchurl {
        name = "get-stdin-4.0.1.tgz";
        url  = "https://registry.yarnpkg.com/get-stdin/-/get-stdin-4.0.1.tgz";
        sha1 = "b968c6b0a04384324902e8bf1a5df32579a450fe";
      };
    }

    {
      name = "get-stdin-5.0.1.tgz";
      path = fetchurl {
        name = "get-stdin-5.0.1.tgz";
        url  = "https://registry.yarnpkg.com/get-stdin/-/get-stdin-5.0.1.tgz";
        sha1 = "122e161591e21ff4c52530305693f20e6393a398";
      };
    }

    {
      name = "get-stream-3.0.0.tgz";
      path = fetchurl {
        name = "get-stream-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/get-stream/-/get-stream-3.0.0.tgz";
        sha1 = "8e943d1358dc37555054ecbe2edb05aa174ede14";
      };
    }

    {
      name = "get-value-2.0.6.tgz";
      path = fetchurl {
        name = "get-value-2.0.6.tgz";
        url  = "https://registry.yarnpkg.com/get-value/-/get-value-2.0.6.tgz";
        sha1 = "dc15ca1c672387ca76bd37ac0a395ba2042a2c28";
      };
    }

    {
      name = "getpass-0.1.7.tgz";
      path = fetchurl {
        name = "getpass-0.1.7.tgz";
        url  = "https://registry.yarnpkg.com/getpass/-/getpass-0.1.7.tgz";
        sha1 = "5eff8e3e684d569ae4cb2b1282604e8ba62149fa";
      };
    }

    {
      name = "git-raw-commits-1.3.6.tgz";
      path = fetchurl {
        name = "git-raw-commits-1.3.6.tgz";
        url  = "https://registry.yarnpkg.com/git-raw-commits/-/git-raw-commits-1.3.6.tgz";
        sha1 = "27c35a32a67777c1ecd412a239a6c19d71b95aff";
      };
    }

    {
      name = "git-remote-origin-url-2.0.0.tgz";
      path = fetchurl {
        name = "git-remote-origin-url-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/git-remote-origin-url/-/git-remote-origin-url-2.0.0.tgz";
        sha1 = "5282659dae2107145a11126112ad3216ec5fa65f";
      };
    }

    {
      name = "git-semver-tags-1.3.6.tgz";
      path = fetchurl {
        name = "git-semver-tags-1.3.6.tgz";
        url  = "https://registry.yarnpkg.com/git-semver-tags/-/git-semver-tags-1.3.6.tgz";
        sha1 = "357ea01f7280794fe0927f2806bee6414d2caba5";
      };
    }

    {
      name = "gitconfiglocal-1.0.0.tgz";
      path = fetchurl {
        name = "gitconfiglocal-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/gitconfiglocal/-/gitconfiglocal-1.0.0.tgz";
        sha1 = "41d045f3851a5ea88f03f24ca1c6178114464b9b";
      };
    }

    {
      name = "github-slugger-1.2.0.tgz";
      path = fetchurl {
        name = "github-slugger-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/github-slugger/-/github-slugger-1.2.0.tgz";
        sha1 = "8ada3286fd046d8951c3c952a8d7854cfd90fd9a";
      };
    }

    {
      name = "glob-base-0.3.0.tgz";
      path = fetchurl {
        name = "glob-base-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/glob-base/-/glob-base-0.3.0.tgz";
        sha1 = "dbb164f6221b1c0b1ccf82aea328b497df0ea3c4";
      };
    }

    {
      name = "glob-parent-2.0.0.tgz";
      path = fetchurl {
        name = "glob-parent-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/glob-parent/-/glob-parent-2.0.0.tgz";
        sha1 = "81383d72db054fcccf5336daa902f182f6edbb28";
      };
    }

    {
      name = "glob-parent-3.1.0.tgz";
      path = fetchurl {
        name = "glob-parent-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/glob-parent/-/glob-parent-3.1.0.tgz";
        sha1 = "9e6af6299d8d3bd2bd40430832bd113df906c5ae";
      };
    }

    {
      name = "glob-5.0.15.tgz";
      path = fetchurl {
        name = "glob-5.0.15.tgz";
        url  = "https://registry.yarnpkg.com/glob/-/glob-5.0.15.tgz";
        sha1 = "1bc936b9e02f4a603fcc222ecf7633d30b8b93b1";
      };
    }

    {
      name = "glob-6.0.4.tgz";
      path = fetchurl {
        name = "glob-6.0.4.tgz";
        url  = "https://registry.yarnpkg.com/glob/-/glob-6.0.4.tgz";
        sha1 = "0f08860f6a155127b2fadd4f9ce24b1aab6e4d22";
      };
    }

    {
      name = "glob-7.1.2.tgz";
      path = fetchurl {
        name = "glob-7.1.2.tgz";
        url  = "https://registry.yarnpkg.com/glob/-/glob-7.1.2.tgz";
        sha1 = "c19c9df9a028702d678612384a6552404c636d15";
      };
    }

    {
      name = "global-modules-1.0.0.tgz";
      path = fetchurl {
        name = "global-modules-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/global-modules/-/global-modules-1.0.0.tgz";
        sha1 = "6d770f0eb523ac78164d72b5e71a8877265cc3ea";
      };
    }

    {
      name = "global-prefix-1.0.2.tgz";
      path = fetchurl {
        name = "global-prefix-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/global-prefix/-/global-prefix-1.0.2.tgz";
        sha1 = "dbf743c6c14992593c655568cb66ed32c0122ebe";
      };
    }

    {
      name = "global-4.3.2.tgz";
      path = fetchurl {
        name = "global-4.3.2.tgz";
        url  = "https://registry.yarnpkg.com/global/-/global-4.3.2.tgz";
        sha1 = "e76989268a6c74c38908b1305b10fc0e394e9d0f";
      };
    }

    {
      name = "globals-11.7.0.tgz";
      path = fetchurl {
        name = "globals-11.7.0.tgz";
        url  = "https://registry.yarnpkg.com/globals/-/globals-11.7.0.tgz";
        sha1 = "a583faa43055b1aca771914bf68258e2fc125673";
      };
    }

    {
      name = "globals-9.18.0.tgz";
      path = fetchurl {
        name = "globals-9.18.0.tgz";
        url  = "https://registry.yarnpkg.com/globals/-/globals-9.18.0.tgz";
        sha1 = "aa3896b3e69b487f17e31ed2143d69a8e30c2d8a";
      };
    }

    {
      name = "globby-3.0.1.tgz";
      path = fetchurl {
        name = "globby-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/globby/-/globby-3.0.1.tgz";
        sha1 = "2094af8421e19152150d5893eb6416b312d9a22f";
      };
    }

    {
      name = "globby-5.0.0.tgz";
      path = fetchurl {
        name = "globby-5.0.0.tgz";
        url  = "https://registry.yarnpkg.com/globby/-/globby-5.0.0.tgz";
        sha1 = "ebd84667ca0dbb330b99bcfc68eac2bc54370e0d";
      };
    }

    {
      name = "globby-6.1.0.tgz";
      path = fetchurl {
        name = "globby-6.1.0.tgz";
        url  = "https://registry.yarnpkg.com/globby/-/globby-6.1.0.tgz";
        sha1 = "f5a6d70e8395e21c858fb0489d64df02424d506c";
      };
    }

    {
      name = "globby-7.1.1.tgz";
      path = fetchurl {
        name = "globby-7.1.1.tgz";
        url  = "https://registry.yarnpkg.com/globby/-/globby-7.1.1.tgz";
        sha1 = "fb2ccff9401f8600945dfada97440cca972b8680";
      };
    }

    {
      name = "globjoin-0.1.4.tgz";
      path = fetchurl {
        name = "globjoin-0.1.4.tgz";
        url  = "https://registry.yarnpkg.com/globjoin/-/globjoin-0.1.4.tgz";
        sha1 = "2f4494ac8919e3767c5cbb691e9f463324285d43";
      };
    }

    {
      name = "globule-1.2.1.tgz";
      path = fetchurl {
        name = "globule-1.2.1.tgz";
        url  = "https://registry.yarnpkg.com/globule/-/globule-1.2.1.tgz";
        sha1 = "5dffb1b191f22d20797a9369b49eab4e9839696d";
      };
    }

    {
      name = "glogg-1.0.1.tgz";
      path = fetchurl {
        name = "glogg-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/glogg/-/glogg-1.0.1.tgz";
        sha1 = "dcf758e44789cc3f3d32c1f3562a3676e6a34810";
      };
    }

    {
      name = "gonzales-pe-4.2.3.tgz";
      path = fetchurl {
        name = "gonzales-pe-4.2.3.tgz";
        url  = "https://registry.yarnpkg.com/gonzales-pe/-/gonzales-pe-4.2.3.tgz";
        sha1 = "41091703625433285e0aee3aa47829fc1fbeb6f2";
      };
    }

    {
      name = "got-6.7.1.tgz";
      path = fetchurl {
        name = "got-6.7.1.tgz";
        url  = "https://registry.yarnpkg.com/got/-/got-6.7.1.tgz";
        sha1 = "240cd05785a9a18e561dc1b44b41c763ef1e8db0";
      };
    }

    {
      name = "graceful-fs-4.1.11.tgz";
      path = fetchurl {
        name = "graceful-fs-4.1.11.tgz";
        url  = "https://registry.yarnpkg.com/graceful-fs/-/graceful-fs-4.1.11.tgz";
        sha1 = "0e8bdfe4d1ddb8854d64e04ea7c00e2a026e5658";
      };
    }

    {
      name = "graphql-anywhere-4.1.14.tgz";
      path = fetchurl {
        name = "graphql-anywhere-4.1.14.tgz";
        url  = "https://registry.yarnpkg.com/graphql-anywhere/-/graphql-anywhere-4.1.14.tgz";
        sha1 = "89664cb885faaec1cbc66905351fadae8cc85a04";
      };
    }

    {
      name = "graphql-extensions-0.0.10.tgz";
      path = fetchurl {
        name = "graphql-extensions-0.0.10.tgz";
        url  = "https://registry.yarnpkg.com/graphql-extensions/-/graphql-extensions-0.0.10.tgz";
        sha1 = "34bdb2546d43f6a5bc89ab23c295ec0466c6843d";
      };
    }

    {
      name = "graphql-tag-2.9.2.tgz";
      path = fetchurl {
        name = "graphql-tag-2.9.2.tgz";
        url  = "https://registry.yarnpkg.com/graphql-tag/-/graphql-tag-2.9.2.tgz";
        sha1 = "2f60a5a981375f430bf1e6e95992427dc18af686";
      };
    }

    {
      name = "graphql-tools-2.24.0.tgz";
      path = fetchurl {
        name = "graphql-tools-2.24.0.tgz";
        url  = "https://registry.yarnpkg.com/graphql-tools/-/graphql-tools-2.24.0.tgz";
        sha1 = "bbacaad03924012a0edb8735a5e65df5d5563675";
      };
    }

    {
      name = "graphql-0.12.3.tgz";
      path = fetchurl {
        name = "graphql-0.12.3.tgz";
        url  = "https://registry.yarnpkg.com/graphql/-/graphql-0.12.3.tgz";
        sha1 = "11668458bbe28261c0dcb6e265f515ba79f6ce07";
      };
    }

    {
      name = "graphql-0.13.2.tgz";
      path = fetchurl {
        name = "graphql-0.13.2.tgz";
        url  = "https://registry.yarnpkg.com/graphql/-/graphql-0.13.2.tgz";
        sha1 = "4c740ae3c222823e7004096f832e7b93b2108270";
      };
    }

    {
      name = "growly-1.3.0.tgz";
      path = fetchurl {
        name = "growly-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/growly/-/growly-1.3.0.tgz";
        sha1 = "f10748cbe76af964b7c96c93c6bcc28af120c081";
      };
    }

    {
      name = "gzip-size-3.0.0.tgz";
      path = fetchurl {
        name = "gzip-size-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/gzip-size/-/gzip-size-3.0.0.tgz";
        sha1 = "546188e9bdc337f673772f81660464b389dce520";
      };
    }

    {
      name = "handle-thing-1.2.5.tgz";
      path = fetchurl {
        name = "handle-thing-1.2.5.tgz";
        url  = "https://registry.yarnpkg.com/handle-thing/-/handle-thing-1.2.5.tgz";
        sha1 = "fd7aad726bf1a5fd16dfc29b2f7a6601d27139c4";
      };
    }

    {
      name = "handlebars-4.0.11.tgz";
      path = fetchurl {
        name = "handlebars-4.0.11.tgz";
        url  = "https://registry.yarnpkg.com/handlebars/-/handlebars-4.0.11.tgz";
        sha1 = "630a35dfe0294bc281edae6ffc5d329fc7982dcc";
      };
    }

    {
      name = "har-schema-1.0.5.tgz";
      path = fetchurl {
        name = "har-schema-1.0.5.tgz";
        url  = "https://registry.yarnpkg.com/har-schema/-/har-schema-1.0.5.tgz";
        sha1 = "d263135f43307c02c602afc8fe95970c0151369e";
      };
    }

    {
      name = "har-schema-2.0.0.tgz";
      path = fetchurl {
        name = "har-schema-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/har-schema/-/har-schema-2.0.0.tgz";
        sha1 = "a94c2224ebcac04782a0d9035521f24735b7ec92";
      };
    }

    {
      name = "har-validator-4.2.1.tgz";
      path = fetchurl {
        name = "har-validator-4.2.1.tgz";
        url  = "https://registry.yarnpkg.com/har-validator/-/har-validator-4.2.1.tgz";
        sha1 = "33481d0f1bbff600dd203d75812a6a5fba002e2a";
      };
    }

    {
      name = "har-validator-5.0.3.tgz";
      path = fetchurl {
        name = "har-validator-5.0.3.tgz";
        url  = "https://registry.yarnpkg.com/har-validator/-/har-validator-5.0.3.tgz";
        sha1 = "ba402c266194f15956ef15e0fcf242993f6a7dfd";
      };
    }

    {
      name = "harmony-reflect-1.6.0.tgz";
      path = fetchurl {
        name = "harmony-reflect-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/harmony-reflect/-/harmony-reflect-1.6.0.tgz";
        sha1 = "9c28a77386ec225f7b5d370f9861ba09c4eea58f";
      };
    }

    {
      name = "has-ansi-2.0.0.tgz";
      path = fetchurl {
        name = "has-ansi-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/has-ansi/-/has-ansi-2.0.0.tgz";
        sha1 = "34f5049ce1ecdf2b0649af3ef24e45ed35416d91";
      };
    }

    {
      name = "has-flag-1.0.0.tgz";
      path = fetchurl {
        name = "has-flag-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/has-flag/-/has-flag-1.0.0.tgz";
        sha1 = "9d9e793165ce017a00f00418c43f942a7b1d11fa";
      };
    }

    {
      name = "has-flag-2.0.0.tgz";
      path = fetchurl {
        name = "has-flag-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/has-flag/-/has-flag-2.0.0.tgz";
        sha1 = "e8207af1cc7b30d446cc70b734b5e8be18f88d51";
      };
    }

    {
      name = "has-flag-3.0.0.tgz";
      path = fetchurl {
        name = "has-flag-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/has-flag/-/has-flag-3.0.0.tgz";
        sha1 = "b5d454dc2199ae225699f3467e5a07f3b955bafd";
      };
    }

    {
      name = "has-own-property-x-3.2.0.tgz";
      path = fetchurl {
        name = "has-own-property-x-3.2.0.tgz";
        url  = "https://registry.yarnpkg.com/has-own-property-x/-/has-own-property-x-3.2.0.tgz";
        sha1 = "1c4b112a577c8cb5805469556e54b6e959e4ded9";
      };
    }

    {
      name = "has-symbol-support-x-1.4.2.tgz";
      path = fetchurl {
        name = "has-symbol-support-x-1.4.2.tgz";
        url  = "https://registry.yarnpkg.com/has-symbol-support-x/-/has-symbol-support-x-1.4.2.tgz";
        sha1 = "1409f98bc00247da45da67cee0a36f282ff26455";
      };
    }

    {
      name = "has-symbols-1.0.0.tgz";
      path = fetchurl {
        name = "has-symbols-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/has-symbols/-/has-symbols-1.0.0.tgz";
        sha1 = "ba1a8f1af2a0fc39650f5c850367704122063b44";
      };
    }

    {
      name = "has-to-string-tag-x-1.4.1.tgz";
      path = fetchurl {
        name = "has-to-string-tag-x-1.4.1.tgz";
        url  = "https://registry.yarnpkg.com/has-to-string-tag-x/-/has-to-string-tag-x-1.4.1.tgz";
        sha1 = "a045ab383d7b4b2012a00148ab0aa5f290044d4d";
      };
    }

    {
      name = "has-unicode-2.0.1.tgz";
      path = fetchurl {
        name = "has-unicode-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/has-unicode/-/has-unicode-2.0.1.tgz";
        sha1 = "e0e6fe6a28cf51138855e086d1691e771de2a8b9";
      };
    }

    {
      name = "has-value-0.3.1.tgz";
      path = fetchurl {
        name = "has-value-0.3.1.tgz";
        url  = "https://registry.yarnpkg.com/has-value/-/has-value-0.3.1.tgz";
        sha1 = "7b1f58bada62ca827ec0a2078025654845995e1f";
      };
    }

    {
      name = "has-value-1.0.0.tgz";
      path = fetchurl {
        name = "has-value-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/has-value/-/has-value-1.0.0.tgz";
        sha1 = "18b281da585b1c5c51def24c930ed29a0be6b177";
      };
    }

    {
      name = "has-values-0.1.4.tgz";
      path = fetchurl {
        name = "has-values-0.1.4.tgz";
        url  = "https://registry.yarnpkg.com/has-values/-/has-values-0.1.4.tgz";
        sha1 = "6d61de95d91dfca9b9a02089ad384bff8f62b771";
      };
    }

    {
      name = "has-values-1.0.0.tgz";
      path = fetchurl {
        name = "has-values-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/has-values/-/has-values-1.0.0.tgz";
        sha1 = "95b0b63fec2146619a6fe57fe75628d5a39efe4f";
      };
    }

    {
      name = "has-1.0.3.tgz";
      path = fetchurl {
        name = "has-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/has/-/has-1.0.3.tgz";
        sha1 = "722d7cbfc1f6aa8241f16dd814e011e1f41e8796";
      };
    }

    {
      name = "hash-base-3.0.4.tgz";
      path = fetchurl {
        name = "hash-base-3.0.4.tgz";
        url  = "https://registry.yarnpkg.com/hash-base/-/hash-base-3.0.4.tgz";
        sha1 = "5fc8686847ecd73499403319a6b0a3f3f6ae4918";
      };
    }

    {
      name = "hash.js-1.1.5.tgz";
      path = fetchurl {
        name = "hash.js-1.1.5.tgz";
        url  = "https://registry.yarnpkg.com/hash.js/-/hash.js-1.1.5.tgz";
        sha1 = "e38ab4b85dfb1e0c40fe9265c0e9b54854c23812";
      };
    }

    {
      name = "hawk-3.1.3.tgz";
      path = fetchurl {
        name = "hawk-3.1.3.tgz";
        url  = "https://registry.yarnpkg.com/hawk/-/hawk-3.1.3.tgz";
        sha1 = "078444bd7c1640b0fe540d2c9b73d59678e8e1c4";
      };
    }

    {
      name = "he-1.1.1.tgz";
      path = fetchurl {
        name = "he-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/he/-/he-1.1.1.tgz";
        sha1 = "93410fd21b009735151f8868c2f271f3427e23fd";
      };
    }

    {
      name = "helmet-csp-2.7.0.tgz";
      path = fetchurl {
        name = "helmet-csp-2.7.0.tgz";
        url  = "https://registry.yarnpkg.com/helmet-csp/-/helmet-csp-2.7.0.tgz";
        sha1 = "7934094617d1feb7bb2dc43bb7d9e8830f774716";
      };
    }

    {
      name = "helmet-3.12.1.tgz";
      path = fetchurl {
        name = "helmet-3.12.1.tgz";
        url  = "https://registry.yarnpkg.com/helmet/-/helmet-3.12.1.tgz";
        sha1 = "8b05bbd60f3966d70f13dad0de2c1d6c1a8303f1";
      };
    }

    {
      name = "hide-powered-by-1.0.0.tgz";
      path = fetchurl {
        name = "hide-powered-by-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/hide-powered-by/-/hide-powered-by-1.0.0.tgz";
        sha1 = "4a85ad65881f62857fc70af7174a1184dccce32b";
      };
    }

    {
      name = "highlight-es-1.0.3.tgz";
      path = fetchurl {
        name = "highlight-es-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/highlight-es/-/highlight-es-1.0.3.tgz";
        sha1 = "12abc300a27e686f6f18010134e3a5c6d2fe6930";
      };
    }

    {
      name = "highlight.js-9.12.0.tgz";
      path = fetchurl {
        name = "highlight.js-9.12.0.tgz";
        url  = "https://registry.yarnpkg.com/highlight.js/-/highlight.js-9.12.0.tgz";
        sha1 = "e6d9dbe57cbefe60751f02af336195870c90c01e";
      };
    }

    {
      name = "highlightjs-9.10.0.tgz";
      path = fetchurl {
        name = "highlightjs-9.10.0.tgz";
        url  = "https://registry.yarnpkg.com/highlightjs/-/highlightjs-9.10.0.tgz";
        sha1 = "fca9b78ddaa3b1abca89d6c3ee105ad270a80190";
      };
    }

    {
      name = "history-4.7.2.tgz";
      path = fetchurl {
        name = "history-4.7.2.tgz";
        url  = "https://registry.yarnpkg.com/history/-/history-4.7.2.tgz";
        sha1 = "22b5c7f31633c5b8021c7f4a8a954ac139ee8d5b";
      };
    }

    {
      name = "hmac-drbg-1.0.1.tgz";
      path = fetchurl {
        name = "hmac-drbg-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/hmac-drbg/-/hmac-drbg-1.0.1.tgz";
        sha1 = "d2745701025a6c775a6c545793ed502fc0c649a1";
      };
    }

    {
      name = "hoek-2.16.3.tgz";
      path = fetchurl {
        name = "hoek-2.16.3.tgz";
        url  = "https://registry.yarnpkg.com/hoek/-/hoek-2.16.3.tgz";
        sha1 = "20bb7403d3cea398e91dc4710a8ff1b8274a25ed";
      };
    }

    {
      name = "hoek-4.2.1.tgz";
      path = fetchurl {
        name = "hoek-4.2.1.tgz";
        url  = "https://registry.yarnpkg.com/hoek/-/hoek-4.2.1.tgz";
        sha1 = "9634502aa12c445dd5a7c5734b572bb8738aacbb";
      };
    }

    {
      name = "hoek-5.0.3.tgz";
      path = fetchurl {
        name = "hoek-5.0.3.tgz";
        url  = "https://registry.yarnpkg.com/hoek/-/hoek-5.0.3.tgz";
        sha1 = "b71d40d943d0a95da01956b547f83c4a5b4a34ac";
      };
    }

    {
      name = "hoist-non-react-statics-1.2.0.tgz";
      path = fetchurl {
        name = "hoist-non-react-statics-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/hoist-non-react-statics/-/hoist-non-react-statics-1.2.0.tgz";
        sha1 = "aa448cf0986d55cc40773b17174b7dd066cb7cfb";
      };
    }

    {
      name = "hoist-non-react-statics-2.5.5.tgz";
      path = fetchurl {
        name = "hoist-non-react-statics-2.5.5.tgz";
        url  = "https://registry.yarnpkg.com/hoist-non-react-statics/-/hoist-non-react-statics-2.5.5.tgz";
        sha1 = "c5903cf409c0dfd908f388e619d86b9c1174cb47";
      };
    }

    {
      name = "home-or-tmp-2.0.0.tgz";
      path = fetchurl {
        name = "home-or-tmp-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/home-or-tmp/-/home-or-tmp-2.0.0.tgz";
        sha1 = "e36c3f2d2cae7d746a857e38d18d5f32a7882db8";
      };
    }

    {
      name = "homedir-polyfill-1.0.1.tgz";
      path = fetchurl {
        name = "homedir-polyfill-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/homedir-polyfill/-/homedir-polyfill-1.0.1.tgz";
        sha1 = "4c2bbc8a758998feebf5ed68580f76d46768b4bc";
      };
    }

    {
      name = "hosted-git-info-2.7.1.tgz";
      path = fetchurl {
        name = "hosted-git-info-2.7.1.tgz";
        url  = "https://registry.yarnpkg.com/hosted-git-info/-/hosted-git-info-2.7.1.tgz";
        sha1 = "97f236977bd6e125408930ff6de3eec6281ec047";
      };
    }

    {
      name = "hpack.js-2.1.6.tgz";
      path = fetchurl {
        name = "hpack.js-2.1.6.tgz";
        url  = "https://registry.yarnpkg.com/hpack.js/-/hpack.js-2.1.6.tgz";
        sha1 = "87774c0949e513f42e84575b3c45681fade2a0b2";
      };
    }

    {
      name = "hpkp-2.0.0.tgz";
      path = fetchurl {
        name = "hpkp-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/hpkp/-/hpkp-2.0.0.tgz";
        sha1 = "10e142264e76215a5d30c44ec43de64dee6d1672";
      };
    }

    {
      name = "hsts-2.1.0.tgz";
      path = fetchurl {
        name = "hsts-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/hsts/-/hsts-2.1.0.tgz";
        sha1 = "cbd6c918a2385fee1dd5680bfb2b3a194c0121cc";
      };
    }

    {
      name = "html-comment-regex-1.1.1.tgz";
      path = fetchurl {
        name = "html-comment-regex-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/html-comment-regex/-/html-comment-regex-1.1.1.tgz";
        sha1 = "668b93776eaae55ebde8f3ad464b307a4963625e";
      };
    }

    {
      name = "html-encoding-sniffer-1.0.2.tgz";
      path = fetchurl {
        name = "html-encoding-sniffer-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/html-encoding-sniffer/-/html-encoding-sniffer-1.0.2.tgz";
        sha1 = "e70d84b94da53aa375e11fe3a351be6642ca46f8";
      };
    }

    {
      name = "html-entities-1.2.1.tgz";
      path = fetchurl {
        name = "html-entities-1.2.1.tgz";
        url  = "https://registry.yarnpkg.com/html-entities/-/html-entities-1.2.1.tgz";
        sha1 = "0df29351f0721163515dfb9e5543e5f6eed5162f";
      };
    }

    {
      name = "html-epub-0.7.0.tgz";
      path = fetchurl {
        name = "html-epub-0.7.0.tgz";
        url  = "https://registry.yarnpkg.com/html-epub/-/html-epub-0.7.0.tgz";
        sha1 = "962594124055ed6108f8053781d3116e50fc390a";
      };
    }

    {
      name = "html-minifier-3.5.18.tgz";
      path = fetchurl {
        name = "html-minifier-3.5.18.tgz";
        url  = "https://registry.yarnpkg.com/html-minifier/-/html-minifier-3.5.18.tgz";
        sha1 = "fc8b02826cbbafc6de19a103c41c830a91cffe5a";
      };
    }

    {
      name = "html-tags-2.0.0.tgz";
      path = fetchurl {
        name = "html-tags-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/html-tags/-/html-tags-2.0.0.tgz";
        sha1 = "10b30a386085f43cede353cc8fa7cb0deeea668b";
      };
    }

    {
      name = "html-webpack-plugin-2.30.1.tgz";
      path = fetchurl {
        name = "html-webpack-plugin-2.30.1.tgz";
        url  = "https://registry.yarnpkg.com/html-webpack-plugin/-/html-webpack-plugin-2.30.1.tgz";
        sha1 = "7f9c421b7ea91ec460f56527d78df484ee7537d5";
      };
    }

    {
      name = "htmlparser2-3.9.2.tgz";
      path = fetchurl {
        name = "htmlparser2-3.9.2.tgz";
        url  = "https://registry.yarnpkg.com/htmlparser2/-/htmlparser2-3.9.2.tgz";
        sha1 = "1bdf87acca0f3f9e53fa4fcceb0f4b4cbb00b338";
      };
    }

    {
      name = "htmlparser2-3.3.0.tgz";
      path = fetchurl {
        name = "htmlparser2-3.3.0.tgz";
        url  = "https://registry.yarnpkg.com/htmlparser2/-/htmlparser2-3.3.0.tgz";
        sha1 = "cc70d05a59f6542e43f0e685c982e14c924a9efe";
      };
    }

    {
      name = "http-deceiver-1.2.7.tgz";
      path = fetchurl {
        name = "http-deceiver-1.2.7.tgz";
        url  = "https://registry.yarnpkg.com/http-deceiver/-/http-deceiver-1.2.7.tgz";
        sha1 = "fa7168944ab9a519d337cb0bec7284dc3e723d87";
      };
    }

    {
      name = "http-errors-1.6.2.tgz";
      path = fetchurl {
        name = "http-errors-1.6.2.tgz";
        url  = "https://registry.yarnpkg.com/http-errors/-/http-errors-1.6.2.tgz";
        sha1 = "0a002cc85707192a7e7946ceedc11155f60ec736";
      };
    }

    {
      name = "http-errors-1.6.3.tgz";
      path = fetchurl {
        name = "http-errors-1.6.3.tgz";
        url  = "https://registry.yarnpkg.com/http-errors/-/http-errors-1.6.3.tgz";
        sha1 = "8b55680bb4be283a0b5bf4ea2e38580be1d9320d";
      };
    }

    {
      name = "http-parser-js-0.4.13.tgz";
      path = fetchurl {
        name = "http-parser-js-0.4.13.tgz";
        url  = "https://registry.yarnpkg.com/http-parser-js/-/http-parser-js-0.4.13.tgz";
        sha1 = "3bd6d6fde6e3172c9334c3b33b6c193d80fe1137";
      };
    }

    {
      name = "http-proxy-middleware-0.17.4.tgz";
      path = fetchurl {
        name = "http-proxy-middleware-0.17.4.tgz";
        url  = "https://registry.yarnpkg.com/http-proxy-middleware/-/http-proxy-middleware-0.17.4.tgz";
        sha1 = "642e8848851d66f09d4f124912846dbaeb41b833";
      };
    }

    {
      name = "http-proxy-1.17.0.tgz";
      path = fetchurl {
        name = "http-proxy-1.17.0.tgz";
        url  = "https://registry.yarnpkg.com/http-proxy/-/http-proxy-1.17.0.tgz";
        sha1 = "7ad38494658f84605e2f6db4436df410f4e5be9a";
      };
    }

    {
      name = "http-signature-1.1.1.tgz";
      path = fetchurl {
        name = "http-signature-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/http-signature/-/http-signature-1.1.1.tgz";
        sha1 = "df72e267066cd0ac67fb76adf8e134a8fbcf91bf";
      };
    }

    {
      name = "http-signature-1.2.0.tgz";
      path = fetchurl {
        name = "http-signature-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/http-signature/-/http-signature-1.2.0.tgz";
        sha1 = "9aecd925114772f3d95b65a60abb8f7c18fbace1";
      };
    }

    {
      name = "http-status-codes-1.3.0.tgz";
      path = fetchurl {
        name = "http-status-codes-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/http-status-codes/-/http-status-codes-1.3.0.tgz";
        sha1 = "9cd0e71391773d0671b489d41cbc5094aa4163b6";
      };
    }

    {
      name = "https-browserify-1.0.0.tgz";
      path = fetchurl {
        name = "https-browserify-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/https-browserify/-/https-browserify-1.0.0.tgz";
        sha1 = "ec06c10e0a34c0f2faf199f7fd7fc78fffd03c73";
      };
    }

    {
      name = "husky-0.14.3.tgz";
      path = fetchurl {
        name = "husky-0.14.3.tgz";
        url  = "https://registry.yarnpkg.com/husky/-/husky-0.14.3.tgz";
        sha1 = "c69ed74e2d2779769a17ba8399b54ce0b63c12c3";
      };
    }

    {
      name = "hyphenate-style-name-1.0.2.tgz";
      path = fetchurl {
        name = "hyphenate-style-name-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/hyphenate-style-name/-/hyphenate-style-name-1.0.2.tgz";
        sha1 = "31160a36930adaf1fc04c6074f7eb41465d4ec4b";
      };
    }

    {
      name = "i-0.3.6.tgz";
      path = fetchurl {
        name = "i-0.3.6.tgz";
        url  = "https://registry.yarnpkg.com/i/-/i-0.3.6.tgz";
        sha1 = "d96c92732076f072711b6b10fd7d4f65ad8ee23d";
      };
    }

    {
      name = "iconv-lite-0.4.11.tgz";
      path = fetchurl {
        name = "iconv-lite-0.4.11.tgz";
        url  = "https://registry.yarnpkg.com/iconv-lite/-/iconv-lite-0.4.11.tgz";
        sha1 = "2ecb42fd294744922209a2e7c404dac8793d8ade";
      };
    }

    {
      name = "iconv-lite-0.4.19.tgz";
      path = fetchurl {
        name = "iconv-lite-0.4.19.tgz";
        url  = "https://registry.yarnpkg.com/iconv-lite/-/iconv-lite-0.4.19.tgz";
        sha1 = "f7468f60135f5e5dad3399c0a81be9a1603a082b";
      };
    }

    {
      name = "iconv-lite-0.4.23.tgz";
      path = fetchurl {
        name = "iconv-lite-0.4.23.tgz";
        url  = "https://registry.yarnpkg.com/iconv-lite/-/iconv-lite-0.4.23.tgz";
        sha1 = "297871f63be507adcfbfca715d0cd0eed84e9a63";
      };
    }

    {
      name = "icss-replace-symbols-1.1.0.tgz";
      path = fetchurl {
        name = "icss-replace-symbols-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/icss-replace-symbols/-/icss-replace-symbols-1.1.0.tgz";
        sha1 = "06ea6f83679a7749e386cfe1fe812ae5db223ded";
      };
    }

    {
      name = "icss-utils-2.1.0.tgz";
      path = fetchurl {
        name = "icss-utils-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/icss-utils/-/icss-utils-2.1.0.tgz";
        sha1 = "83f0a0ec378bf3246178b6c2ad9136f135b1c962";
      };
    }

    {
      name = "identity-obj-proxy-3.0.0.tgz";
      path = fetchurl {
        name = "identity-obj-proxy-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/identity-obj-proxy/-/identity-obj-proxy-3.0.0.tgz";
        sha1 = "94d2bda96084453ef36fbc5aaec37e0f79f1fc14";
      };
    }

    {
      name = "ieee754-1.1.12.tgz";
      path = fetchurl {
        name = "ieee754-1.1.12.tgz";
        url  = "https://registry.yarnpkg.com/ieee754/-/ieee754-1.1.12.tgz";
        sha1 = "50bf24e5b9c8bb98af4964c941cdb0918da7b60b";
      };
    }

    {
      name = "ienoopen-1.0.0.tgz";
      path = fetchurl {
        name = "ienoopen-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/ienoopen/-/ienoopen-1.0.0.tgz";
        sha1 = "346a428f474aac8f50cf3784ea2d0f16f62bda6b";
      };
    }

    {
      name = "iferr-0.1.5.tgz";
      path = fetchurl {
        name = "iferr-0.1.5.tgz";
        url  = "https://registry.yarnpkg.com/iferr/-/iferr-0.1.5.tgz";
        sha1 = "c60eed69e6d8fdb6b3104a1fcbca1c192dc5b501";
      };
    }

    {
      name = "ignore-walk-3.0.1.tgz";
      path = fetchurl {
        name = "ignore-walk-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/ignore-walk/-/ignore-walk-3.0.1.tgz";
        sha1 = "a83e62e7d272ac0e3b551aaa82831a19b69f82f8";
      };
    }

    {
      name = "ignore-3.3.10.tgz";
      path = fetchurl {
        name = "ignore-3.3.10.tgz";
        url  = "https://registry.yarnpkg.com/ignore/-/ignore-3.3.10.tgz";
        sha1 = "0a97fb876986e8081c631160f8f9f389157f0043";
      };
    }

    {
      name = "immediate-3.0.6.tgz";
      path = fetchurl {
        name = "immediate-3.0.6.tgz";
        url  = "https://registry.yarnpkg.com/immediate/-/immediate-3.0.6.tgz";
        sha1 = "9db1dbd0faf8de6fbe0f5dd5e56bb606280de69b";
      };
    }

    {
      name = "immediate-3.2.3.tgz";
      path = fetchurl {
        name = "immediate-3.2.3.tgz";
        url  = "https://registry.yarnpkg.com/immediate/-/immediate-3.2.3.tgz";
        sha1 = "d140fa8f614659bd6541233097ddaac25cdd991c";
      };
    }

    {
      name = "import-local-1.0.0.tgz";
      path = fetchurl {
        name = "import-local-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/import-local/-/import-local-1.0.0.tgz";
        sha1 = "5e4ffdc03f4fe6c009c6729beb29631c2f8227bc";
      };
    }

    {
      name = "imurmurhash-0.1.4.tgz";
      path = fetchurl {
        name = "imurmurhash-0.1.4.tgz";
        url  = "https://registry.yarnpkg.com/imurmurhash/-/imurmurhash-0.1.4.tgz";
        sha1 = "9218b9b2b928a238b13dc4fb6b6d576f231453ea";
      };
    }

    {
      name = "in-publish-2.0.0.tgz";
      path = fetchurl {
        name = "in-publish-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/in-publish/-/in-publish-2.0.0.tgz";
        sha1 = "e20ff5e3a2afc2690320b6dc552682a9c7fadf51";
      };
    }

    {
      name = "indent-string-1.2.2.tgz";
      path = fetchurl {
        name = "indent-string-1.2.2.tgz";
        url  = "https://registry.yarnpkg.com/indent-string/-/indent-string-1.2.2.tgz";
        sha1 = "db99bcc583eb6abbb1e48dcbb1999a986041cb6b";
      };
    }

    {
      name = "indent-string-2.1.0.tgz";
      path = fetchurl {
        name = "indent-string-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/indent-string/-/indent-string-2.1.0.tgz";
        sha1 = "8e2d48348742121b4a8218b7a137e9a52049dc80";
      };
    }

    {
      name = "indent-string-3.2.0.tgz";
      path = fetchurl {
        name = "indent-string-3.2.0.tgz";
        url  = "https://registry.yarnpkg.com/indent-string/-/indent-string-3.2.0.tgz";
        sha1 = "4a5fd6d27cc332f37e5419a504dbb837105c9289";
      };
    }

    {
      name = "indexes-of-1.0.1.tgz";
      path = fetchurl {
        name = "indexes-of-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/indexes-of/-/indexes-of-1.0.1.tgz";
        sha1 = "f30f716c8e2bd346c7b67d3df3915566a7c05607";
      };
    }

    {
      name = "indexof-0.0.1.tgz";
      path = fetchurl {
        name = "indexof-0.0.1.tgz";
        url  = "https://registry.yarnpkg.com/indexof/-/indexof-0.0.1.tgz";
        sha1 = "82dc336d232b9062179d05ab3293a66059fd435d";
      };
    }

    {
      name = "infinity-x-1.0.2.tgz";
      path = fetchurl {
        name = "infinity-x-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/infinity-x/-/infinity-x-1.0.2.tgz";
        sha1 = "374a4d5c8a9b98d2f61b782fc63892598de2f14c";
      };
    }

    {
      name = "inflection-1.12.0.tgz";
      path = fetchurl {
        name = "inflection-1.12.0.tgz";
        url  = "https://registry.yarnpkg.com/inflection/-/inflection-1.12.0.tgz";
        sha1 = "a200935656d6f5f6bc4dc7502e1aecb703228416";
      };
    }

    {
      name = "inflight-1.0.6.tgz";
      path = fetchurl {
        name = "inflight-1.0.6.tgz";
        url  = "https://registry.yarnpkg.com/inflight/-/inflight-1.0.6.tgz";
        sha1 = "49bd6331d7d02d0c09bc910a1075ba8165b56df9";
      };
    }

    {
      name = "inherits-2.0.3.tgz";
      path = fetchurl {
        name = "inherits-2.0.3.tgz";
        url  = "https://registry.yarnpkg.com/inherits/-/inherits-2.0.3.tgz";
        sha1 = "633c2c83e3da42a502f52466022480f4208261de";
      };
    }

    {
      name = "inherits-2.0.1.tgz";
      path = fetchurl {
        name = "inherits-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/inherits/-/inherits-2.0.1.tgz";
        sha1 = "b17d08d326b4423e568eff719f91b0b1cbdf69f1";
      };
    }

    {
      name = "ini-1.3.5.tgz";
      path = fetchurl {
        name = "ini-1.3.5.tgz";
        url  = "https://registry.yarnpkg.com/ini/-/ini-1.3.5.tgz";
        sha1 = "eee25f56db1c9ec6085e0c22778083f596abf927";
      };
    }

    {
      name = "inquirer-3.3.0.tgz";
      path = fetchurl {
        name = "inquirer-3.3.0.tgz";
        url  = "https://registry.yarnpkg.com/inquirer/-/inquirer-3.3.0.tgz";
        sha1 = "9dd2f2ad765dcab1ff0443b491442a20ba227dc9";
      };
    }

    {
      name = "inquirer-0.12.0.tgz";
      path = fetchurl {
        name = "inquirer-0.12.0.tgz";
        url  = "https://registry.yarnpkg.com/inquirer/-/inquirer-0.12.0.tgz";
        sha1 = "1ef2bfd63504df0bc75785fff8c2c41df12f077e";
      };
    }

    {
      name = "internal-ip-1.2.0.tgz";
      path = fetchurl {
        name = "internal-ip-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/internal-ip/-/internal-ip-1.2.0.tgz";
        sha1 = "ae9fbf93b984878785d50a8de1b356956058cf5c";
      };
    }

    {
      name = "interpret-1.1.0.tgz";
      path = fetchurl {
        name = "interpret-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/interpret/-/interpret-1.1.0.tgz";
        sha1 = "7ed1b1410c6a0e0f78cf95d3b8440c63f78b8614";
      };
    }

    {
      name = "invariant-2.2.4.tgz";
      path = fetchurl {
        name = "invariant-2.2.4.tgz";
        url  = "https://registry.yarnpkg.com/invariant/-/invariant-2.2.4.tgz";
        sha1 = "610f3c92c9359ce1db616e538008d23ff35158e6";
      };
    }

    {
      name = "invert-kv-1.0.0.tgz";
      path = fetchurl {
        name = "invert-kv-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/invert-kv/-/invert-kv-1.0.0.tgz";
        sha1 = "104a8e4aaca6d3d8cd157a8ef8bfab2d7a3ffdb6";
      };
    }

    {
      name = "ip-1.1.5.tgz";
      path = fetchurl {
        name = "ip-1.1.5.tgz";
        url  = "https://registry.yarnpkg.com/ip/-/ip-1.1.5.tgz";
        sha1 = "bdded70114290828c0a039e72ef25f5aaec4354a";
      };
    }

    {
      name = "ipaddr.js-1.6.0.tgz";
      path = fetchurl {
        name = "ipaddr.js-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/ipaddr.js/-/ipaddr.js-1.6.0.tgz";
        sha1 = "e3fa357b773da619f26e95f049d055c72796f86b";
      };
    }

    {
      name = "ipv6-normalize-1.0.1.tgz";
      path = fetchurl {
        name = "ipv6-normalize-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/ipv6-normalize/-/ipv6-normalize-1.0.1.tgz";
        sha1 = "1b3258290d365fa83239e89907dde4592e7620a8";
      };
    }

    {
      name = "is-absolute-url-2.1.0.tgz";
      path = fetchurl {
        name = "is-absolute-url-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/is-absolute-url/-/is-absolute-url-2.1.0.tgz";
        sha1 = "50530dfb84fcc9aa7dbe7852e83a37b93b9f2aa6";
      };
    }

    {
      name = "is-accessor-descriptor-0.1.6.tgz";
      path = fetchurl {
        name = "is-accessor-descriptor-0.1.6.tgz";
        url  = "https://registry.yarnpkg.com/is-accessor-descriptor/-/is-accessor-descriptor-0.1.6.tgz";
        sha1 = "a9e12cb3ae8d876727eeef3843f8a0897b5c98d6";
      };
    }

    {
      name = "is-accessor-descriptor-1.0.0.tgz";
      path = fetchurl {
        name = "is-accessor-descriptor-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-accessor-descriptor/-/is-accessor-descriptor-1.0.0.tgz";
        sha1 = "169c2f6d3df1f992618072365c9b0ea1f6878656";
      };
    }

    {
      name = "is-alphabetical-1.0.2.tgz";
      path = fetchurl {
        name = "is-alphabetical-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/is-alphabetical/-/is-alphabetical-1.0.2.tgz";
        sha1 = "1fa6e49213cb7885b75d15862fb3f3d96c884f41";
      };
    }

    {
      name = "is-alphanumeric-1.0.0.tgz";
      path = fetchurl {
        name = "is-alphanumeric-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-alphanumeric/-/is-alphanumeric-1.0.0.tgz";
        sha1 = "4a9cef71daf4c001c1d81d63d140cf53fd6889f4";
      };
    }

    {
      name = "is-alphanumerical-1.0.2.tgz";
      path = fetchurl {
        name = "is-alphanumerical-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/is-alphanumerical/-/is-alphanumerical-1.0.2.tgz";
        sha1 = "1138e9ae5040158dc6ff76b820acd6b7a181fd40";
      };
    }

    {
      name = "is-array-buffer-x-1.7.0.tgz";
      path = fetchurl {
        name = "is-array-buffer-x-1.7.0.tgz";
        url  = "https://registry.yarnpkg.com/is-array-buffer-x/-/is-array-buffer-x-1.7.0.tgz";
        sha1 = "4b0b10427b64aa3437767adf4fc07702c59b2371";
      };
    }

    {
      name = "is-arrayish-0.2.1.tgz";
      path = fetchurl {
        name = "is-arrayish-0.2.1.tgz";
        url  = "https://registry.yarnpkg.com/is-arrayish/-/is-arrayish-0.2.1.tgz";
        sha1 = "77c99840527aa8ecb1a8ba697b80645a7a926a9d";
      };
    }

    {
      name = "is-binary-path-1.0.1.tgz";
      path = fetchurl {
        name = "is-binary-path-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/is-binary-path/-/is-binary-path-1.0.1.tgz";
        sha1 = "75f16642b480f187a711c814161fd3a4a7655898";
      };
    }

    {
      name = "is-boolean-object-1.0.0.tgz";
      path = fetchurl {
        name = "is-boolean-object-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-boolean-object/-/is-boolean-object-1.0.0.tgz";
        sha1 = "98f8b28030684219a95f375cfbd88ce3405dff93";
      };
    }

    {
      name = "is-buffer-1.1.6.tgz";
      path = fetchurl {
        name = "is-buffer-1.1.6.tgz";
        url  = "https://registry.yarnpkg.com/is-buffer/-/is-buffer-1.1.6.tgz";
        sha1 = "efaa2ea9daa0d7ab2ea13a97b2b8ad51fefbe8be";
      };
    }

    {
      name = "is-builtin-module-1.0.0.tgz";
      path = fetchurl {
        name = "is-builtin-module-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-builtin-module/-/is-builtin-module-1.0.0.tgz";
        sha1 = "540572d34f7ac3119f8f76c30cbc1b1e037affbe";
      };
    }

    {
      name = "is-callable-1.1.4.tgz";
      path = fetchurl {
        name = "is-callable-1.1.4.tgz";
        url  = "https://registry.yarnpkg.com/is-callable/-/is-callable-1.1.4.tgz";
        sha1 = "1e1adf219e1eeb684d691f9d6a05ff0d30a24d75";
      };
    }

    {
      name = "is-ci-1.1.0.tgz";
      path = fetchurl {
        name = "is-ci-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/is-ci/-/is-ci-1.1.0.tgz";
        sha1 = "247e4162e7860cebbdaf30b774d6b0ac7dcfe7a5";
      };
    }

    {
      name = "is-data-descriptor-0.1.4.tgz";
      path = fetchurl {
        name = "is-data-descriptor-0.1.4.tgz";
        url  = "https://registry.yarnpkg.com/is-data-descriptor/-/is-data-descriptor-0.1.4.tgz";
        sha1 = "0b5ee648388e2c860282e793f1856fec3f301b56";
      };
    }

    {
      name = "is-data-descriptor-1.0.0.tgz";
      path = fetchurl {
        name = "is-data-descriptor-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-data-descriptor/-/is-data-descriptor-1.0.0.tgz";
        sha1 = "d84876321d0e7add03990406abbbbd36ba9268c7";
      };
    }

    {
      name = "is-date-object-1.0.1.tgz";
      path = fetchurl {
        name = "is-date-object-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/is-date-object/-/is-date-object-1.0.1.tgz";
        sha1 = "9aa20eb6aeebbff77fbd33e74ca01b33581d3a16";
      };
    }

    {
      name = "is-decimal-1.0.2.tgz";
      path = fetchurl {
        name = "is-decimal-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/is-decimal/-/is-decimal-1.0.2.tgz";
        sha1 = "894662d6a8709d307f3a276ca4339c8fa5dff0ff";
      };
    }

    {
      name = "is-descriptor-0.1.6.tgz";
      path = fetchurl {
        name = "is-descriptor-0.1.6.tgz";
        url  = "https://registry.yarnpkg.com/is-descriptor/-/is-descriptor-0.1.6.tgz";
        sha1 = "366d8240dde487ca51823b1ab9f07a10a78251ca";
      };
    }

    {
      name = "is-descriptor-1.0.2.tgz";
      path = fetchurl {
        name = "is-descriptor-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/is-descriptor/-/is-descriptor-1.0.2.tgz";
        sha1 = "3b159746a66604b04f8c81524ba365c5f14d86ec";
      };
    }

    {
      name = "is-directory-0.3.1.tgz";
      path = fetchurl {
        name = "is-directory-0.3.1.tgz";
        url  = "https://registry.yarnpkg.com/is-directory/-/is-directory-0.3.1.tgz";
        sha1 = "61339b6f2475fc772fd9c9d83f5c8575dc154ae1";
      };
    }

    {
      name = "is-dotfile-1.0.3.tgz";
      path = fetchurl {
        name = "is-dotfile-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/is-dotfile/-/is-dotfile-1.0.3.tgz";
        sha1 = "a6a2f32ffd2dfb04f5ca25ecd0f6b83cf798a1e1";
      };
    }

    {
      name = "is-equal-shallow-0.1.3.tgz";
      path = fetchurl {
        name = "is-equal-shallow-0.1.3.tgz";
        url  = "https://registry.yarnpkg.com/is-equal-shallow/-/is-equal-shallow-0.1.3.tgz";
        sha1 = "2238098fc221de0bcfa5d9eac4c45d638aa1c534";
      };
    }

    {
      name = "is-es2016-keyword-1.0.0.tgz";
      path = fetchurl {
        name = "is-es2016-keyword-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-es2016-keyword/-/is-es2016-keyword-1.0.0.tgz";
        sha1 = "f6e54e110c5e4f8d265e69d2ed0eaf8cf5f47718";
      };
    }

    {
      name = "is-extendable-0.1.1.tgz";
      path = fetchurl {
        name = "is-extendable-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/is-extendable/-/is-extendable-0.1.1.tgz";
        sha1 = "62b110e289a471418e3ec36a617d472e301dfc89";
      };
    }

    {
      name = "is-extendable-1.0.1.tgz";
      path = fetchurl {
        name = "is-extendable-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/is-extendable/-/is-extendable-1.0.1.tgz";
        sha1 = "a7470f9e426733d81bd81e1155264e3a3507cab4";
      };
    }

    {
      name = "is-extglob-1.0.0.tgz";
      path = fetchurl {
        name = "is-extglob-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-extglob/-/is-extglob-1.0.0.tgz";
        sha1 = "ac468177c4943405a092fc8f29760c6ffc6206c0";
      };
    }

    {
      name = "is-extglob-2.1.1.tgz";
      path = fetchurl {
        name = "is-extglob-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/is-extglob/-/is-extglob-2.1.1.tgz";
        sha1 = "a88c02535791f02ed37c76a1b9ea9773c833f8c2";
      };
    }

    {
      name = "is-falsey-x-1.0.3.tgz";
      path = fetchurl {
        name = "is-falsey-x-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/is-falsey-x/-/is-falsey-x-1.0.3.tgz";
        sha1 = "d8bb6d77c15fb2b99d81d10a7351641495fb36e2";
      };
    }

    {
      name = "is-finite-x-3.0.4.tgz";
      path = fetchurl {
        name = "is-finite-x-3.0.4.tgz";
        url  = "https://registry.yarnpkg.com/is-finite-x/-/is-finite-x-3.0.4.tgz";
        sha1 = "320c97bab8aacc7e3cfa34aa58c432762c491b4e";
      };
    }

    {
      name = "is-finite-1.0.2.tgz";
      path = fetchurl {
        name = "is-finite-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/is-finite/-/is-finite-1.0.2.tgz";
        sha1 = "cc6677695602be550ef11e8b4aa6305342b6d0aa";
      };
    }

    {
      name = "is-fullwidth-code-point-1.0.0.tgz";
      path = fetchurl {
        name = "is-fullwidth-code-point-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-fullwidth-code-point/-/is-fullwidth-code-point-1.0.0.tgz";
        sha1 = "ef9e31386f031a7f0d643af82fde50c457ef00cb";
      };
    }

    {
      name = "is-fullwidth-code-point-2.0.0.tgz";
      path = fetchurl {
        name = "is-fullwidth-code-point-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-fullwidth-code-point/-/is-fullwidth-code-point-2.0.0.tgz";
        sha1 = "a3b30a5c4f199183167aaab93beefae3ddfb654f";
      };
    }

    {
      name = "is-function-x-3.3.0.tgz";
      path = fetchurl {
        name = "is-function-x-3.3.0.tgz";
        url  = "https://registry.yarnpkg.com/is-function-x/-/is-function-x-3.3.0.tgz";
        sha1 = "7d16bc113853db206d5e40a8b32caf99bd4ff7c0";
      };
    }

    {
      name = "is-generator-fn-1.0.0.tgz";
      path = fetchurl {
        name = "is-generator-fn-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-generator-fn/-/is-generator-fn-1.0.0.tgz";
        sha1 = "969d49e1bb3329f6bb7f09089be26578b2ddd46a";
      };
    }

    {
      name = "is-glob-2.0.1.tgz";
      path = fetchurl {
        name = "is-glob-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/is-glob/-/is-glob-2.0.1.tgz";
        sha1 = "d096f926a3ded5600f3fdfd91198cb0888c2d863";
      };
    }

    {
      name = "is-glob-3.1.0.tgz";
      path = fetchurl {
        name = "is-glob-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/is-glob/-/is-glob-3.1.0.tgz";
        sha1 = "7ba5ae24217804ac70707b96922567486cc3e84a";
      };
    }

    {
      name = "is-glob-4.0.0.tgz";
      path = fetchurl {
        name = "is-glob-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-glob/-/is-glob-4.0.0.tgz";
        sha1 = "9521c76845cc2610a85203ddf080a958c2ffabc0";
      };
    }

    {
      name = "is-hexadecimal-1.0.2.tgz";
      path = fetchurl {
        name = "is-hexadecimal-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/is-hexadecimal/-/is-hexadecimal-1.0.2.tgz";
        sha1 = "b6e710d7d07bb66b98cb8cece5c9b4921deeb835";
      };
    }

    {
      name = "is-in-browser-1.1.3.tgz";
      path = fetchurl {
        name = "is-in-browser-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/is-in-browser/-/is-in-browser-1.1.3.tgz";
        sha1 = "56ff4db683a078c6082eb95dad7dc62e1d04f835";
      };
    }

    {
      name = "is-index-x-1.1.0.tgz";
      path = fetchurl {
        name = "is-index-x-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/is-index-x/-/is-index-x-1.1.0.tgz";
        sha1 = "43dac97b3a04f30191530833f45ac35001682ee2";
      };
    }

    {
      name = "is-my-ip-valid-1.0.0.tgz";
      path = fetchurl {
        name = "is-my-ip-valid-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-my-ip-valid/-/is-my-ip-valid-1.0.0.tgz";
        sha1 = "7b351b8e8edd4d3995d4d066680e664d94696824";
      };
    }

    {
      name = "is-my-json-valid-2.17.2.tgz";
      path = fetchurl {
        name = "is-my-json-valid-2.17.2.tgz";
        url  = "https://registry.yarnpkg.com/is-my-json-valid/-/is-my-json-valid-2.17.2.tgz";
        sha1 = "6b2103a288e94ef3de5cf15d29dd85fc4b78d65c";
      };
    }

    {
      name = "is-nan-x-1.0.3.tgz";
      path = fetchurl {
        name = "is-nan-x-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/is-nan-x/-/is-nan-x-1.0.3.tgz";
        sha1 = "1c7fca40fc1b830a36e8800b37513a81f91fcc58";
      };
    }

    {
      name = "is-nil-x-1.4.2.tgz";
      path = fetchurl {
        name = "is-nil-x-1.4.2.tgz";
        url  = "https://registry.yarnpkg.com/is-nil-x/-/is-nil-x-1.4.2.tgz";
        sha1 = "a45e798d1e490d38db4570f2457245da21493e97";
      };
    }

    {
      name = "is-number-object-1.0.3.tgz";
      path = fetchurl {
        name = "is-number-object-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/is-number-object/-/is-number-object-1.0.3.tgz";
        sha1 = "f265ab89a9f445034ef6aff15a8f00b00f551799";
      };
    }

    {
      name = "is-number-2.1.0.tgz";
      path = fetchurl {
        name = "is-number-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/is-number/-/is-number-2.1.0.tgz";
        sha1 = "01fcbbb393463a548f2f466cce16dece49db908f";
      };
    }

    {
      name = "is-number-3.0.0.tgz";
      path = fetchurl {
        name = "is-number-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-number/-/is-number-3.0.0.tgz";
        sha1 = "24fd6201a4782cf50561c810276afc7d12d71195";
      };
    }

    {
      name = "is-number-4.0.0.tgz";
      path = fetchurl {
        name = "is-number-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-number/-/is-number-4.0.0.tgz";
        sha1 = "0026e37f5454d73e356dfe6564699867c6a7f0ff";
      };
    }

    {
      name = "is-obj-1.0.1.tgz";
      path = fetchurl {
        name = "is-obj-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/is-obj/-/is-obj-1.0.1.tgz";
        sha1 = "3e4729ac1f5fde025cd7d83a896dab9f4f67db0f";
      };
    }

    {
      name = "is-object-like-x-1.7.1.tgz";
      path = fetchurl {
        name = "is-object-like-x-1.7.1.tgz";
        url  = "https://registry.yarnpkg.com/is-object-like-x/-/is-object-like-x-1.7.1.tgz";
        sha1 = "f440ce811fb31278e4ed0b34f2d5a277d87b4481";
      };
    }

    {
      name = "is-observable-0.2.0.tgz";
      path = fetchurl {
        name = "is-observable-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/is-observable/-/is-observable-0.2.0.tgz";
        sha1 = "b361311d83c6e5d726cabf5e250b0237106f5ae2";
      };
    }

    {
      name = "is-path-cwd-1.0.0.tgz";
      path = fetchurl {
        name = "is-path-cwd-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-path-cwd/-/is-path-cwd-1.0.0.tgz";
        sha1 = "d225ec23132e89edd38fda767472e62e65f1106d";
      };
    }

    {
      name = "is-path-in-cwd-1.0.1.tgz";
      path = fetchurl {
        name = "is-path-in-cwd-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/is-path-in-cwd/-/is-path-in-cwd-1.0.1.tgz";
        sha1 = "5ac48b345ef675339bd6c7a48a912110b241cf52";
      };
    }

    {
      name = "is-path-inside-1.0.1.tgz";
      path = fetchurl {
        name = "is-path-inside-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/is-path-inside/-/is-path-inside-1.0.1.tgz";
        sha1 = "8ef5b7de50437a3fdca6b4e865ef7aa55cb48036";
      };
    }

    {
      name = "is-plain-obj-1.1.0.tgz";
      path = fetchurl {
        name = "is-plain-obj-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/is-plain-obj/-/is-plain-obj-1.1.0.tgz";
        sha1 = "71a50c8429dfca773c92a390a4a03b39fcd51d3e";
      };
    }

    {
      name = "is-plain-object-2.0.4.tgz";
      path = fetchurl {
        name = "is-plain-object-2.0.4.tgz";
        url  = "https://registry.yarnpkg.com/is-plain-object/-/is-plain-object-2.0.4.tgz";
        sha1 = "2c163b3fafb1b606d9d17928f05c2a1c38e07677";
      };
    }

    {
      name = "is-posix-bracket-0.1.1.tgz";
      path = fetchurl {
        name = "is-posix-bracket-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/is-posix-bracket/-/is-posix-bracket-0.1.1.tgz";
        sha1 = "3334dc79774368e92f016e6fbc0a88f5cd6e6bc4";
      };
    }

    {
      name = "is-primitive-2.0.0.tgz";
      path = fetchurl {
        name = "is-primitive-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-primitive/-/is-primitive-2.0.0.tgz";
        sha1 = "207bab91638499c07b2adf240a41a87210034575";
      };
    }

    {
      name = "is-primitive-3.0.1.tgz";
      path = fetchurl {
        name = "is-primitive-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/is-primitive/-/is-primitive-3.0.1.tgz";
        sha1 = "98c4db1abff185485a657fc2905052b940524d05";
      };
    }

    {
      name = "is-promise-2.1.0.tgz";
      path = fetchurl {
        name = "is-promise-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/is-promise/-/is-promise-2.1.0.tgz";
        sha1 = "79a2a9ece7f096e80f36d2b2f3bc16c1ff4bf3fa";
      };
    }

    {
      name = "is-property-1.0.2.tgz";
      path = fetchurl {
        name = "is-property-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/is-property/-/is-property-1.0.2.tgz";
        sha1 = "57fe1c4e48474edd65b09911f26b1cd4095dda84";
      };
    }

    {
      name = "is-redirect-1.0.0.tgz";
      path = fetchurl {
        name = "is-redirect-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-redirect/-/is-redirect-1.0.0.tgz";
        sha1 = "1d03dded53bd8db0f30c26e4f95d36fc7c87dc24";
      };
    }

    {
      name = "is-regex-1.0.4.tgz";
      path = fetchurl {
        name = "is-regex-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/is-regex/-/is-regex-1.0.4.tgz";
        sha1 = "5517489b547091b0930e095654ced25ee97e9491";
      };
    }

    {
      name = "is-regexp-1.0.0.tgz";
      path = fetchurl {
        name = "is-regexp-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-regexp/-/is-regexp-1.0.0.tgz";
        sha1 = "fd2d883545c46bac5a633e7b9a09e87fa2cb5069";
      };
    }

    {
      name = "is-resolvable-1.1.0.tgz";
      path = fetchurl {
        name = "is-resolvable-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/is-resolvable/-/is-resolvable-1.1.0.tgz";
        sha1 = "fb18f87ce1feb925169c9a407c19318a3206ed88";
      };
    }

    {
      name = "is-retry-allowed-1.1.0.tgz";
      path = fetchurl {
        name = "is-retry-allowed-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/is-retry-allowed/-/is-retry-allowed-1.1.0.tgz";
        sha1 = "11a060568b67339444033d0125a61a20d564fb34";
      };
    }

    {
      name = "is-root-1.0.0.tgz";
      path = fetchurl {
        name = "is-root-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-root/-/is-root-1.0.0.tgz";
        sha1 = "07b6c233bc394cd9d02ba15c966bd6660d6342d5";
      };
    }

    {
      name = "is-stream-1.1.0.tgz";
      path = fetchurl {
        name = "is-stream-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/is-stream/-/is-stream-1.1.0.tgz";
        sha1 = "12d4a3dd4e68e0b79ceb8dbc84173ae80d91ca44";
      };
    }

    {
      name = "is-string-1.0.4.tgz";
      path = fetchurl {
        name = "is-string-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/is-string/-/is-string-1.0.4.tgz";
        sha1 = "cc3a9b69857d621e963725a24caeec873b826e64";
      };
    }

    {
      name = "is-subset-0.1.1.tgz";
      path = fetchurl {
        name = "is-subset-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/is-subset/-/is-subset-0.1.1.tgz";
        sha1 = "8a59117d932de1de00f245fcdd39ce43f1e939a6";
      };
    }

    {
      name = "is-supported-regexp-flag-1.0.1.tgz";
      path = fetchurl {
        name = "is-supported-regexp-flag-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/is-supported-regexp-flag/-/is-supported-regexp-flag-1.0.1.tgz";
        sha1 = "21ee16518d2c1dd3edd3e9a0d57e50207ac364ca";
      };
    }

    {
      name = "is-svg-2.1.0.tgz";
      path = fetchurl {
        name = "is-svg-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/is-svg/-/is-svg-2.1.0.tgz";
        sha1 = "cf61090da0d9efbcab8722deba6f032208dbb0e9";
      };
    }

    {
      name = "is-symbol-1.0.1.tgz";
      path = fetchurl {
        name = "is-symbol-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/is-symbol/-/is-symbol-1.0.1.tgz";
        sha1 = "3cc59f00025194b6ab2e38dbae6689256b660572";
      };
    }

    {
      name = "is-text-path-1.0.1.tgz";
      path = fetchurl {
        name = "is-text-path-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/is-text-path/-/is-text-path-1.0.1.tgz";
        sha1 = "4e1aa0fb51bfbcb3e92688001397202c1775b66e";
      };
    }

    {
      name = "is-typedarray-1.0.0.tgz";
      path = fetchurl {
        name = "is-typedarray-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/is-typedarray/-/is-typedarray-1.0.0.tgz";
        sha1 = "e479c80858df0c1b11ddda6940f96011fcda4a9a";
      };
    }

    {
      name = "is-utf8-0.2.1.tgz";
      path = fetchurl {
        name = "is-utf8-0.2.1.tgz";
        url  = "https://registry.yarnpkg.com/is-utf8/-/is-utf8-0.2.1.tgz";
        sha1 = "4b0da1442104d1b336340e80797e865cf39f7d72";
      };
    }

    {
      name = "is-whitespace-character-1.0.2.tgz";
      path = fetchurl {
        name = "is-whitespace-character-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/is-whitespace-character/-/is-whitespace-character-1.0.2.tgz";
        sha1 = "ede53b4c6f6fb3874533751ec9280d01928d03ed";
      };
    }

    {
      name = "is-windows-1.0.2.tgz";
      path = fetchurl {
        name = "is-windows-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/is-windows/-/is-windows-1.0.2.tgz";
        sha1 = "d1850eb9791ecd18e6182ce12a30f396634bb19d";
      };
    }

    {
      name = "is-word-character-1.0.2.tgz";
      path = fetchurl {
        name = "is-word-character-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/is-word-character/-/is-word-character-1.0.2.tgz";
        sha1 = "46a5dac3f2a1840898b91e576cd40d493f3ae553";
      };
    }

    {
      name = "is-wsl-1.1.0.tgz";
      path = fetchurl {
        name = "is-wsl-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/is-wsl/-/is-wsl-1.1.0.tgz";
        sha1 = "1f16e4aa22b04d1336b66188a66af3c600c3a66d";
      };
    }

    {
      name = "isarray-0.0.1.tgz";
      path = fetchurl {
        name = "isarray-0.0.1.tgz";
        url  = "https://registry.yarnpkg.com/isarray/-/isarray-0.0.1.tgz";
        sha1 = "8a18acfca9a8f4177e09abfc6038939b05d1eedf";
      };
    }

    {
      name = "isarray-1.0.0.tgz";
      path = fetchurl {
        name = "isarray-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/isarray/-/isarray-1.0.0.tgz";
        sha1 = "bb935d48582cba168c06834957a54a3e07124f11";
      };
    }

    {
      name = "isemail-1.2.0.tgz";
      path = fetchurl {
        name = "isemail-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/isemail/-/isemail-1.2.0.tgz";
        sha1 = "be03df8cc3e29de4d2c5df6501263f1fa4595e9a";
      };
    }

    {
      name = "isemail-2.2.1.tgz";
      path = fetchurl {
        name = "isemail-2.2.1.tgz";
        url  = "https://registry.yarnpkg.com/isemail/-/isemail-2.2.1.tgz";
        sha1 = "0353d3d9a62951080c262c2aa0a42b8ea8e9e2a6";
      };
    }

    {
      name = "isemail-3.1.2.tgz";
      path = fetchurl {
        name = "isemail-3.1.2.tgz";
        url  = "https://registry.yarnpkg.com/isemail/-/isemail-3.1.2.tgz";
        sha1 = "937cf919002077999a73ea8b1951d590e84e01dd";
      };
    }

    {
      name = "isexe-2.0.0.tgz";
      path = fetchurl {
        name = "isexe-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/isexe/-/isexe-2.0.0.tgz";
        sha1 = "e8fbf374dc556ff8947a10dcb0572d633f2cfa10";
      };
    }

    {
      name = "isobject-2.1.0.tgz";
      path = fetchurl {
        name = "isobject-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/isobject/-/isobject-2.1.0.tgz";
        sha1 = "f065561096a3f1da2ef46272f815c840d87e0c89";
      };
    }

    {
      name = "isobject-3.0.1.tgz";
      path = fetchurl {
        name = "isobject-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/isobject/-/isobject-3.0.1.tgz";
        sha1 = "4e431e92b11a9731636aa1f9c8d1ccbcfdab78df";
      };
    }

    {
      name = "isomorphic-fetch-2.2.1.tgz";
      path = fetchurl {
        name = "isomorphic-fetch-2.2.1.tgz";
        url  = "https://registry.yarnpkg.com/isomorphic-fetch/-/isomorphic-fetch-2.2.1.tgz";
        sha1 = "611ae1acf14f5e81f729507472819fe9733558a9";
      };
    }

    {
      name = "isstream-0.1.2.tgz";
      path = fetchurl {
        name = "isstream-0.1.2.tgz";
        url  = "https://registry.yarnpkg.com/isstream/-/isstream-0.1.2.tgz";
        sha1 = "47e63f7af55afa6f92e1500e690eb8b8529c099a";
      };
    }

    {
      name = "istanbul-api-1.3.1.tgz";
      path = fetchurl {
        name = "istanbul-api-1.3.1.tgz";
        url  = "https://registry.yarnpkg.com/istanbul-api/-/istanbul-api-1.3.1.tgz";
        sha1 = "4c3b05d18c0016d1022e079b98dc82c40f488954";
      };
    }

    {
      name = "istanbul-lib-coverage-1.2.0.tgz";
      path = fetchurl {
        name = "istanbul-lib-coverage-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/istanbul-lib-coverage/-/istanbul-lib-coverage-1.2.0.tgz";
        sha1 = "f7d8f2e42b97e37fe796114cb0f9d68b5e3a4341";
      };
    }

    {
      name = "istanbul-lib-hook-1.2.1.tgz";
      path = fetchurl {
        name = "istanbul-lib-hook-1.2.1.tgz";
        url  = "https://registry.yarnpkg.com/istanbul-lib-hook/-/istanbul-lib-hook-1.2.1.tgz";
        sha1 = "f614ec45287b2a8fc4f07f5660af787575601805";
      };
    }

    {
      name = "istanbul-lib-instrument-1.10.1.tgz";
      path = fetchurl {
        name = "istanbul-lib-instrument-1.10.1.tgz";
        url  = "https://registry.yarnpkg.com/istanbul-lib-instrument/-/istanbul-lib-instrument-1.10.1.tgz";
        sha1 = "724b4b6caceba8692d3f1f9d0727e279c401af7b";
      };
    }

    {
      name = "istanbul-lib-report-1.1.4.tgz";
      path = fetchurl {
        name = "istanbul-lib-report-1.1.4.tgz";
        url  = "https://registry.yarnpkg.com/istanbul-lib-report/-/istanbul-lib-report-1.1.4.tgz";
        sha1 = "e886cdf505c4ebbd8e099e4396a90d0a28e2acb5";
      };
    }

    {
      name = "istanbul-lib-source-maps-1.2.3.tgz";
      path = fetchurl {
        name = "istanbul-lib-source-maps-1.2.3.tgz";
        url  = "https://registry.yarnpkg.com/istanbul-lib-source-maps/-/istanbul-lib-source-maps-1.2.3.tgz";
        sha1 = "20fb54b14e14b3fb6edb6aca3571fd2143db44e6";
      };
    }

    {
      name = "istanbul-lib-source-maps-1.2.5.tgz";
      path = fetchurl {
        name = "istanbul-lib-source-maps-1.2.5.tgz";
        url  = "https://registry.yarnpkg.com/istanbul-lib-source-maps/-/istanbul-lib-source-maps-1.2.5.tgz";
        sha1 = "ffe6be4e7ab86d3603e4290d54990b14506fc9b1";
      };
    }

    {
      name = "istanbul-reports-1.3.0.tgz";
      path = fetchurl {
        name = "istanbul-reports-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/istanbul-reports/-/istanbul-reports-1.3.0.tgz";
        sha1 = "2f322e81e1d9520767597dca3c20a0cce89a3554";
      };
    }

    {
      name = "items-2.1.1.tgz";
      path = fetchurl {
        name = "items-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/items/-/items-2.1.1.tgz";
        sha1 = "8bd16d9c83b19529de5aea321acaada78364a198";
      };
    }

    {
      name = "iterall-1.1.3.tgz";
      path = fetchurl {
        name = "iterall-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/iterall/-/iterall-1.1.3.tgz";
        sha1 = "1cbbff96204056dde6656e2ed2e2226d0e6d72c9";
      };
    }

    {
      name = "iterall-1.2.2.tgz";
      path = fetchurl {
        name = "iterall-1.2.2.tgz";
        url  = "https://registry.yarnpkg.com/iterall/-/iterall-1.2.2.tgz";
        sha1 = "92d70deb8028e0c39ff3164fdbf4d8b088130cd7";
      };
    }

    {
      name = "javascript-stringify-1.6.0.tgz";
      path = fetchurl {
        name = "javascript-stringify-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/javascript-stringify/-/javascript-stringify-1.6.0.tgz";
        sha1 = "142d111f3a6e3dae8f4a9afd77d45855b5a9cce3";
      };
    }

    {
      name = "jest-changed-files-17.0.2.tgz";
      path = fetchurl {
        name = "jest-changed-files-17.0.2.tgz";
        url  = "https://registry.yarnpkg.com/jest-changed-files/-/jest-changed-files-17.0.2.tgz";
        sha1 = "f5657758736996f590a51b87e5c9369d904ba7b7";
      };
    }

    {
      name = "jest-changed-files-20.0.3.tgz";
      path = fetchurl {
        name = "jest-changed-files-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-changed-files/-/jest-changed-files-20.0.3.tgz";
        sha1 = "9394d5cc65c438406149bef1bf4d52b68e03e3f8";
      };
    }

    {
      name = "jest-changed-files-22.4.3.tgz";
      path = fetchurl {
        name = "jest-changed-files-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-changed-files/-/jest-changed-files-22.4.3.tgz";
        sha1 = "8882181e022c38bd46a2e4d18d44d19d90a90fb2";
      };
    }

    {
      name = "jest-cli-18.1.0.tgz";
      path = fetchurl {
        name = "jest-cli-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-cli/-/jest-cli-18.1.0.tgz";
        sha1 = "5ead36ecad420817c2c9baa2aa7574f63257b3d6";
      };
    }

    {
      name = "jest-cli-20.0.4.tgz";
      path = fetchurl {
        name = "jest-cli-20.0.4.tgz";
        url  = "https://registry.yarnpkg.com/jest-cli/-/jest-cli-20.0.4.tgz";
        sha1 = "e532b19d88ae5bc6c417e8b0593a6fe954b1dc93";
      };
    }

    {
      name = "jest-cli-22.4.4.tgz";
      path = fetchurl {
        name = "jest-cli-22.4.4.tgz";
        url  = "https://registry.yarnpkg.com/jest-cli/-/jest-cli-22.4.4.tgz";
        sha1 = "68cd2a2aae983adb1e6638248ca21082fd6d9e90";
      };
    }

    {
      name = "jest-config-18.1.0.tgz";
      path = fetchurl {
        name = "jest-config-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-config/-/jest-config-18.1.0.tgz";
        sha1 = "6111740a6d48aab86ff5a9e6ab0b98bd993b6ff4";
      };
    }

    {
      name = "jest-config-20.0.4.tgz";
      path = fetchurl {
        name = "jest-config-20.0.4.tgz";
        url  = "https://registry.yarnpkg.com/jest-config/-/jest-config-20.0.4.tgz";
        sha1 = "e37930ab2217c913605eff13e7bd763ec48faeea";
      };
    }

    {
      name = "jest-config-22.4.4.tgz";
      path = fetchurl {
        name = "jest-config-22.4.4.tgz";
        url  = "https://registry.yarnpkg.com/jest-config/-/jest-config-22.4.4.tgz";
        sha1 = "72a521188720597169cd8b4ff86934ef5752d86a";
      };
    }

    {
      name = "jest-diff-18.1.0.tgz";
      path = fetchurl {
        name = "jest-diff-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-diff/-/jest-diff-18.1.0.tgz";
        sha1 = "4ff79e74dd988c139195b365dc65d87f606f4803";
      };
    }

    {
      name = "jest-diff-20.0.3.tgz";
      path = fetchurl {
        name = "jest-diff-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-diff/-/jest-diff-20.0.3.tgz";
        sha1 = "81f288fd9e675f0fb23c75f1c2b19445fe586617";
      };
    }

    {
      name = "jest-diff-22.4.3.tgz";
      path = fetchurl {
        name = "jest-diff-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-diff/-/jest-diff-22.4.3.tgz";
        sha1 = "e18cc3feff0aeef159d02310f2686d4065378030";
      };
    }

    {
      name = "jest-docblock-20.0.3.tgz";
      path = fetchurl {
        name = "jest-docblock-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-docblock/-/jest-docblock-20.0.3.tgz";
        sha1 = "17bea984342cc33d83c50fbe1545ea0efaa44712";
      };
    }

    {
      name = "jest-docblock-21.2.0.tgz";
      path = fetchurl {
        name = "jest-docblock-21.2.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-docblock/-/jest-docblock-21.2.0.tgz";
        sha1 = "51529c3b30d5fd159da60c27ceedc195faf8d414";
      };
    }

    {
      name = "jest-docblock-22.4.3.tgz";
      path = fetchurl {
        name = "jest-docblock-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-docblock/-/jest-docblock-22.4.3.tgz";
        sha1 = "50886f132b42b280c903c592373bb6e93bb68b19";
      };
    }

    {
      name = "jest-environment-jsdom-18.1.0.tgz";
      path = fetchurl {
        name = "jest-environment-jsdom-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-environment-jsdom/-/jest-environment-jsdom-18.1.0.tgz";
        sha1 = "18b42f0c4ea2bae9f36cab3639b1e8f8c384e24e";
      };
    }

    {
      name = "jest-environment-jsdom-20.0.3.tgz";
      path = fetchurl {
        name = "jest-environment-jsdom-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-environment-jsdom/-/jest-environment-jsdom-20.0.3.tgz";
        sha1 = "048a8ac12ee225f7190417713834bb999787de99";
      };
    }

    {
      name = "jest-environment-jsdom-22.4.3.tgz";
      path = fetchurl {
        name = "jest-environment-jsdom-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-environment-jsdom/-/jest-environment-jsdom-22.4.3.tgz";
        sha1 = "d67daa4155e33516aecdd35afd82d4abf0fa8a1e";
      };
    }

    {
      name = "jest-environment-node-18.1.0.tgz";
      path = fetchurl {
        name = "jest-environment-node-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-environment-node/-/jest-environment-node-18.1.0.tgz";
        sha1 = "4d6797572c8dda99acf5fae696eb62945547c779";
      };
    }

    {
      name = "jest-environment-node-20.0.3.tgz";
      path = fetchurl {
        name = "jest-environment-node-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-environment-node/-/jest-environment-node-20.0.3.tgz";
        sha1 = "d488bc4612af2c246e986e8ae7671a099163d403";
      };
    }

    {
      name = "jest-environment-node-22.4.3.tgz";
      path = fetchurl {
        name = "jest-environment-node-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-environment-node/-/jest-environment-node-22.4.3.tgz";
        sha1 = "54c4eaa374c83dd52a9da8759be14ebe1d0b9129";
      };
    }

    {
      name = "jest-file-exists-17.0.0.tgz";
      path = fetchurl {
        name = "jest-file-exists-17.0.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-file-exists/-/jest-file-exists-17.0.0.tgz";
        sha1 = "7f63eb73a1c43a13f461be261768b45af2cdd169";
      };
    }

    {
      name = "jest-get-type-21.2.0.tgz";
      path = fetchurl {
        name = "jest-get-type-21.2.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-get-type/-/jest-get-type-21.2.0.tgz";
        sha1 = "f6376ab9db4b60d81e39f30749c6c466f40d4a23";
      };
    }

    {
      name = "jest-get-type-22.4.3.tgz";
      path = fetchurl {
        name = "jest-get-type-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-get-type/-/jest-get-type-22.4.3.tgz";
        sha1 = "e3a8504d8479342dd4420236b322869f18900ce4";
      };
    }

    {
      name = "jest-haste-map-18.1.0.tgz";
      path = fetchurl {
        name = "jest-haste-map-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-haste-map/-/jest-haste-map-18.1.0.tgz";
        sha1 = "06839c74b770a40c1a106968851df8d281c08375";
      };
    }

    {
      name = "jest-haste-map-20.0.5.tgz";
      path = fetchurl {
        name = "jest-haste-map-20.0.5.tgz";
        url  = "https://registry.yarnpkg.com/jest-haste-map/-/jest-haste-map-20.0.5.tgz";
        sha1 = "abad74efb1a005974a7b6517e11010709cab9112";
      };
    }

    {
      name = "jest-haste-map-22.4.3.tgz";
      path = fetchurl {
        name = "jest-haste-map-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-haste-map/-/jest-haste-map-22.4.3.tgz";
        sha1 = "25842fa2ba350200767ac27f658d58b9d5c2e20b";
      };
    }

    {
      name = "jest-jasmine2-18.1.0.tgz";
      path = fetchurl {
        name = "jest-jasmine2-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-jasmine2/-/jest-jasmine2-18.1.0.tgz";
        sha1 = "094e104c2c189708766c77263bb2aecb5860a80b";
      };
    }

    {
      name = "jest-jasmine2-20.0.4.tgz";
      path = fetchurl {
        name = "jest-jasmine2-20.0.4.tgz";
        url  = "https://registry.yarnpkg.com/jest-jasmine2/-/jest-jasmine2-20.0.4.tgz";
        sha1 = "fcc5b1411780d911d042902ef1859e852e60d5e1";
      };
    }

    {
      name = "jest-jasmine2-22.4.4.tgz";
      path = fetchurl {
        name = "jest-jasmine2-22.4.4.tgz";
        url  = "https://registry.yarnpkg.com/jest-jasmine2/-/jest-jasmine2-22.4.4.tgz";
        sha1 = "c55f92c961a141f693f869f5f081a79a10d24e23";
      };
    }

    {
      name = "jest-leak-detector-22.4.3.tgz";
      path = fetchurl {
        name = "jest-leak-detector-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-leak-detector/-/jest-leak-detector-22.4.3.tgz";
        sha1 = "2b7b263103afae8c52b6b91241a2de40117e5b35";
      };
    }

    {
      name = "jest-matcher-utils-18.1.0.tgz";
      path = fetchurl {
        name = "jest-matcher-utils-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-matcher-utils/-/jest-matcher-utils-18.1.0.tgz";
        sha1 = "1ac4651955ee2a60cef1e7fcc98cdfd773c0f932";
      };
    }

    {
      name = "jest-matcher-utils-20.0.3.tgz";
      path = fetchurl {
        name = "jest-matcher-utils-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-matcher-utils/-/jest-matcher-utils-20.0.3.tgz";
        sha1 = "b3a6b8e37ca577803b0832a98b164f44b7815612";
      };
    }

    {
      name = "jest-matcher-utils-22.4.3.tgz";
      path = fetchurl {
        name = "jest-matcher-utils-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-matcher-utils/-/jest-matcher-utils-22.4.3.tgz";
        sha1 = "4632fe428ebc73ebc194d3c7b65d37b161f710ff";
      };
    }

    {
      name = "jest-matchers-18.1.0.tgz";
      path = fetchurl {
        name = "jest-matchers-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-matchers/-/jest-matchers-18.1.0.tgz";
        sha1 = "0341484bf87a1fd0bac0a4d2c899e2b77a3f1ead";
      };
    }

    {
      name = "jest-matchers-20.0.3.tgz";
      path = fetchurl {
        name = "jest-matchers-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-matchers/-/jest-matchers-20.0.3.tgz";
        sha1 = "ca69db1c32db5a6f707fa5e0401abb55700dfd60";
      };
    }

    {
      name = "jest-message-util-20.0.3.tgz";
      path = fetchurl {
        name = "jest-message-util-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-message-util/-/jest-message-util-20.0.3.tgz";
        sha1 = "6aec2844306fcb0e6e74d5796c1006d96fdd831c";
      };
    }

    {
      name = "jest-message-util-22.4.3.tgz";
      path = fetchurl {
        name = "jest-message-util-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-message-util/-/jest-message-util-22.4.3.tgz";
        sha1 = "cf3d38aafe4befddbfc455e57d65d5239e399eb7";
      };
    }

    {
      name = "jest-mock-18.0.0.tgz";
      path = fetchurl {
        name = "jest-mock-18.0.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-mock/-/jest-mock-18.0.0.tgz";
        sha1 = "5c248846ea33fa558b526f5312ab4a6765e489b3";
      };
    }

    {
      name = "jest-mock-20.0.3.tgz";
      path = fetchurl {
        name = "jest-mock-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-mock/-/jest-mock-20.0.3.tgz";
        sha1 = "8bc070e90414aa155c11a8d64c869a0d5c71da59";
      };
    }

    {
      name = "jest-mock-22.4.3.tgz";
      path = fetchurl {
        name = "jest-mock-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-mock/-/jest-mock-22.4.3.tgz";
        sha1 = "f63ba2f07a1511772cdc7979733397df770aabc7";
      };
    }

    {
      name = "jest-regex-util-20.0.3.tgz";
      path = fetchurl {
        name = "jest-regex-util-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-regex-util/-/jest-regex-util-20.0.3.tgz";
        sha1 = "85bbab5d133e44625b19faf8c6aa5122d085d762";
      };
    }

    {
      name = "jest-regex-util-22.4.3.tgz";
      path = fetchurl {
        name = "jest-regex-util-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-regex-util/-/jest-regex-util-22.4.3.tgz";
        sha1 = "a826eb191cdf22502198c5401a1fc04de9cef5af";
      };
    }

    {
      name = "jest-resolve-dependencies-18.1.0.tgz";
      path = fetchurl {
        name = "jest-resolve-dependencies-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-resolve-dependencies/-/jest-resolve-dependencies-18.1.0.tgz";
        sha1 = "8134fb5caf59c9ed842fe0152ab01c52711f1bbb";
      };
    }

    {
      name = "jest-resolve-dependencies-20.0.3.tgz";
      path = fetchurl {
        name = "jest-resolve-dependencies-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-resolve-dependencies/-/jest-resolve-dependencies-20.0.3.tgz";
        sha1 = "6e14a7b717af0f2cb3667c549de40af017b1723a";
      };
    }

    {
      name = "jest-resolve-dependencies-22.4.3.tgz";
      path = fetchurl {
        name = "jest-resolve-dependencies-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-resolve-dependencies/-/jest-resolve-dependencies-22.4.3.tgz";
        sha1 = "e2256a5a846732dc3969cb72f3c9ad7725a8195e";
      };
    }

    {
      name = "jest-resolve-18.1.0.tgz";
      path = fetchurl {
        name = "jest-resolve-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-resolve/-/jest-resolve-18.1.0.tgz";
        sha1 = "6800accb536658c906cd5e29de412b1ab9ac249b";
      };
    }

    {
      name = "jest-resolve-20.0.4.tgz";
      path = fetchurl {
        name = "jest-resolve-20.0.4.tgz";
        url  = "https://registry.yarnpkg.com/jest-resolve/-/jest-resolve-20.0.4.tgz";
        sha1 = "9448b3e8b6bafc15479444c6499045b7ffe597a5";
      };
    }

    {
      name = "jest-resolve-22.4.3.tgz";
      path = fetchurl {
        name = "jest-resolve-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-resolve/-/jest-resolve-22.4.3.tgz";
        sha1 = "0ce9d438c8438229aa9b916968ec6b05c1abb4ea";
      };
    }

    {
      name = "jest-runner-22.4.4.tgz";
      path = fetchurl {
        name = "jest-runner-22.4.4.tgz";
        url  = "https://registry.yarnpkg.com/jest-runner/-/jest-runner-22.4.4.tgz";
        sha1 = "dfca7b7553e0fa617e7b1291aeb7ce83e540a907";
      };
    }

    {
      name = "jest-runtime-18.1.0.tgz";
      path = fetchurl {
        name = "jest-runtime-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-runtime/-/jest-runtime-18.1.0.tgz";
        sha1 = "3abfd687175b21fc3b85a2b8064399e997859922";
      };
    }

    {
      name = "jest-runtime-20.0.4.tgz";
      path = fetchurl {
        name = "jest-runtime-20.0.4.tgz";
        url  = "https://registry.yarnpkg.com/jest-runtime/-/jest-runtime-20.0.4.tgz";
        sha1 = "a2c802219c4203f754df1404e490186169d124d8";
      };
    }

    {
      name = "jest-runtime-22.4.4.tgz";
      path = fetchurl {
        name = "jest-runtime-22.4.4.tgz";
        url  = "https://registry.yarnpkg.com/jest-runtime/-/jest-runtime-22.4.4.tgz";
        sha1 = "9ba7792fc75582a5be0f79af6f8fe8adea314048";
      };
    }

    {
      name = "jest-serializer-22.4.3.tgz";
      path = fetchurl {
        name = "jest-serializer-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-serializer/-/jest-serializer-22.4.3.tgz";
        sha1 = "a679b81a7f111e4766235f4f0c46d230ee0f7436";
      };
    }

    {
      name = "jest-snapshot-18.1.0.tgz";
      path = fetchurl {
        name = "jest-snapshot-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-snapshot/-/jest-snapshot-18.1.0.tgz";
        sha1 = "55b96d2ee639c9bce76f87f2a3fd40b71c7a5916";
      };
    }

    {
      name = "jest-snapshot-20.0.3.tgz";
      path = fetchurl {
        name = "jest-snapshot-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-snapshot/-/jest-snapshot-20.0.3.tgz";
        sha1 = "5b847e1adb1a4d90852a7f9f125086e187c76566";
      };
    }

    {
      name = "jest-snapshot-22.4.3.tgz";
      path = fetchurl {
        name = "jest-snapshot-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-snapshot/-/jest-snapshot-22.4.3.tgz";
        sha1 = "b5c9b42846ffb9faccb76b841315ba67887362d2";
      };
    }

    {
      name = "jest-util-18.1.0.tgz";
      path = fetchurl {
        name = "jest-util-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest-util/-/jest-util-18.1.0.tgz";
        sha1 = "3a99c32114ab17f84be094382527006e6d4bfc6a";
      };
    }

    {
      name = "jest-util-20.0.3.tgz";
      path = fetchurl {
        name = "jest-util-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-util/-/jest-util-20.0.3.tgz";
        sha1 = "0c07f7d80d82f4e5a67c6f8b9c3fe7f65cfd32ad";
      };
    }

    {
      name = "jest-util-22.4.3.tgz";
      path = fetchurl {
        name = "jest-util-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-util/-/jest-util-22.4.3.tgz";
        sha1 = "c70fec8eec487c37b10b0809dc064a7ecf6aafac";
      };
    }

    {
      name = "jest-validate-20.0.3.tgz";
      path = fetchurl {
        name = "jest-validate-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-validate/-/jest-validate-20.0.3.tgz";
        sha1 = "d0cfd1de4f579f298484925c280f8f1d94ec3cab";
      };
    }

    {
      name = "jest-validate-21.2.1.tgz";
      path = fetchurl {
        name = "jest-validate-21.2.1.tgz";
        url  = "https://registry.yarnpkg.com/jest-validate/-/jest-validate-21.2.1.tgz";
        sha1 = "cc0cbca653cd54937ba4f2a111796774530dd3c7";
      };
    }

    {
      name = "jest-validate-22.4.4.tgz";
      path = fetchurl {
        name = "jest-validate-22.4.4.tgz";
        url  = "https://registry.yarnpkg.com/jest-validate/-/jest-validate-22.4.4.tgz";
        sha1 = "1dd0b616ef46c995de61810d85f57119dbbcec4d";
      };
    }

    {
      name = "jest-worker-22.4.3.tgz";
      path = fetchurl {
        name = "jest-worker-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jest-worker/-/jest-worker-22.4.3.tgz";
        sha1 = "5c421417cba1c0abf64bf56bd5fb7968d79dd40b";
      };
    }

    {
      name = "jest-18.1.0.tgz";
      path = fetchurl {
        name = "jest-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jest/-/jest-18.1.0.tgz";
        sha1 = "bcebf1e203dee5c2ad2091c805300a343d9e6c7d";
      };
    }

    {
      name = "jest-20.0.4.tgz";
      path = fetchurl {
        name = "jest-20.0.4.tgz";
        url  = "https://registry.yarnpkg.com/jest/-/jest-20.0.4.tgz";
        sha1 = "3dd260c2989d6dad678b1e9cc4d91944f6d602ac";
      };
    }

    {
      name = "jest-22.4.4.tgz";
      path = fetchurl {
        name = "jest-22.4.4.tgz";
        url  = "https://registry.yarnpkg.com/jest/-/jest-22.4.4.tgz";
        sha1 = "ffb36c9654b339a13e10b3d4b338eb3e9d49f6eb";
      };
    }

    {
      name = "joi-browser-10.6.1.tgz";
      path = fetchurl {
        name = "joi-browser-10.6.1.tgz";
        url  = "https://registry.yarnpkg.com/joi-browser/-/joi-browser-10.6.1.tgz";
        sha1 = "1cfc1a244c9242327842c24354d8ead1c2fe3571";
      };
    }

    {
      name = "joi-10.6.0.tgz";
      path = fetchurl {
        name = "joi-10.6.0.tgz";
        url  = "https://registry.yarnpkg.com/joi/-/joi-10.6.0.tgz";
        sha1 = "52587f02d52b8b75cdb0c74f0b164a191a0e1fc2";
      };
    }

    {
      name = "joi-13.4.0.tgz";
      path = fetchurl {
        name = "joi-13.4.0.tgz";
        url  = "https://registry.yarnpkg.com/joi/-/joi-13.4.0.tgz";
        sha1 = "afc359ee3d8bc5f9b9ba6cdc31b46d44af14cecc";
      };
    }

    {
      name = "joi-6.10.1.tgz";
      path = fetchurl {
        name = "joi-6.10.1.tgz";
        url  = "https://registry.yarnpkg.com/joi/-/joi-6.10.1.tgz";
        sha1 = "4d50c318079122000fe5f16af1ff8e1917b77e06";
      };
    }

    {
      name = "js-base64-2.4.5.tgz";
      path = fetchurl {
        name = "js-base64-2.4.5.tgz";
        url  = "https://registry.yarnpkg.com/js-base64/-/js-base64-2.4.5.tgz";
        sha1 = "e293cd3c7c82f070d700fc7a1ca0a2e69f101f92";
      };
    }

    {
      name = "js-tokens-3.0.2.tgz";
      path = fetchurl {
        name = "js-tokens-3.0.2.tgz";
        url  = "https://registry.yarnpkg.com/js-tokens/-/js-tokens-3.0.2.tgz";
        sha1 = "9866df395102130e38f7f996bceb65443209c25b";
      };
    }

    {
      name = "js-tokens-4.0.0.tgz";
      path = fetchurl {
        name = "js-tokens-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/js-tokens/-/js-tokens-4.0.0.tgz";
        sha1 = "19203fb59991df98e3a287050d4647cdeaf32499";
      };
    }

    {
      name = "js-yaml-3.12.0.tgz";
      path = fetchurl {
        name = "js-yaml-3.12.0.tgz";
        url  = "https://registry.yarnpkg.com/js-yaml/-/js-yaml-3.12.0.tgz";
        sha1 = "eaed656ec8344f10f527c6bfa1b6e2244de167d1";
      };
    }

    {
      name = "js-yaml-3.7.0.tgz";
      path = fetchurl {
        name = "js-yaml-3.7.0.tgz";
        url  = "https://registry.yarnpkg.com/js-yaml/-/js-yaml-3.7.0.tgz";
        sha1 = "5c967ddd837a9bfdca5f2de84253abe8a1c03b80";
      };
    }

    {
      name = "js2xmlparser-3.0.0.tgz";
      path = fetchurl {
        name = "js2xmlparser-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/js2xmlparser/-/js2xmlparser-3.0.0.tgz";
        sha1 = "3fb60eaa089c5440f9319f51760ccd07e2499733";
      };
    }

    {
      name = "jsbn-0.1.1.tgz";
      path = fetchurl {
        name = "jsbn-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/jsbn/-/jsbn-0.1.1.tgz";
        sha1 = "a5e654c2e5a2deb5f201d96cefbca80c0ef2f513";
      };
    }

    {
      name = "jsdoc-api-4.0.3.tgz";
      path = fetchurl {
        name = "jsdoc-api-4.0.3.tgz";
        url  = "https://registry.yarnpkg.com/jsdoc-api/-/jsdoc-api-4.0.3.tgz";
        sha1 = "f87357856349a0be40a03e64711c34c74754ba20";
      };
    }

    {
      name = "jsdoc-parse-3.0.1.tgz";
      path = fetchurl {
        name = "jsdoc-parse-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/jsdoc-parse/-/jsdoc-parse-3.0.1.tgz";
        sha1 = "1194d6a16a2dfbe5fb8cccfeb5058ea808759893";
      };
    }

    {
      name = "jsdoc-to-markdown-4.0.1.tgz";
      path = fetchurl {
        name = "jsdoc-to-markdown-4.0.1.tgz";
        url  = "https://registry.yarnpkg.com/jsdoc-to-markdown/-/jsdoc-to-markdown-4.0.1.tgz";
        sha1 = "247f7d977ecc209428972ec92ca14bd4e610355d";
      };
    }

    {
      name = "jsdoc-3.5.5.tgz";
      path = fetchurl {
        name = "jsdoc-3.5.5.tgz";
        url  = "https://registry.yarnpkg.com/jsdoc/-/jsdoc-3.5.5.tgz";
        sha1 = "484521b126e81904d632ff83ec9aaa096708fa4d";
      };
    }

    {
      name = "jsdom-11.11.0.tgz";
      path = fetchurl {
        name = "jsdom-11.11.0.tgz";
        url  = "https://registry.yarnpkg.com/jsdom/-/jsdom-11.11.0.tgz";
        sha1 = "df486efad41aee96c59ad7a190e2449c7eb1110e";
      };
    }

    {
      name = "jsdom-9.12.0.tgz";
      path = fetchurl {
        name = "jsdom-9.12.0.tgz";
        url  = "https://registry.yarnpkg.com/jsdom/-/jsdom-9.12.0.tgz";
        sha1 = "e8c546fffcb06c00d4833ca84410fed7f8a097d4";
      };
    }

    {
      name = "jsesc-1.3.0.tgz";
      path = fetchurl {
        name = "jsesc-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/jsesc/-/jsesc-1.3.0.tgz";
        sha1 = "46c3fec8c1892b12b0833db9bc7622176dbab34b";
      };
    }

    {
      name = "jsesc-2.5.1.tgz";
      path = fetchurl {
        name = "jsesc-2.5.1.tgz";
        url  = "https://registry.yarnpkg.com/jsesc/-/jsesc-2.5.1.tgz";
        sha1 = "e421a2a8e20d6b0819df28908f782526b96dd1fe";
      };
    }

    {
      name = "jsesc-0.5.0.tgz";
      path = fetchurl {
        name = "jsesc-0.5.0.tgz";
        url  = "https://registry.yarnpkg.com/jsesc/-/jsesc-0.5.0.tgz";
        sha1 = "e7dee66e35d6fc16f710fe91d5cf69f70f08911d";
      };
    }

    {
      name = "json-loader-0.5.7.tgz";
      path = fetchurl {
        name = "json-loader-0.5.7.tgz";
        url  = "https://registry.yarnpkg.com/json-loader/-/json-loader-0.5.7.tgz";
        sha1 = "dca14a70235ff82f0ac9a3abeb60d337a365185d";
      };
    }

    {
      name = "json-parse-better-errors-1.0.2.tgz";
      path = fetchurl {
        name = "json-parse-better-errors-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/json-parse-better-errors/-/json-parse-better-errors-1.0.2.tgz";
        sha1 = "bb867cfb3450e69107c131d1c514bab3dc8bcaa9";
      };
    }

    {
      name = "json-schema-traverse-0.3.1.tgz";
      path = fetchurl {
        name = "json-schema-traverse-0.3.1.tgz";
        url  = "https://registry.yarnpkg.com/json-schema-traverse/-/json-schema-traverse-0.3.1.tgz";
        sha1 = "349a6d44c53a51de89b40805c5d5e59b417d3340";
      };
    }

    {
      name = "json-schema-traverse-0.4.1.tgz";
      path = fetchurl {
        name = "json-schema-traverse-0.4.1.tgz";
        url  = "https://registry.yarnpkg.com/json-schema-traverse/-/json-schema-traverse-0.4.1.tgz";
        sha1 = "69f6a87d9513ab8bb8fe63bdb0979c448e684660";
      };
    }

    {
      name = "json-schema-0.2.3.tgz";
      path = fetchurl {
        name = "json-schema-0.2.3.tgz";
        url  = "https://registry.yarnpkg.com/json-schema/-/json-schema-0.2.3.tgz";
        sha1 = "b480c892e59a2f05954ce727bd3f2a4e882f9e13";
      };
    }

    {
      name = "json-stable-stringify-without-jsonify-1.0.1.tgz";
      path = fetchurl {
        name = "json-stable-stringify-without-jsonify-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/json-stable-stringify-without-jsonify/-/json-stable-stringify-without-jsonify-1.0.1.tgz";
        sha1 = "9db7b59496ad3f3cfef30a75142d2d930ad72651";
      };
    }

    {
      name = "json-stable-stringify-1.0.1.tgz";
      path = fetchurl {
        name = "json-stable-stringify-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/json-stable-stringify/-/json-stable-stringify-1.0.1.tgz";
        sha1 = "9a759d39c5f2ff503fd5300646ed445f88c4f9af";
      };
    }

    {
      name = "json-stringify-safe-5.0.1.tgz";
      path = fetchurl {
        name = "json-stringify-safe-5.0.1.tgz";
        url  = "https://registry.yarnpkg.com/json-stringify-safe/-/json-stringify-safe-5.0.1.tgz";
        sha1 = "1296a2d58fd45f19a0f6ce01d65701e2c735b6eb";
      };
    }

    {
      name = "json3-3.3.2.tgz";
      path = fetchurl {
        name = "json3-3.3.2.tgz";
        url  = "https://registry.yarnpkg.com/json3/-/json3-3.3.2.tgz";
        sha1 = "3c0434743df93e2f5c42aee7b19bcb483575f4e1";
      };
    }

    {
      name = "json5-0.4.0.tgz";
      path = fetchurl {
        name = "json5-0.4.0.tgz";
        url  = "https://registry.yarnpkg.com/json5/-/json5-0.4.0.tgz";
        sha1 = "054352e4c4c80c86c0923877d449de176a732c8d";
      };
    }

    {
      name = "json5-0.5.1.tgz";
      path = fetchurl {
        name = "json5-0.5.1.tgz";
        url  = "https://registry.yarnpkg.com/json5/-/json5-0.5.1.tgz";
        sha1 = "1eade7acc012034ad84e2396767ead9fa5495821";
      };
    }

    {
      name = "jsonfile-4.0.0.tgz";
      path = fetchurl {
        name = "jsonfile-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/jsonfile/-/jsonfile-4.0.0.tgz";
        sha1 = "8771aae0799b64076b76640fca058f9c10e33ecb";
      };
    }

    {
      name = "jsonify-0.0.0.tgz";
      path = fetchurl {
        name = "jsonify-0.0.0.tgz";
        url  = "https://registry.yarnpkg.com/jsonify/-/jsonify-0.0.0.tgz";
        sha1 = "2c74b6ee41d93ca51b7b5aaee8f503631d252a73";
      };
    }

    {
      name = "jsonparse-1.3.1.tgz";
      path = fetchurl {
        name = "jsonparse-1.3.1.tgz";
        url  = "https://registry.yarnpkg.com/jsonparse/-/jsonparse-1.3.1.tgz";
        sha1 = "3f4dae4a91fac315f71062f8521cc239f1366280";
      };
    }

    {
      name = "jsonpointer-4.0.1.tgz";
      path = fetchurl {
        name = "jsonpointer-4.0.1.tgz";
        url  = "https://registry.yarnpkg.com/jsonpointer/-/jsonpointer-4.0.1.tgz";
        sha1 = "4fd92cb34e0e9db3c89c8622ecf51f9b978c6cb9";
      };
    }

    {
      name = "jsonwebtoken-7.4.3.tgz";
      path = fetchurl {
        name = "jsonwebtoken-7.4.3.tgz";
        url  = "https://registry.yarnpkg.com/jsonwebtoken/-/jsonwebtoken-7.4.3.tgz";
        sha1 = "77f5021de058b605a1783fa1283e99812e645638";
      };
    }

    {
      name = "jsprim-1.4.1.tgz";
      path = fetchurl {
        name = "jsprim-1.4.1.tgz";
        url  = "https://registry.yarnpkg.com/jsprim/-/jsprim-1.4.1.tgz";
        sha1 = "313e66bc1e5cc06e438bc1b7499c2e5c56acb6a2";
      };
    }

    {
      name = "jss-camel-case-6.1.0.tgz";
      path = fetchurl {
        name = "jss-camel-case-6.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jss-camel-case/-/jss-camel-case-6.1.0.tgz";
        sha1 = "ccb1ff8d6c701c02a1fed6fb6fb6b7896e11ce44";
      };
    }

    {
      name = "jss-compose-5.0.0.tgz";
      path = fetchurl {
        name = "jss-compose-5.0.0.tgz";
        url  = "https://registry.yarnpkg.com/jss-compose/-/jss-compose-5.0.0.tgz";
        sha1 = "ce01b2e4521d65c37ea42cf49116e5f7ab596484";
      };
    }

    {
      name = "jss-default-unit-8.0.2.tgz";
      path = fetchurl {
        name = "jss-default-unit-8.0.2.tgz";
        url  = "https://registry.yarnpkg.com/jss-default-unit/-/jss-default-unit-8.0.2.tgz";
        sha1 = "cc1e889bae4c0b9419327b314ab1c8e2826890e6";
      };
    }

    {
      name = "jss-global-3.0.0.tgz";
      path = fetchurl {
        name = "jss-global-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/jss-global/-/jss-global-3.0.0.tgz";
        sha1 = "e19e5c91ab2b96353c227e30aa2cbd938cdaafa2";
      };
    }

    {
      name = "jss-isolate-5.1.0.tgz";
      path = fetchurl {
        name = "jss-isolate-5.1.0.tgz";
        url  = "https://registry.yarnpkg.com/jss-isolate/-/jss-isolate-5.1.0.tgz";
        sha1 = "8eff1294c3659f86535852f4aeb79370743d890e";
      };
    }

    {
      name = "jss-nested-6.0.1.tgz";
      path = fetchurl {
        name = "jss-nested-6.0.1.tgz";
        url  = "https://registry.yarnpkg.com/jss-nested/-/jss-nested-6.0.1.tgz";
        sha1 = "ef992b79d6e8f63d939c4397b9d99b5cbbe824ca";
      };
    }

    {
      name = "jss-9.8.7.tgz";
      path = fetchurl {
        name = "jss-9.8.7.tgz";
        url  = "https://registry.yarnpkg.com/jss/-/jss-9.8.7.tgz";
        sha1 = "ed9763fc0f2f0260fc8260dac657af61e622ce05";
      };
    }

    {
      name = "jsx-ast-utils-1.4.1.tgz";
      path = fetchurl {
        name = "jsx-ast-utils-1.4.1.tgz";
        url  = "https://registry.yarnpkg.com/jsx-ast-utils/-/jsx-ast-utils-1.4.1.tgz";
        sha1 = "3867213e8dd79bf1e8f2300c0cfc1efb182c0df1";
      };
    }

    {
      name = "jsx-ast-utils-2.0.1.tgz";
      path = fetchurl {
        name = "jsx-ast-utils-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/jsx-ast-utils/-/jsx-ast-utils-2.0.1.tgz";
        sha1 = "e801b1b39985e20fffc87b40e3748080e2dcac7f";
      };
    }

    {
      name = "jwa-1.1.6.tgz";
      path = fetchurl {
        name = "jwa-1.1.6.tgz";
        url  = "https://registry.yarnpkg.com/jwa/-/jwa-1.1.6.tgz";
        sha1 = "87240e76c9808dbde18783cf2264ef4929ee50e6";
      };
    }

    {
      name = "jws-3.1.5.tgz";
      path = fetchurl {
        name = "jws-3.1.5.tgz";
        url  = "https://registry.yarnpkg.com/jws/-/jws-3.1.5.tgz";
        sha1 = "80d12d05b293d1e841e7cb8b4e69e561adcf834f";
      };
    }

    {
      name = "keycode-2.2.0.tgz";
      path = fetchurl {
        name = "keycode-2.2.0.tgz";
        url  = "https://registry.yarnpkg.com/keycode/-/keycode-2.2.0.tgz";
        sha1 = "3d0af56dc7b8b8e5cba8d0a97f107204eec22b04";
      };
    }

    {
      name = "killable-1.0.0.tgz";
      path = fetchurl {
        name = "killable-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/killable/-/killable-1.0.0.tgz";
        sha1 = "da8b84bd47de5395878f95d64d02f2449fe05e6b";
      };
    }

    {
      name = "kind-of-3.2.2.tgz";
      path = fetchurl {
        name = "kind-of-3.2.2.tgz";
        url  = "https://registry.yarnpkg.com/kind-of/-/kind-of-3.2.2.tgz";
        sha1 = "31ea21a734bab9bbb0f32466d893aea51e4a3c64";
      };
    }

    {
      name = "kind-of-4.0.0.tgz";
      path = fetchurl {
        name = "kind-of-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/kind-of/-/kind-of-4.0.0.tgz";
        sha1 = "20813df3d712928b207378691a45066fae72dd57";
      };
    }

    {
      name = "kind-of-5.1.0.tgz";
      path = fetchurl {
        name = "kind-of-5.1.0.tgz";
        url  = "https://registry.yarnpkg.com/kind-of/-/kind-of-5.1.0.tgz";
        sha1 = "729c91e2d857b7a419a1f9aa65685c4c33f5845d";
      };
    }

    {
      name = "kind-of-6.0.2.tgz";
      path = fetchurl {
        name = "kind-of-6.0.2.tgz";
        url  = "https://registry.yarnpkg.com/kind-of/-/kind-of-6.0.2.tgz";
        sha1 = "01146b36a6218e64e58f3a8d66de5d7fc6f6d051";
      };
    }

    {
      name = "klaw-2.0.0.tgz";
      path = fetchurl {
        name = "klaw-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/klaw/-/klaw-2.0.0.tgz";
        sha1 = "59c128e0dc5ce410201151194eeb9cbf858650f6";
      };
    }

    {
      name = "known-css-properties-0.5.0.tgz";
      path = fetchurl {
        name = "known-css-properties-0.5.0.tgz";
        url  = "https://registry.yarnpkg.com/known-css-properties/-/known-css-properties-0.5.0.tgz";
        sha1 = "6ff66943ed4a5b55657ee095779a91f4536f8084";
      };
    }

    {
      name = "lazy-cache-1.0.4.tgz";
      path = fetchurl {
        name = "lazy-cache-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/lazy-cache/-/lazy-cache-1.0.4.tgz";
        sha1 = "a1d78fc3a50474cb80845d3b3b6e1da49a446e8e";
      };
    }

    {
      name = "lazystream-1.0.0.tgz";
      path = fetchurl {
        name = "lazystream-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/lazystream/-/lazystream-1.0.0.tgz";
        sha1 = "f6995fe0f820392f61396be89462407bb77168e4";
      };
    }

    {
      name = "lcid-1.0.0.tgz";
      path = fetchurl {
        name = "lcid-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/lcid/-/lcid-1.0.0.tgz";
        sha1 = "308accafa0bc483a3867b4b6f2b9506251d1b835";
      };
    }

    {
      name = "left-pad-1.3.0.tgz";
      path = fetchurl {
        name = "left-pad-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/left-pad/-/left-pad-1.3.0.tgz";
        sha1 = "5b8a3a7765dfe001261dde915589e782f8c94d1e";
      };
    }

    {
      name = "lerna-2.11.0.tgz";
      path = fetchurl {
        name = "lerna-2.11.0.tgz";
        url  = "https://registry.yarnpkg.com/lerna/-/lerna-2.11.0.tgz";
        sha1 = "89b5681e286d388dda5bbbdbbf6b84c8094eff65";
      };
    }

    {
      name = "level-codec-7.0.1.tgz";
      path = fetchurl {
        name = "level-codec-7.0.1.tgz";
        url  = "https://registry.yarnpkg.com/level-codec/-/level-codec-7.0.1.tgz";
        sha1 = "341f22f907ce0f16763f24bddd681e395a0fb8a7";
      };
    }

    {
      name = "level-errors-1.1.2.tgz";
      path = fetchurl {
        name = "level-errors-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/level-errors/-/level-errors-1.1.2.tgz";
        sha1 = "4399c2f3d3ab87d0625f7e3676e2d807deff404d";
      };
    }

    {
      name = "level-iterator-stream-2.0.3.tgz";
      path = fetchurl {
        name = "level-iterator-stream-2.0.3.tgz";
        url  = "https://registry.yarnpkg.com/level-iterator-stream/-/level-iterator-stream-2.0.3.tgz";
        sha1 = "ccfff7c046dcf47955ae9a86f46dfa06a31688b4";
      };
    }

    {
      name = "levelup-2.0.1.tgz";
      path = fetchurl {
        name = "levelup-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/levelup/-/levelup-2.0.1.tgz";
        sha1 = "3dc91b3e632d37c9e546239c864118b004c9f860";
      };
    }

    {
      name = "leven-2.1.0.tgz";
      path = fetchurl {
        name = "leven-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/leven/-/leven-2.1.0.tgz";
        sha1 = "c2e7a9f772094dee9d34202ae8acce4687875580";
      };
    }

    {
      name = "levn-0.3.0.tgz";
      path = fetchurl {
        name = "levn-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/levn/-/levn-0.3.0.tgz";
        sha1 = "3b09924edf9f083c0490fdd4c0bc4421e04764ee";
      };
    }

    {
      name = "libtidy-0.3.7.tgz";
      path = fetchurl {
        name = "libtidy-0.3.7.tgz";
        url  = "https://registry.yarnpkg.com/libtidy/-/libtidy-0.3.7.tgz";
        sha1 = "a51c4c8bb7abf4d4fd4d9537467d969bac1fe0bd";
      };
    }

    {
      name = "lie-3.1.1.tgz";
      path = fetchurl {
        name = "lie-3.1.1.tgz";
        url  = "https://registry.yarnpkg.com/lie/-/lie-3.1.1.tgz";
        sha1 = "9a436b2cc7746ca59de7a41fa469b3efb76bd87e";
      };
    }

    {
      name = "lint-staged-4.3.0.tgz";
      path = fetchurl {
        name = "lint-staged-4.3.0.tgz";
        url  = "https://registry.yarnpkg.com/lint-staged/-/lint-staged-4.3.0.tgz";
        sha1 = "ed0779ad9a42c0dc62bb3244e522870b41125879";
      };
    }

    {
      name = "lint-staged-6.1.1.tgz";
      path = fetchurl {
        name = "lint-staged-6.1.1.tgz";
        url  = "https://registry.yarnpkg.com/lint-staged/-/lint-staged-6.1.1.tgz";
        sha1 = "cd08c4d9b8ccc2d37198d1c47ce77d22be6cf324";
      };
    }

    {
      name = "linux-platform-info-0.0.3.tgz";
      path = fetchurl {
        name = "linux-platform-info-0.0.3.tgz";
        url  = "https://registry.yarnpkg.com/linux-platform-info/-/linux-platform-info-0.0.3.tgz";
        sha1 = "2dae324385e66e3d755bec83f86c7beea61ceb83";
      };
    }

    {
      name = "listenercount-1.0.1.tgz";
      path = fetchurl {
        name = "listenercount-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/listenercount/-/listenercount-1.0.1.tgz";
        sha1 = "84c8a72ab59c4725321480c975e6508342e70937";
      };
    }

    {
      name = "listify-1.0.0.tgz";
      path = fetchurl {
        name = "listify-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/listify/-/listify-1.0.0.tgz";
        sha1 = "03ca7ba2d150d4267773f74e57558d1053d2bee3";
      };
    }

    {
      name = "listr-silent-renderer-1.1.1.tgz";
      path = fetchurl {
        name = "listr-silent-renderer-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/listr-silent-renderer/-/listr-silent-renderer-1.1.1.tgz";
        sha1 = "924b5a3757153770bf1a8e3fbf74b8bbf3f9242e";
      };
    }

    {
      name = "listr-update-renderer-0.2.0.tgz";
      path = fetchurl {
        name = "listr-update-renderer-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/listr-update-renderer/-/listr-update-renderer-0.2.0.tgz";
        sha1 = "ca80e1779b4e70266807e8eed1ad6abe398550f9";
      };
    }

    {
      name = "listr-update-renderer-0.4.0.tgz";
      path = fetchurl {
        name = "listr-update-renderer-0.4.0.tgz";
        url  = "https://registry.yarnpkg.com/listr-update-renderer/-/listr-update-renderer-0.4.0.tgz";
        sha1 = "344d980da2ca2e8b145ba305908f32ae3f4cc8a7";
      };
    }

    {
      name = "listr-verbose-renderer-0.4.1.tgz";
      path = fetchurl {
        name = "listr-verbose-renderer-0.4.1.tgz";
        url  = "https://registry.yarnpkg.com/listr-verbose-renderer/-/listr-verbose-renderer-0.4.1.tgz";
        sha1 = "8206f4cf6d52ddc5827e5fd14989e0e965933a35";
      };
    }

    {
      name = "listr-0.12.0.tgz";
      path = fetchurl {
        name = "listr-0.12.0.tgz";
        url  = "https://registry.yarnpkg.com/listr/-/listr-0.12.0.tgz";
        sha1 = "6bce2c0f5603fa49580ea17cd6a00cc0e5fa451a";
      };
    }

    {
      name = "listr-0.13.0.tgz";
      path = fetchurl {
        name = "listr-0.13.0.tgz";
        url  = "https://registry.yarnpkg.com/listr/-/listr-0.13.0.tgz";
        sha1 = "20bb0ba30bae660ee84cc0503df4be3d5623887d";
      };
    }

    {
      name = "load-json-file-1.1.0.tgz";
      path = fetchurl {
        name = "load-json-file-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/load-json-file/-/load-json-file-1.1.0.tgz";
        sha1 = "956905708d58b4bab4c2261b04f59f31c99374c0";
      };
    }

    {
      name = "load-json-file-2.0.0.tgz";
      path = fetchurl {
        name = "load-json-file-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/load-json-file/-/load-json-file-2.0.0.tgz";
        sha1 = "7947e42149af80d696cbf797bcaabcfe1fe29ca8";
      };
    }

    {
      name = "load-json-file-4.0.0.tgz";
      path = fetchurl {
        name = "load-json-file-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/load-json-file/-/load-json-file-4.0.0.tgz";
        sha1 = "2f5f45ab91e33216234fd53adab668eb4ec0993b";
      };
    }

    {
      name = "loader-fs-cache-1.0.1.tgz";
      path = fetchurl {
        name = "loader-fs-cache-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/loader-fs-cache/-/loader-fs-cache-1.0.1.tgz";
        sha1 = "56e0bf08bd9708b26a765b68509840c8dec9fdbc";
      };
    }

    {
      name = "loader-runner-2.3.0.tgz";
      path = fetchurl {
        name = "loader-runner-2.3.0.tgz";
        url  = "https://registry.yarnpkg.com/loader-runner/-/loader-runner-2.3.0.tgz";
        sha1 = "f482aea82d543e07921700d5a46ef26fdac6b8a2";
      };
    }

    {
      name = "loader-utils-0.2.17.tgz";
      path = fetchurl {
        name = "loader-utils-0.2.17.tgz";
        url  = "https://registry.yarnpkg.com/loader-utils/-/loader-utils-0.2.17.tgz";
        sha1 = "f86e6374d43205a6e6c60e9196f17c0299bfb348";
      };
    }

    {
      name = "loader-utils-1.1.0.tgz";
      path = fetchurl {
        name = "loader-utils-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/loader-utils/-/loader-utils-1.1.0.tgz";
        sha1 = "c98aef488bcceda2ffb5e2de646d6a754429f5cd";
      };
    }

    {
      name = "locate-path-2.0.0.tgz";
      path = fetchurl {
        name = "locate-path-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/locate-path/-/locate-path-2.0.0.tgz";
        sha1 = "2b568b265eec944c6d9c0de9c3dbbbca0354cd8e";
      };
    }

    {
      name = "lodash-es-4.13.1.tgz";
      path = fetchurl {
        name = "lodash-es-4.13.1.tgz";
        url  = "https://registry.yarnpkg.com/lodash-es/-/lodash-es-4.13.1.tgz";
        sha1 = "3daa36f23f09ede092a6f88833ffde08f7b8593c";
      };
    }

    {
      name = "lodash-es-4.17.10.tgz";
      path = fetchurl {
        name = "lodash-es-4.17.10.tgz";
        url  = "https://registry.yarnpkg.com/lodash-es/-/lodash-es-4.17.10.tgz";
        sha1 = "62cd7104cdf5dd87f235a837f0ede0e8e5117e05";
      };
    }

    {
      name = "lodash._arraycopy-3.0.0.tgz";
      path = fetchurl {
        name = "lodash._arraycopy-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash._arraycopy/-/lodash._arraycopy-3.0.0.tgz";
        sha1 = "76e7b7c1f1fb92547374878a562ed06a3e50f6e1";
      };
    }

    {
      name = "lodash._arrayeach-3.0.0.tgz";
      path = fetchurl {
        name = "lodash._arrayeach-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash._arrayeach/-/lodash._arrayeach-3.0.0.tgz";
        sha1 = "bab156b2a90d3f1bbd5c653403349e5e5933ef9e";
      };
    }

    {
      name = "lodash._baseassign-3.2.0.tgz";
      path = fetchurl {
        name = "lodash._baseassign-3.2.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash._baseassign/-/lodash._baseassign-3.2.0.tgz";
        sha1 = "8c38a099500f215ad09e59f1722fd0c52bfe0a4e";
      };
    }

    {
      name = "lodash._baseclone-3.3.0.tgz";
      path = fetchurl {
        name = "lodash._baseclone-3.3.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash._baseclone/-/lodash._baseclone-3.3.0.tgz";
        sha1 = "303519bf6393fe7e42f34d8b630ef7794e3542b7";
      };
    }

    {
      name = "lodash._basecopy-3.0.1.tgz";
      path = fetchurl {
        name = "lodash._basecopy-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/lodash._basecopy/-/lodash._basecopy-3.0.1.tgz";
        sha1 = "8da0e6a876cf344c0ad8a54882111dd3c5c7ca36";
      };
    }

    {
      name = "lodash._basefor-3.0.3.tgz";
      path = fetchurl {
        name = "lodash._basefor-3.0.3.tgz";
        url  = "https://registry.yarnpkg.com/lodash._basefor/-/lodash._basefor-3.0.3.tgz";
        sha1 = "7550b4e9218ef09fad24343b612021c79b4c20c2";
      };
    }

    {
      name = "lodash._bindcallback-3.0.1.tgz";
      path = fetchurl {
        name = "lodash._bindcallback-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/lodash._bindcallback/-/lodash._bindcallback-3.0.1.tgz";
        sha1 = "e531c27644cf8b57a99e17ed95b35c748789392e";
      };
    }

    {
      name = "lodash._getnative-3.9.1.tgz";
      path = fetchurl {
        name = "lodash._getnative-3.9.1.tgz";
        url  = "https://registry.yarnpkg.com/lodash._getnative/-/lodash._getnative-3.9.1.tgz";
        sha1 = "570bc7dede46d61cdcde687d65d3eecbaa3aaff5";
      };
    }

    {
      name = "lodash._reinterpolate-3.0.0.tgz";
      path = fetchurl {
        name = "lodash._reinterpolate-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash._reinterpolate/-/lodash._reinterpolate-3.0.0.tgz";
        sha1 = "0ccf2d89166af03b3663c796538b75ac6e114d9d";
      };
    }

    {
      name = "lodash.assign-4.2.0.tgz";
      path = fetchurl {
        name = "lodash.assign-4.2.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.assign/-/lodash.assign-4.2.0.tgz";
        sha1 = "0d99f3ccd7a6d261d19bdaeb9245005d285808e7";
      };
    }

    {
      name = "lodash.assignin-4.2.0.tgz";
      path = fetchurl {
        name = "lodash.assignin-4.2.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.assignin/-/lodash.assignin-4.2.0.tgz";
        sha1 = "ba8df5fb841eb0a3e8044232b0e263a8dc6a28a2";
      };
    }

    {
      name = "lodash.bind-4.2.1.tgz";
      path = fetchurl {
        name = "lodash.bind-4.2.1.tgz";
        url  = "https://registry.yarnpkg.com/lodash.bind/-/lodash.bind-4.2.1.tgz";
        sha1 = "7ae3017e939622ac31b7d7d7dcb1b34db1690d35";
      };
    }

    {
      name = "lodash.camelcase-4.3.0.tgz";
      path = fetchurl {
        name = "lodash.camelcase-4.3.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.camelcase/-/lodash.camelcase-4.3.0.tgz";
        sha1 = "b28aa6288a2b9fc651035c7711f65ab6190331a6";
      };
    }

    {
      name = "lodash.clonedeep-3.0.2.tgz";
      path = fetchurl {
        name = "lodash.clonedeep-3.0.2.tgz";
        url  = "https://registry.yarnpkg.com/lodash.clonedeep/-/lodash.clonedeep-3.0.2.tgz";
        sha1 = "a0a1e40d82a5ea89ff5b147b8444ed63d92827db";
      };
    }

    {
      name = "lodash.clonedeep-4.5.0.tgz";
      path = fetchurl {
        name = "lodash.clonedeep-4.5.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.clonedeep/-/lodash.clonedeep-4.5.0.tgz";
        sha1 = "e23f3f9c4f8fbdde872529c1071857a086e5ccef";
      };
    }

    {
      name = "lodash.cond-4.5.2.tgz";
      path = fetchurl {
        name = "lodash.cond-4.5.2.tgz";
        url  = "https://registry.yarnpkg.com/lodash.cond/-/lodash.cond-4.5.2.tgz";
        sha1 = "f471a1da486be60f6ab955d17115523dd1d255d5";
      };
    }

    {
      name = "lodash.debounce-4.0.8.tgz";
      path = fetchurl {
        name = "lodash.debounce-4.0.8.tgz";
        url  = "https://registry.yarnpkg.com/lodash.debounce/-/lodash.debounce-4.0.8.tgz";
        sha1 = "82d79bff30a67c4005ffd5e2515300ad9ca4d7af";
      };
    }

    {
      name = "lodash.defaults-4.2.0.tgz";
      path = fetchurl {
        name = "lodash.defaults-4.2.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.defaults/-/lodash.defaults-4.2.0.tgz";
        sha1 = "d09178716ffea4dde9e5fb7b37f6f0802274580c";
      };
    }

    {
      name = "lodash.filter-4.6.0.tgz";
      path = fetchurl {
        name = "lodash.filter-4.6.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.filter/-/lodash.filter-4.6.0.tgz";
        sha1 = "668b1d4981603ae1cc5a6fa760143e480b4c4ace";
      };
    }

    {
      name = "lodash.flatten-4.4.0.tgz";
      path = fetchurl {
        name = "lodash.flatten-4.4.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.flatten/-/lodash.flatten-4.4.0.tgz";
        sha1 = "f31c22225a9632d2bbf8e4addbef240aa765a61f";
      };
    }

    {
      name = "lodash.flattendeep-4.4.0.tgz";
      path = fetchurl {
        name = "lodash.flattendeep-4.4.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.flattendeep/-/lodash.flattendeep-4.4.0.tgz";
        sha1 = "fb030917f86a3134e5bc9bec0d69e0013ddfedb2";
      };
    }

    {
      name = "lodash.foreach-4.5.0.tgz";
      path = fetchurl {
        name = "lodash.foreach-4.5.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.foreach/-/lodash.foreach-4.5.0.tgz";
        sha1 = "1a6a35eace401280c7f06dddec35165ab27e3e53";
      };
    }

    {
      name = "lodash.isarguments-3.1.0.tgz";
      path = fetchurl {
        name = "lodash.isarguments-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.isarguments/-/lodash.isarguments-3.1.0.tgz";
        sha1 = "2f573d85c6a24289ff00663b491c1d338ff3458a";
      };
    }

    {
      name = "lodash.isarray-3.0.4.tgz";
      path = fetchurl {
        name = "lodash.isarray-3.0.4.tgz";
        url  = "https://registry.yarnpkg.com/lodash.isarray/-/lodash.isarray-3.0.4.tgz";
        sha1 = "79e4eb88c36a8122af86f844aa9bcd851b5fbb55";
      };
    }

    {
      name = "lodash.isnil-4.0.0.tgz";
      path = fetchurl {
        name = "lodash.isnil-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.isnil/-/lodash.isnil-4.0.0.tgz";
        sha1 = "49e28cd559013458c814c5479d3c663a21bfaa6c";
      };
    }

    {
      name = "lodash.isnull-3.0.0.tgz";
      path = fetchurl {
        name = "lodash.isnull-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.isnull/-/lodash.isnull-3.0.0.tgz";
        sha1 = "fafbe59ea1dca27eed786534039dd84c2e07c56e";
      };
    }

    {
      name = "lodash.isplainobject-4.0.6.tgz";
      path = fetchurl {
        name = "lodash.isplainobject-4.0.6.tgz";
        url  = "https://registry.yarnpkg.com/lodash.isplainobject/-/lodash.isplainobject-4.0.6.tgz";
        sha1 = "7c526a52d89b45c45cc690b88163be0497f550cb";
      };
    }

    {
      name = "lodash.keys-3.1.2.tgz";
      path = fetchurl {
        name = "lodash.keys-3.1.2.tgz";
        url  = "https://registry.yarnpkg.com/lodash.keys/-/lodash.keys-3.1.2.tgz";
        sha1 = "4dbc0472b156be50a0b286855d1bd0b0c656098a";
      };
    }

    {
      name = "lodash.map-4.6.0.tgz";
      path = fetchurl {
        name = "lodash.map-4.6.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.map/-/lodash.map-4.6.0.tgz";
        sha1 = "771ec7839e3473d9c4cde28b19394c3562f4f6d3";
      };
    }

    {
      name = "lodash.memoize-4.1.2.tgz";
      path = fetchurl {
        name = "lodash.memoize-4.1.2.tgz";
        url  = "https://registry.yarnpkg.com/lodash.memoize/-/lodash.memoize-4.1.2.tgz";
        sha1 = "bcc6c49a42a2840ed997f323eada5ecd182e0bfe";
      };
    }

    {
      name = "lodash.merge-4.6.1.tgz";
      path = fetchurl {
        name = "lodash.merge-4.6.1.tgz";
        url  = "https://registry.yarnpkg.com/lodash.merge/-/lodash.merge-4.6.1.tgz";
        sha1 = "adc25d9cb99b9391c59624f379fbba60d7111d54";
      };
    }

    {
      name = "lodash.mergewith-4.6.1.tgz";
      path = fetchurl {
        name = "lodash.mergewith-4.6.1.tgz";
        url  = "https://registry.yarnpkg.com/lodash.mergewith/-/lodash.mergewith-4.6.1.tgz";
        sha1 = "639057e726c3afbdb3e7d42741caa8d6e4335927";
      };
    }

    {
      name = "lodash.omit-4.5.0.tgz";
      path = fetchurl {
        name = "lodash.omit-4.5.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.omit/-/lodash.omit-4.5.0.tgz";
        sha1 = "6eb19ae5a1ee1dd9df0b969e66ce0b7fa30b5e60";
      };
    }

    {
      name = "lodash.omitby-4.6.0.tgz";
      path = fetchurl {
        name = "lodash.omitby-4.6.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.omitby/-/lodash.omitby-4.6.0.tgz";
        sha1 = "5c15ff4754ad555016b53c041311e8f079204791";
      };
    }

    {
      name = "lodash.once-4.1.1.tgz";
      path = fetchurl {
        name = "lodash.once-4.1.1.tgz";
        url  = "https://registry.yarnpkg.com/lodash.once/-/lodash.once-4.1.1.tgz";
        sha1 = "0dd3971213c7c56df880977d504c88fb471a97ac";
      };
    }

    {
      name = "lodash.padend-4.6.1.tgz";
      path = fetchurl {
        name = "lodash.padend-4.6.1.tgz";
        url  = "https://registry.yarnpkg.com/lodash.padend/-/lodash.padend-4.6.1.tgz";
        sha1 = "53ccba047d06e158d311f45da625f4e49e6f166e";
      };
    }

    {
      name = "lodash.pick-4.4.0.tgz";
      path = fetchurl {
        name = "lodash.pick-4.4.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.pick/-/lodash.pick-4.4.0.tgz";
        sha1 = "52f05610fff9ded422611441ed1fc123a03001b3";
      };
    }

    {
      name = "lodash.range-3.2.0.tgz";
      path = fetchurl {
        name = "lodash.range-3.2.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.range/-/lodash.range-3.2.0.tgz";
        sha1 = "f461e588f66683f7eadeade513e38a69a565a15d";
      };
    }

    {
      name = "lodash.reduce-4.6.0.tgz";
      path = fetchurl {
        name = "lodash.reduce-4.6.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.reduce/-/lodash.reduce-4.6.0.tgz";
        sha1 = "f1ab6b839299ad48f784abbf476596f03b914d3b";
      };
    }

    {
      name = "lodash.reject-4.6.0.tgz";
      path = fetchurl {
        name = "lodash.reject-4.6.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.reject/-/lodash.reject-4.6.0.tgz";
        sha1 = "80d6492dc1470864bbf583533b651f42a9f52415";
      };
    }

    {
      name = "lodash.some-4.6.0.tgz";
      path = fetchurl {
        name = "lodash.some-4.6.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.some/-/lodash.some-4.6.0.tgz";
        sha1 = "1bb9f314ef6b8baded13b549169b2a945eb68e4d";
      };
    }

    {
      name = "lodash.sortby-4.7.0.tgz";
      path = fetchurl {
        name = "lodash.sortby-4.7.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.sortby/-/lodash.sortby-4.7.0.tgz";
        sha1 = "edd14c824e2cc9c1e0b0a1b42bb5210516a42438";
      };
    }

    {
      name = "lodash.tail-4.1.1.tgz";
      path = fetchurl {
        name = "lodash.tail-4.1.1.tgz";
        url  = "https://registry.yarnpkg.com/lodash.tail/-/lodash.tail-4.1.1.tgz";
        sha1 = "d2333a36d9e7717c8ad2f7cacafec7c32b444664";
      };
    }

    {
      name = "lodash.template-4.4.0.tgz";
      path = fetchurl {
        name = "lodash.template-4.4.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.template/-/lodash.template-4.4.0.tgz";
        sha1 = "e73a0385c8355591746e020b99679c690e68fba0";
      };
    }

    {
      name = "lodash.templatesettings-4.1.0.tgz";
      path = fetchurl {
        name = "lodash.templatesettings-4.1.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.templatesettings/-/lodash.templatesettings-4.1.0.tgz";
        sha1 = "2b4d4e95ba440d915ff08bc899e4553666713316";
      };
    }

    {
      name = "lodash.toarray-4.4.0.tgz";
      path = fetchurl {
        name = "lodash.toarray-4.4.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.toarray/-/lodash.toarray-4.4.0.tgz";
        sha1 = "24c4bfcd6b2fba38bfd0594db1179d8e9b656561";
      };
    }

    {
      name = "lodash.uniq-4.5.0.tgz";
      path = fetchurl {
        name = "lodash.uniq-4.5.0.tgz";
        url  = "https://registry.yarnpkg.com/lodash.uniq/-/lodash.uniq-4.5.0.tgz";
        sha1 = "d0225373aeb652adc1bc82e4945339a842754773";
      };
    }

    {
      name = "lodash-4.16.4.tgz";
      path = fetchurl {
        name = "lodash-4.16.4.tgz";
        url  = "https://registry.yarnpkg.com/lodash/-/lodash-4.16.4.tgz";
        sha1 = "01ce306b9bad1319f2a5528674f88297aeb70127";
      };
    }

    {
      name = "lodash-4.17.4.tgz";
      path = fetchurl {
        name = "lodash-4.17.4.tgz";
        url  = "https://registry.yarnpkg.com/lodash/-/lodash-4.17.4.tgz";
        sha1 = "78203a4d1c328ae1d86dca6460e369b57f4055ae";
      };
    }

    {
      name = "lodash-4.17.10.tgz";
      path = fetchurl {
        name = "lodash-4.17.10.tgz";
        url  = "https://registry.yarnpkg.com/lodash/-/lodash-4.17.10.tgz";
        sha1 = "1b7793cf7259ea38fb3661d4d38b3260af8ae4e7";
      };
    }

    {
      name = "log-symbols-1.0.2.tgz";
      path = fetchurl {
        name = "log-symbols-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/log-symbols/-/log-symbols-1.0.2.tgz";
        sha1 = "376ff7b58ea3086a0f09facc74617eca501e1a18";
      };
    }

    {
      name = "log-symbols-2.2.0.tgz";
      path = fetchurl {
        name = "log-symbols-2.2.0.tgz";
        url  = "https://registry.yarnpkg.com/log-symbols/-/log-symbols-2.2.0.tgz";
        sha1 = "5740e1c5d6f0dfda4ad9323b5332107ef6b4c40a";
      };
    }

    {
      name = "log-update-async-hook-2.0.2.tgz";
      path = fetchurl {
        name = "log-update-async-hook-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/log-update-async-hook/-/log-update-async-hook-2.0.2.tgz";
        sha1 = "6eba89dbe67fa12d0b20ac47df7942947af1fcd1";
      };
    }

    {
      name = "log-update-1.0.2.tgz";
      path = fetchurl {
        name = "log-update-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/log-update/-/log-update-1.0.2.tgz";
        sha1 = "19929f64c4093d2d2e7075a1dad8af59c296b8d1";
      };
    }

    {
      name = "logform-1.9.1.tgz";
      path = fetchurl {
        name = "logform-1.9.1.tgz";
        url  = "https://registry.yarnpkg.com/logform/-/logform-1.9.1.tgz";
        sha1 = "58b29d7b11c332456d7a217e17b48a13ad69d60a";
      };
    }

    {
      name = "loglevel-1.6.1.tgz";
      path = fetchurl {
        name = "loglevel-1.6.1.tgz";
        url  = "https://registry.yarnpkg.com/loglevel/-/loglevel-1.6.1.tgz";
        sha1 = "e0fc95133b6ef276cdc8887cdaf24aa6f156f8fa";
      };
    }

    {
      name = "lolex-1.3.2.tgz";
      path = fetchurl {
        name = "lolex-1.3.2.tgz";
        url  = "https://registry.yarnpkg.com/lolex/-/lolex-1.3.2.tgz";
        sha1 = "7c3da62ffcb30f0f5a80a2566ca24e45d8a01f31";
      };
    }

    {
      name = "lolex-1.6.0.tgz";
      path = fetchurl {
        name = "lolex-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/lolex/-/lolex-1.6.0.tgz";
        sha1 = "3a9a0283452a47d7439e72731b9e07d7386e49f6";
      };
    }

    {
      name = "longest-streak-2.0.2.tgz";
      path = fetchurl {
        name = "longest-streak-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/longest-streak/-/longest-streak-2.0.2.tgz";
        sha1 = "2421b6ba939a443bb9ffebf596585a50b4c38e2e";
      };
    }

    {
      name = "longest-1.0.1.tgz";
      path = fetchurl {
        name = "longest-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/longest/-/longest-1.0.1.tgz";
        sha1 = "30a0b2da38f73770e8294a0d22e6625ed77d0097";
      };
    }

    {
      name = "loose-envify-1.4.0.tgz";
      path = fetchurl {
        name = "loose-envify-1.4.0.tgz";
        url  = "https://registry.yarnpkg.com/loose-envify/-/loose-envify-1.4.0.tgz";
        sha1 = "71ee51fa7be4caec1a63839f7e682d8132d30caf";
      };
    }

    {
      name = "loud-rejection-1.6.0.tgz";
      path = fetchurl {
        name = "loud-rejection-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/loud-rejection/-/loud-rejection-1.6.0.tgz";
        sha1 = "5b46f80147edee578870f086d04821cf998e551f";
      };
    }

    {
      name = "lower-case-1.1.4.tgz";
      path = fetchurl {
        name = "lower-case-1.1.4.tgz";
        url  = "https://registry.yarnpkg.com/lower-case/-/lower-case-1.1.4.tgz";
        sha1 = "9a2cabd1b9e8e0ae993a4bf7d5875c39c42e8eac";
      };
    }

    {
      name = "lowercase-keys-1.0.1.tgz";
      path = fetchurl {
        name = "lowercase-keys-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/lowercase-keys/-/lowercase-keys-1.0.1.tgz";
        sha1 = "6f9e30b47084d971a7c820ff15a6c5167b74c26f";
      };
    }

    {
      name = "lru-cache-2.6.3.tgz";
      path = fetchurl {
        name = "lru-cache-2.6.3.tgz";
        url  = "https://registry.yarnpkg.com/lru-cache/-/lru-cache-2.6.3.tgz";
        sha1 = "51ccd0b4fc0c843587d7a5709ce4d3b7629bedc5";
      };
    }

    {
      name = "lru-cache-4.1.3.tgz";
      path = fetchurl {
        name = "lru-cache-4.1.3.tgz";
        url  = "https://registry.yarnpkg.com/lru-cache/-/lru-cache-4.1.3.tgz";
        sha1 = "a1175cf3496dfc8436c156c334b4955992bce69c";
      };
    }

    {
      name = "ltgt-2.2.0.tgz";
      path = fetchurl {
        name = "ltgt-2.2.0.tgz";
        url  = "https://registry.yarnpkg.com/ltgt/-/ltgt-2.2.0.tgz";
        sha1 = "b65ba5fcb349a29924c8e333f7c6a5562f2e4842";
      };
    }

    {
      name = "ltgt-2.1.3.tgz";
      path = fetchurl {
        name = "ltgt-2.1.3.tgz";
        url  = "https://registry.yarnpkg.com/ltgt/-/ltgt-2.1.3.tgz";
        sha1 = "10851a06d9964b971178441c23c9e52698eece34";
      };
    }

    {
      name = "magic-string-0.22.5.tgz";
      path = fetchurl {
        name = "magic-string-0.22.5.tgz";
        url  = "https://registry.yarnpkg.com/magic-string/-/magic-string-0.22.5.tgz";
        sha1 = "8e9cf5afddf44385c1da5bc2a6a0dbd10b03657e";
      };
    }

    {
      name = "make-dir-1.3.0.tgz";
      path = fetchurl {
        name = "make-dir-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/make-dir/-/make-dir-1.3.0.tgz";
        sha1 = "79c1033b80515bd6d24ec9933e860ca75ee27f0c";
      };
    }

    {
      name = "makeerror-1.0.11.tgz";
      path = fetchurl {
        name = "makeerror-1.0.11.tgz";
        url  = "https://registry.yarnpkg.com/makeerror/-/makeerror-1.0.11.tgz";
        sha1 = "e01a5c9109f2af79660e4e8b9587790184f5a96c";
      };
    }

    {
      name = "map-cache-0.2.2.tgz";
      path = fetchurl {
        name = "map-cache-0.2.2.tgz";
        url  = "https://registry.yarnpkg.com/map-cache/-/map-cache-0.2.2.tgz";
        sha1 = "c32abd0bd6525d9b051645bb4f26ac5dc98a0dbf";
      };
    }

    {
      name = "map-obj-1.0.1.tgz";
      path = fetchurl {
        name = "map-obj-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/map-obj/-/map-obj-1.0.1.tgz";
        sha1 = "d933ceb9205d82bdcf4886f6742bdc2b4dea146d";
      };
    }

    {
      name = "map-obj-2.0.0.tgz";
      path = fetchurl {
        name = "map-obj-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/map-obj/-/map-obj-2.0.0.tgz";
        sha1 = "a65cd29087a92598b8791257a523e021222ac1f9";
      };
    }

    {
      name = "map-reverse-1.0.1.tgz";
      path = fetchurl {
        name = "map-reverse-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/map-reverse/-/map-reverse-1.0.1.tgz";
        sha1 = "274e9f500a611153183b5b8d8490a9c1c23ee310";
      };
    }

    {
      name = "map-visit-1.0.0.tgz";
      path = fetchurl {
        name = "map-visit-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/map-visit/-/map-visit-1.0.0.tgz";
        sha1 = "ecdca8f13144e660f1b5bd41f12f3479d98dfb8f";
      };
    }

    {
      name = "markdown-escapes-1.0.2.tgz";
      path = fetchurl {
        name = "markdown-escapes-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/markdown-escapes/-/markdown-escapes-1.0.2.tgz";
        sha1 = "e639cbde7b99c841c0bacc8a07982873b46d2122";
      };
    }

    {
      name = "markdown-table-1.1.2.tgz";
      path = fetchurl {
        name = "markdown-table-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/markdown-table/-/markdown-table-1.1.2.tgz";
        sha1 = "c78db948fa879903a41bce522e3b96f801c63786";
      };
    }

    {
      name = "markdown-to-jsx-6.6.9.tgz";
      path = fetchurl {
        name = "markdown-to-jsx-6.6.9.tgz";
        url  = "https://registry.yarnpkg.com/markdown-to-jsx/-/markdown-to-jsx-6.6.9.tgz";
        sha1 = "d1afea3b3194b3c9f0accf2bbb2b8594de46748d";
      };
    }

    {
      name = "marked-terminal-2.0.0.tgz";
      path = fetchurl {
        name = "marked-terminal-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/marked-terminal/-/marked-terminal-2.0.0.tgz";
        sha1 = "5eaf568be66f686541afa52a558280310a31de2d";
      };
    }

    {
      name = "marked-0.3.19.tgz";
      path = fetchurl {
        name = "marked-0.3.19.tgz";
        url  = "https://registry.yarnpkg.com/marked/-/marked-0.3.19.tgz";
        sha1 = "5d47f709c4c9fc3c216b6d46127280f40b39d790";
      };
    }

    {
      name = "math-clamp-x-1.2.0.tgz";
      path = fetchurl {
        name = "math-clamp-x-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/math-clamp-x/-/math-clamp-x-1.2.0.tgz";
        sha1 = "8b537be0645bbba7ee73ee16091e7d6018c5edcf";
      };
    }

    {
      name = "math-expression-evaluator-1.2.17.tgz";
      path = fetchurl {
        name = "math-expression-evaluator-1.2.17.tgz";
        url  = "https://registry.yarnpkg.com/math-expression-evaluator/-/math-expression-evaluator-1.2.17.tgz";
        sha1 = "de819fdbcd84dccd8fae59c6aeb79615b9d266ac";
      };
    }

    {
      name = "math-random-1.0.1.tgz";
      path = fetchurl {
        name = "math-random-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/math-random/-/math-random-1.0.1.tgz";
        sha1 = "8b3aac588b8a66e4975e3cdea67f7bb329601fac";
      };
    }

    {
      name = "math-sign-x-3.0.0.tgz";
      path = fetchurl {
        name = "math-sign-x-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/math-sign-x/-/math-sign-x-3.0.0.tgz";
        sha1 = "d5286022b48e150c384729a86042e0835264c3ed";
      };
    }

    {
      name = "mathml-tag-names-2.1.0.tgz";
      path = fetchurl {
        name = "mathml-tag-names-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/mathml-tag-names/-/mathml-tag-names-2.1.0.tgz";
        sha1 = "490b70e062ee24636536e3d9481e333733d00f2c";
      };
    }

    {
      name = "max-safe-integer-1.0.1.tgz";
      path = fetchurl {
        name = "max-safe-integer-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/max-safe-integer/-/max-safe-integer-1.0.1.tgz";
        sha1 = "f38060be2c563d8c02e6d48af39122fd83b6f410";
      };
    }

    {
      name = "md5.js-1.3.4.tgz";
      path = fetchurl {
        name = "md5.js-1.3.4.tgz";
        url  = "https://registry.yarnpkg.com/md5.js/-/md5.js-1.3.4.tgz";
        sha1 = "e9bdbde94a20a5ac18b04340fc5764d5b09d901d";
      };
    }

    {
      name = "mdast-util-compact-1.0.1.tgz";
      path = fetchurl {
        name = "mdast-util-compact-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/mdast-util-compact/-/mdast-util-compact-1.0.1.tgz";
        sha1 = "cdb5f84e2b6a2d3114df33bd05d9cb32e3c4083a";
      };
    }

    {
      name = "media-typer-0.3.0.tgz";
      path = fetchurl {
        name = "media-typer-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/media-typer/-/media-typer-0.3.0.tgz";
        sha1 = "8710d7af0aa626f8fffa1ce00168545263255748";
      };
    }

    {
      name = "mem-1.1.0.tgz";
      path = fetchurl {
        name = "mem-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/mem/-/mem-1.1.0.tgz";
        sha1 = "5edd52b485ca1d900fe64895505399a0dfa45f76";
      };
    }

    {
      name = "memdown-1.2.4.tgz";
      path = fetchurl {
        name = "memdown-1.2.4.tgz";
        url  = "https://registry.yarnpkg.com/memdown/-/memdown-1.2.4.tgz";
        sha1 = "cd9a34aaf074d53445a271108eb4b8dd4ec0f27f";
      };
    }

    {
      name = "memory-fs-0.4.1.tgz";
      path = fetchurl {
        name = "memory-fs-0.4.1.tgz";
        url  = "https://registry.yarnpkg.com/memory-fs/-/memory-fs-0.4.1.tgz";
        sha1 = "3a9a20b8462523e447cfbc7e8bb80ed667bfc552";
      };
    }

    {
      name = "meow-3.7.0.tgz";
      path = fetchurl {
        name = "meow-3.7.0.tgz";
        url  = "https://registry.yarnpkg.com/meow/-/meow-3.7.0.tgz";
        sha1 = "72cb668b425228290abbfa856892587308a801fb";
      };
    }

    {
      name = "meow-4.0.1.tgz";
      path = fetchurl {
        name = "meow-4.0.1.tgz";
        url  = "https://registry.yarnpkg.com/meow/-/meow-4.0.1.tgz";
        sha1 = "d48598f6f4b1472f35bf6317a95945ace347f975";
      };
    }

    {
      name = "merge-descriptors-1.0.1.tgz";
      path = fetchurl {
        name = "merge-descriptors-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/merge-descriptors/-/merge-descriptors-1.0.1.tgz";
        sha1 = "b00aaa556dd8b44568150ec9d1b953f3f90cbb61";
      };
    }

    {
      name = "merge-stream-1.0.1.tgz";
      path = fetchurl {
        name = "merge-stream-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/merge-stream/-/merge-stream-1.0.1.tgz";
        sha1 = "4041202d508a342ba00174008df0c251b8c135e1";
      };
    }

    {
      name = "merge-1.2.0.tgz";
      path = fetchurl {
        name = "merge-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/merge/-/merge-1.2.0.tgz";
        sha1 = "7531e39d4949c281a66b8c5a6e0265e8b05894da";
      };
    }

    {
      name = "methods-1.1.2.tgz";
      path = fetchurl {
        name = "methods-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/methods/-/methods-1.1.2.tgz";
        sha1 = "5529a4d67654134edcc5266656835b0f851afcee";
      };
    }

    {
      name = "micromatch-2.3.11.tgz";
      path = fetchurl {
        name = "micromatch-2.3.11.tgz";
        url  = "https://registry.yarnpkg.com/micromatch/-/micromatch-2.3.11.tgz";
        sha1 = "86677c97d1720b363431d04d0d15293bd38c1565";
      };
    }

    {
      name = "micromatch-3.1.10.tgz";
      path = fetchurl {
        name = "micromatch-3.1.10.tgz";
        url  = "https://registry.yarnpkg.com/micromatch/-/micromatch-3.1.10.tgz";
        sha1 = "70859bc95c9840952f359a068a3fc49f9ecfac23";
      };
    }

    {
      name = "miller-rabin-4.0.1.tgz";
      path = fetchurl {
        name = "miller-rabin-4.0.1.tgz";
        url  = "https://registry.yarnpkg.com/miller-rabin/-/miller-rabin-4.0.1.tgz";
        sha1 = "f080351c865b0dc562a8462966daa53543c78a4d";
      };
    }

    {
      name = "mime-db-1.34.0.tgz";
      path = fetchurl {
        name = "mime-db-1.34.0.tgz";
        url  = "https://registry.yarnpkg.com/mime-db/-/mime-db-1.34.0.tgz";
        sha1 = "452d0ecff5c30346a6dc1e64b1eaee0d3719ff9a";
      };
    }

    {
      name = "mime-db-1.33.0.tgz";
      path = fetchurl {
        name = "mime-db-1.33.0.tgz";
        url  = "https://registry.yarnpkg.com/mime-db/-/mime-db-1.33.0.tgz";
        sha1 = "a3492050a5cb9b63450541e39d9788d2272783db";
      };
    }

    {
      name = "mime-types-2.1.18.tgz";
      path = fetchurl {
        name = "mime-types-2.1.18.tgz";
        url  = "https://registry.yarnpkg.com/mime-types/-/mime-types-2.1.18.tgz";
        sha1 = "6f323f60a83d11146f831ff11fd66e2fe5503bb8";
      };
    }

    {
      name = "mime-1.4.1.tgz";
      path = fetchurl {
        name = "mime-1.4.1.tgz";
        url  = "https://registry.yarnpkg.com/mime/-/mime-1.4.1.tgz";
        sha1 = "121f9ebc49e3766f311a76e1fa1c8003c4b03aa6";
      };
    }

    {
      name = "mime-1.6.0.tgz";
      path = fetchurl {
        name = "mime-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/mime/-/mime-1.6.0.tgz";
        sha1 = "32cd9e5c64553bd58d19a568af452acff04981b1";
      };
    }

    {
      name = "mimic-fn-1.2.0.tgz";
      path = fetchurl {
        name = "mimic-fn-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/mimic-fn/-/mimic-fn-1.2.0.tgz";
        sha1 = "820c86a39334640e99516928bd03fca88057d022";
      };
    }

    {
      name = "min-document-2.19.0.tgz";
      path = fetchurl {
        name = "min-document-2.19.0.tgz";
        url  = "https://registry.yarnpkg.com/min-document/-/min-document-2.19.0.tgz";
        sha1 = "7bd282e3f5842ed295bb748cdd9f1ffa2c824685";
      };
    }

    {
      name = "minimalistic-assert-1.0.1.tgz";
      path = fetchurl {
        name = "minimalistic-assert-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/minimalistic-assert/-/minimalistic-assert-1.0.1.tgz";
        sha1 = "2e194de044626d4a10e7f7fbc00ce73e83e4d5c7";
      };
    }

    {
      name = "minimalistic-crypto-utils-1.0.1.tgz";
      path = fetchurl {
        name = "minimalistic-crypto-utils-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/minimalistic-crypto-utils/-/minimalistic-crypto-utils-1.0.1.tgz";
        sha1 = "f6c00c1c0b082246e5c4d99dfb8c7c083b2b582a";
      };
    }

    {
      name = "minimatch-3.0.4.tgz";
      path = fetchurl {
        name = "minimatch-3.0.4.tgz";
        url  = "https://registry.yarnpkg.com/minimatch/-/minimatch-3.0.4.tgz";
        sha1 = "5166e286457f03306064be5497e8dbb0c3d32083";
      };
    }

    {
      name = "minimatch-3.0.3.tgz";
      path = fetchurl {
        name = "minimatch-3.0.3.tgz";
        url  = "https://registry.yarnpkg.com/minimatch/-/minimatch-3.0.3.tgz";
        sha1 = "2a4e4090b96b2db06a9d7df01055a62a77c9b774";
      };
    }

    {
      name = "minimist-options-3.0.2.tgz";
      path = fetchurl {
        name = "minimist-options-3.0.2.tgz";
        url  = "https://registry.yarnpkg.com/minimist-options/-/minimist-options-3.0.2.tgz";
        sha1 = "fba4c8191339e13ecf4d61beb03f070103f3d954";
      };
    }

    {
      name = "minimist-0.0.8.tgz";
      path = fetchurl {
        name = "minimist-0.0.8.tgz";
        url  = "https://registry.yarnpkg.com/minimist/-/minimist-0.0.8.tgz";
        sha1 = "857fcabfc3397d2625b8228262e86aa7a011b05d";
      };
    }

    {
      name = "minimist-1.1.3.tgz";
      path = fetchurl {
        name = "minimist-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/minimist/-/minimist-1.1.3.tgz";
        sha1 = "3bedfd91a92d39016fcfaa1c681e8faa1a1efda8";
      };
    }

    {
      name = "minimist-0.1.0.tgz";
      path = fetchurl {
        name = "minimist-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/minimist/-/minimist-0.1.0.tgz";
        sha1 = "99df657a52574c21c9057497df742790b2b4c0de";
      };
    }

    {
      name = "minimist-1.2.0.tgz";
      path = fetchurl {
        name = "minimist-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/minimist/-/minimist-1.2.0.tgz";
        sha1 = "a35008b20f41383eec1fb914f4cd5df79a264284";
      };
    }

    {
      name = "minimist-0.0.10.tgz";
      path = fetchurl {
        name = "minimist-0.0.10.tgz";
        url  = "https://registry.yarnpkg.com/minimist/-/minimist-0.0.10.tgz";
        sha1 = "de3f98543dbf96082be48ad1a0c7cda836301dcf";
      };
    }

    {
      name = "minipass-2.3.3.tgz";
      path = fetchurl {
        name = "minipass-2.3.3.tgz";
        url  = "https://registry.yarnpkg.com/minipass/-/minipass-2.3.3.tgz";
        sha1 = "a7dcc8b7b833f5d368759cce544dccb55f50f233";
      };
    }

    {
      name = "minizlib-1.1.0.tgz";
      path = fetchurl {
        name = "minizlib-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/minizlib/-/minizlib-1.1.0.tgz";
        sha1 = "11e13658ce46bc3a70a267aac58359d1e0c29ceb";
      };
    }

    {
      name = "mississippi-2.0.0.tgz";
      path = fetchurl {
        name = "mississippi-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/mississippi/-/mississippi-2.0.0.tgz";
        sha1 = "3442a508fafc28500486feea99409676e4ee5a6f";
      };
    }

    {
      name = "mixin-deep-1.3.1.tgz";
      path = fetchurl {
        name = "mixin-deep-1.3.1.tgz";
        url  = "https://registry.yarnpkg.com/mixin-deep/-/mixin-deep-1.3.1.tgz";
        sha1 = "a49e7268dce1a0d9698e45326c5626df3543d0fe";
      };
    }

    {
      name = "mixin-object-2.0.1.tgz";
      path = fetchurl {
        name = "mixin-object-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/mixin-object/-/mixin-object-2.0.1.tgz";
        sha1 = "4fb949441dab182540f1fe035ba60e1947a5e57e";
      };
    }

    {
      name = "mkdirp2-1.0.4.tgz";
      path = fetchurl {
        name = "mkdirp2-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/mkdirp2/-/mkdirp2-1.0.4.tgz";
        sha1 = "56de1f8f5c93cf2199906362eba0f9f262ee4437";
      };
    }

    {
      name = "mkdirp-0.5.0.tgz";
      path = fetchurl {
        name = "mkdirp-0.5.0.tgz";
        url  = "https://registry.yarnpkg.com/mkdirp/-/mkdirp-0.5.0.tgz";
        sha1 = "1d73076a6df986cd9344e15e71fcc05a4c9abf12";
      };
    }

    {
      name = "mkdirp-0.5.1.tgz";
      path = fetchurl {
        name = "mkdirp-0.5.1.tgz";
        url  = "https://registry.yarnpkg.com/mkdirp/-/mkdirp-0.5.1.tgz";
        sha1 = "30057438eac6cf7f8c4767f38648d6697d75c903";
      };
    }

    {
      name = "modify-values-1.0.1.tgz";
      path = fetchurl {
        name = "modify-values-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/modify-values/-/modify-values-1.0.1.tgz";
        sha1 = "b3939fa605546474e3e3e3c63d64bd43b4ee6022";
      };
    }

    {
      name = "moment-duration-format-1.3.0.tgz";
      path = fetchurl {
        name = "moment-duration-format-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/moment-duration-format/-/moment-duration-format-1.3.0.tgz";
        sha1 = "541771b5f87a049cc65540475d3ad966737d6908";
      };
    }

    {
      name = "moment-2.22.2.tgz";
      path = fetchurl {
        name = "moment-2.22.2.tgz";
        url  = "https://registry.yarnpkg.com/moment/-/moment-2.22.2.tgz";
        sha1 = "3c257f9839fc0e93ff53149632239eb90783ff66";
      };
    }

    {
      name = "morgan-1.9.0.tgz";
      path = fetchurl {
        name = "morgan-1.9.0.tgz";
        url  = "https://registry.yarnpkg.com/morgan/-/morgan-1.9.0.tgz";
        sha1 = "d01fa6c65859b76fcf31b3cb53a3821a311d8051";
      };
    }

    {
      name = "move-concurrently-1.0.1.tgz";
      path = fetchurl {
        name = "move-concurrently-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/move-concurrently/-/move-concurrently-1.0.1.tgz";
        sha1 = "be2c005fda32e0b29af1f05d7c4b33214c701f92";
      };
    }

    {
      name = "ms-2.0.0.tgz";
      path = fetchurl {
        name = "ms-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/ms/-/ms-2.0.0.tgz";
        sha1 = "5608aeadfc00be6c2901df5f9861788de0d597c8";
      };
    }

    {
      name = "ms-2.1.1.tgz";
      path = fetchurl {
        name = "ms-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/ms/-/ms-2.1.1.tgz";
        sha1 = "30a5864eb3ebb0a66f2ebe6d727af06a09d86e0a";
      };
    }

    {
      name = "multer-1.3.1.tgz";
      path = fetchurl {
        name = "multer-1.3.1.tgz";
        url  = "https://registry.yarnpkg.com/multer/-/multer-1.3.1.tgz";
        sha1 = "c3fb3b35f50c7eefe873532f90d3dde02ce6e040";
      };
    }

    {
      name = "multicast-dns-service-types-1.1.0.tgz";
      path = fetchurl {
        name = "multicast-dns-service-types-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/multicast-dns-service-types/-/multicast-dns-service-types-1.1.0.tgz";
        sha1 = "899f11d9686e5e05cb91b35d5f0e63b773cfc901";
      };
    }

    {
      name = "multicast-dns-6.2.3.tgz";
      path = fetchurl {
        name = "multicast-dns-6.2.3.tgz";
        url  = "https://registry.yarnpkg.com/multicast-dns/-/multicast-dns-6.2.3.tgz";
        sha1 = "a0ec7bd9055c4282f790c3c82f4e28db3b31b229";
      };
    }

    {
      name = "mustache-2.3.0.tgz";
      path = fetchurl {
        name = "mustache-2.3.0.tgz";
        url  = "https://registry.yarnpkg.com/mustache/-/mustache-2.3.0.tgz";
        sha1 = "4028f7778b17708a489930a6e52ac3bca0da41d0";
      };
    }

    {
      name = "mute-stream-0.0.5.tgz";
      path = fetchurl {
        name = "mute-stream-0.0.5.tgz";
        url  = "https://registry.yarnpkg.com/mute-stream/-/mute-stream-0.0.5.tgz";
        sha1 = "8fbfabb0a98a253d3184331f9e8deb7372fac6c0";
      };
    }

    {
      name = "mute-stream-0.0.7.tgz";
      path = fetchurl {
        name = "mute-stream-0.0.7.tgz";
        url  = "https://registry.yarnpkg.com/mute-stream/-/mute-stream-0.0.7.tgz";
        sha1 = "3075ce93bc21b8fab43e1bc4da7e8115ed1e7bab";
      };
    }

    {
      name = "nan-x-1.0.2.tgz";
      path = fetchurl {
        name = "nan-x-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/nan-x/-/nan-x-1.0.2.tgz";
        sha1 = "5f34e9d3115242486219eee3c8bc49fd2425b19a";
      };
    }

    {
      name = "nan-2.10.0.tgz";
      path = fetchurl {
        name = "nan-2.10.0.tgz";
        url  = "https://registry.yarnpkg.com/nan/-/nan-2.10.0.tgz";
        sha1 = "96d0cd610ebd58d4b4de9cc0c6828cda99c7548f";
      };
    }

    {
      name = "nanoid-0.2.2.tgz";
      path = fetchurl {
        name = "nanoid-0.2.2.tgz";
        url  = "https://registry.yarnpkg.com/nanoid/-/nanoid-0.2.2.tgz";
        sha1 = "e2ebc6ad3db5e0454fd8124d30ca39b06555fe56";
      };
    }

    {
      name = "nanoid-1.0.7.tgz";
      path = fetchurl {
        name = "nanoid-1.0.7.tgz";
        url  = "https://registry.yarnpkg.com/nanoid/-/nanoid-1.0.7.tgz";
        sha1 = "23857a9514ae8efb7374221b923a2b92be3f74f2";
      };
    }

    {
      name = "nanomatch-1.2.13.tgz";
      path = fetchurl {
        name = "nanomatch-1.2.13.tgz";
        url  = "https://registry.yarnpkg.com/nanomatch/-/nanomatch-1.2.13.tgz";
        sha1 = "b87a8aa4fc0de8fe6be88895b38983ff265bd119";
      };
    }

    {
      name = "native-promise-only-0.8.1.tgz";
      path = fetchurl {
        name = "native-promise-only-0.8.1.tgz";
        url  = "https://registry.yarnpkg.com/native-promise-only/-/native-promise-only-0.8.1.tgz";
        sha1 = "20a318c30cb45f71fe7adfbf7b21c99c1472ef11";
      };
    }

    {
      name = "natural-compare-1.4.0.tgz";
      path = fetchurl {
        name = "natural-compare-1.4.0.tgz";
        url  = "https://registry.yarnpkg.com/natural-compare/-/natural-compare-1.4.0.tgz";
        sha1 = "4abebfeed7541f2c27acfb29bdbbd15c8d5ba4f7";
      };
    }

    {
      name = "nconf-0.6.9.tgz";
      path = fetchurl {
        name = "nconf-0.6.9.tgz";
        url  = "https://registry.yarnpkg.com/nconf/-/nconf-0.6.9.tgz";
        sha1 = "9570ef15ed6f9ae6b2b3c8d5e71b66d3193cd661";
      };
    }

    {
      name = "ncp-0.4.2.tgz";
      path = fetchurl {
        name = "ncp-0.4.2.tgz";
        url  = "https://registry.yarnpkg.com/ncp/-/ncp-0.4.2.tgz";
        sha1 = "abcc6cbd3ec2ed2a729ff6e7c1fa8f01784a8574";
      };
    }

    {
      name = "ncp-1.0.1.tgz";
      path = fetchurl {
        name = "ncp-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/ncp/-/ncp-1.0.1.tgz";
        sha1 = "d15367e5cb87432ba117d2bf80fdf45aecfb4246";
      };
    }

    {
      name = "nearley-2.13.0.tgz";
      path = fetchurl {
        name = "nearley-2.13.0.tgz";
        url  = "https://registry.yarnpkg.com/nearley/-/nearley-2.13.0.tgz";
        sha1 = "6e7b0f4e68bfc3e74c99eaef2eda39e513143439";
      };
    }

    {
      name = "needle-2.2.1.tgz";
      path = fetchurl {
        name = "needle-2.2.1.tgz";
        url  = "https://registry.yarnpkg.com/needle/-/needle-2.2.1.tgz";
        sha1 = "b5e325bd3aae8c2678902fa296f729455d1d3a7d";
      };
    }

    {
      name = "negotiator-0.6.1.tgz";
      path = fetchurl {
        name = "negotiator-0.6.1.tgz";
        url  = "https://registry.yarnpkg.com/negotiator/-/negotiator-0.6.1.tgz";
        sha1 = "2b327184e8992101177b28563fb5e7102acd0ca9";
      };
    }

    {
      name = "neo-async-2.5.1.tgz";
      path = fetchurl {
        name = "neo-async-2.5.1.tgz";
        url  = "https://registry.yarnpkg.com/neo-async/-/neo-async-2.5.1.tgz";
        sha1 = "acb909e327b1e87ec9ef15f41b8a269512ad41ee";
      };
    }

    {
      name = "next-tick-1.0.0.tgz";
      path = fetchurl {
        name = "next-tick-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/next-tick/-/next-tick-1.0.0.tgz";
        sha1 = "ca86d1fe8828169b0120208e3dc8424b9db8342c";
      };
    }

    {
      name = "no-case-2.3.2.tgz";
      path = fetchurl {
        name = "no-case-2.3.2.tgz";
        url  = "https://registry.yarnpkg.com/no-case/-/no-case-2.3.2.tgz";
        sha1 = "60b813396be39b3f1288a4c1ed5d1e7d28b464ac";
      };
    }

    {
      name = "nocache-2.0.0.tgz";
      path = fetchurl {
        name = "nocache-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/nocache/-/nocache-2.0.0.tgz";
        sha1 = "202b48021a0c4cbde2df80de15a17443c8b43980";
      };
    }

    {
      name = "node-dir-0.1.17.tgz";
      path = fetchurl {
        name = "node-dir-0.1.17.tgz";
        url  = "https://registry.yarnpkg.com/node-dir/-/node-dir-0.1.17.tgz";
        sha1 = "5f5665d93351335caabef8f1c554516cf5f1e4e5";
      };
    }

    {
      name = "node-emoji-1.8.1.tgz";
      path = fetchurl {
        name = "node-emoji-1.8.1.tgz";
        url  = "https://registry.yarnpkg.com/node-emoji/-/node-emoji-1.8.1.tgz";
        sha1 = "6eec6bfb07421e2148c75c6bba72421f8530a826";
      };
    }

    {
      name = "node-fetch-1.7.3.tgz";
      path = fetchurl {
        name = "node-fetch-1.7.3.tgz";
        url  = "https://registry.yarnpkg.com/node-fetch/-/node-fetch-1.7.3.tgz";
        sha1 = "980f6f72d85211a5347c6b2bc18c5b84c3eb47ef";
      };
    }

    {
      name = "node-forge-0.7.5.tgz";
      path = fetchurl {
        name = "node-forge-0.7.5.tgz";
        url  = "https://registry.yarnpkg.com/node-forge/-/node-forge-0.7.5.tgz";
        sha1 = "6c152c345ce11c52f465c2abd957e8639cd674df";
      };
    }

    {
      name = "node-gyp-3.7.0.tgz";
      path = fetchurl {
        name = "node-gyp-3.7.0.tgz";
        url  = "https://registry.yarnpkg.com/node-gyp/-/node-gyp-3.7.0.tgz";
        sha1 = "789478e8f6c45e277aa014f3e28f958f286f9203";
      };
    }

    {
      name = "node-int64-0.4.0.tgz";
      path = fetchurl {
        name = "node-int64-0.4.0.tgz";
        url  = "https://registry.yarnpkg.com/node-int64/-/node-int64-0.4.0.tgz";
        sha1 = "87a9065cdb355d3182d8f94ce11188b825c68a3b";
      };
    }

    {
      name = "node-libs-browser-2.1.0.tgz";
      path = fetchurl {
        name = "node-libs-browser-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/node-libs-browser/-/node-libs-browser-2.1.0.tgz";
        sha1 = "5f94263d404f6e44767d726901fff05478d600df";
      };
    }

    {
      name = "node-notifier-4.6.1.tgz";
      path = fetchurl {
        name = "node-notifier-4.6.1.tgz";
        url  = "https://registry.yarnpkg.com/node-notifier/-/node-notifier-4.6.1.tgz";
        sha1 = "056d14244f3dcc1ceadfe68af9cff0c5473a33f3";
      };
    }

    {
      name = "node-notifier-5.2.1.tgz";
      path = fetchurl {
        name = "node-notifier-5.2.1.tgz";
        url  = "https://registry.yarnpkg.com/node-notifier/-/node-notifier-5.2.1.tgz";
        sha1 = "fa313dd08f5517db0e2502e5758d664ac69f9dea";
      };
    }

    {
      name = "node-pre-gyp-0.9.1.tgz";
      path = fetchurl {
        name = "node-pre-gyp-0.9.1.tgz";
        url  = "https://registry.yarnpkg.com/node-pre-gyp/-/node-pre-gyp-0.9.1.tgz";
        sha1 = "f11c07516dd92f87199dbc7e1838eab7cd56c9e0";
      };
    }

    {
      name = "node-pre-gyp-0.10.3.tgz";
      path = fetchurl {
        name = "node-pre-gyp-0.10.3.tgz";
        url  = "https://registry.yarnpkg.com/node-pre-gyp/-/node-pre-gyp-0.10.3.tgz";
        sha1 = "3070040716afdc778747b61b6887bf78880b80fc";
      };
    }

    {
      name = "node-pre-gyp-0.6.39.tgz";
      path = fetchurl {
        name = "node-pre-gyp-0.6.39.tgz";
        url  = "https://registry.yarnpkg.com/node-pre-gyp/-/node-pre-gyp-0.6.39.tgz";
        sha1 = "c00e96860b23c0e1420ac7befc5044e1d78d8649";
      };
    }

    {
      name = "node-sass-4.9.2.tgz";
      path = fetchurl {
        name = "node-sass-4.9.2.tgz";
        url  = "https://registry.yarnpkg.com/node-sass/-/node-sass-4.9.2.tgz";
        sha1 = "5e63fe6bd0f2ae3ac9d6c14ede8620e2b8bdb437";
      };
    }

    {
      name = "node-version-1.1.0.tgz";
      path = fetchurl {
        name = "node-version-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/node-version/-/node-version-1.1.0.tgz";
        sha1 = "f437d7ba407e65e2c4eaef8887b1718ba523d4f0";
      };
    }

    {
      name = "node-version-1.2.0.tgz";
      path = fetchurl {
        name = "node-version-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/node-version/-/node-version-1.2.0.tgz";
        sha1 = "34fde3ffa8e1149bd323983479dda620e1b5060d";
      };
    }

    {
      name = "nodemailer-4.6.7.tgz";
      path = fetchurl {
        name = "nodemailer-4.6.7.tgz";
        url  = "https://registry.yarnpkg.com/nodemailer/-/nodemailer-4.6.7.tgz";
        sha1 = "b68de7f36d65618bdeeeb76234e3547d51266373";
      };
    }

    {
      name = "nomnom-1.6.2.tgz";
      path = fetchurl {
        name = "nomnom-1.6.2.tgz";
        url  = "https://registry.yarnpkg.com/nomnom/-/nomnom-1.6.2.tgz";
        sha1 = "84a66a260174408fc5b77a18f888eccc44fb6971";
      };
    }

    {
      name = "nopt-3.0.6.tgz";
      path = fetchurl {
        name = "nopt-3.0.6.tgz";
        url  = "https://registry.yarnpkg.com/nopt/-/nopt-3.0.6.tgz";
        sha1 = "c6465dbf08abcd4db359317f79ac68a646b28ff9";
      };
    }

    {
      name = "nopt-4.0.1.tgz";
      path = fetchurl {
        name = "nopt-4.0.1.tgz";
        url  = "https://registry.yarnpkg.com/nopt/-/nopt-4.0.1.tgz";
        sha1 = "d0d4685afd5415193c8c7505602d0d17cd64474d";
      };
    }

    {
      name = "normalize-package-data-2.4.0.tgz";
      path = fetchurl {
        name = "normalize-package-data-2.4.0.tgz";
        url  = "https://registry.yarnpkg.com/normalize-package-data/-/normalize-package-data-2.4.0.tgz";
        sha1 = "12f95a307d58352075a04907b84ac8be98ac012f";
      };
    }

    {
      name = "normalize-path-1.0.0.tgz";
      path = fetchurl {
        name = "normalize-path-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/normalize-path/-/normalize-path-1.0.0.tgz";
        sha1 = "32d0e472f91ff345701c15a8311018d3b0a90379";
      };
    }

    {
      name = "normalize-path-2.1.1.tgz";
      path = fetchurl {
        name = "normalize-path-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/normalize-path/-/normalize-path-2.1.1.tgz";
        sha1 = "1ab28b556e198363a8c1a6f7e6fa20137fe6aed9";
      };
    }

    {
      name = "normalize-range-0.1.2.tgz";
      path = fetchurl {
        name = "normalize-range-0.1.2.tgz";
        url  = "https://registry.yarnpkg.com/normalize-range/-/normalize-range-0.1.2.tgz";
        sha1 = "2d10c06bdfd312ea9777695a4d28439456b75942";
      };
    }

    {
      name = "normalize-selector-0.2.0.tgz";
      path = fetchurl {
        name = "normalize-selector-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/normalize-selector/-/normalize-selector-0.2.0.tgz";
        sha1 = "d0b145eb691189c63a78d201dc4fdb1293ef0c03";
      };
    }

    {
      name = "normalize-space-x-3.0.0.tgz";
      path = fetchurl {
        name = "normalize-space-x-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/normalize-space-x/-/normalize-space-x-3.0.0.tgz";
        sha1 = "17907d6c7c724a4f9567471cbb319553bc0f8882";
      };
    }

    {
      name = "normalize-url-1.9.1.tgz";
      path = fetchurl {
        name = "normalize-url-1.9.1.tgz";
        url  = "https://registry.yarnpkg.com/normalize-url/-/normalize-url-1.9.1.tgz";
        sha1 = "2cc0d66b31ea23036458436e3620d85954c66c3c";
      };
    }

    {
      name = "npm-bundled-1.0.3.tgz";
      path = fetchurl {
        name = "npm-bundled-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/npm-bundled/-/npm-bundled-1.0.3.tgz";
        sha1 = "7e71703d973af3370a9591bafe3a63aca0be2308";
      };
    }

    {
      name = "npm-packlist-1.1.10.tgz";
      path = fetchurl {
        name = "npm-packlist-1.1.10.tgz";
        url  = "https://registry.yarnpkg.com/npm-packlist/-/npm-packlist-1.1.10.tgz";
        sha1 = "1039db9e985727e464df066f4cf0ab6ef85c398a";
      };
    }

    {
      name = "npm-path-2.0.4.tgz";
      path = fetchurl {
        name = "npm-path-2.0.4.tgz";
        url  = "https://registry.yarnpkg.com/npm-path/-/npm-path-2.0.4.tgz";
        sha1 = "c641347a5ff9d6a09e4d9bce5580c4f505278e64";
      };
    }

    {
      name = "npm-run-path-2.0.2.tgz";
      path = fetchurl {
        name = "npm-run-path-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/npm-run-path/-/npm-run-path-2.0.2.tgz";
        sha1 = "35a9232dfa35d7067b4cb2ddf2357b1871536c5f";
      };
    }

    {
      name = "npm-which-3.0.1.tgz";
      path = fetchurl {
        name = "npm-which-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/npm-which/-/npm-which-3.0.1.tgz";
        sha1 = "9225f26ec3a285c209cae67c3b11a6b4ab7140aa";
      };
    }

    {
      name = "npmlog-4.1.2.tgz";
      path = fetchurl {
        name = "npmlog-4.1.2.tgz";
        url  = "https://registry.yarnpkg.com/npmlog/-/npmlog-4.1.2.tgz";
        sha1 = "08a7f2a8bf734604779a9efa4ad5cc717abb954b";
      };
    }

    {
      name = "nth-check-1.0.1.tgz";
      path = fetchurl {
        name = "nth-check-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/nth-check/-/nth-check-1.0.1.tgz";
        sha1 = "9929acdf628fc2c41098deab82ac580cf149aae4";
      };
    }

    {
      name = "num2fraction-1.2.2.tgz";
      path = fetchurl {
        name = "num2fraction-1.2.2.tgz";
        url  = "https://registry.yarnpkg.com/num2fraction/-/num2fraction-1.2.2.tgz";
        sha1 = "6f682b6a027a4e9ddfa4564cd2589d1d4e669ede";
      };
    }

    {
      name = "number-is-nan-1.0.1.tgz";
      path = fetchurl {
        name = "number-is-nan-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/number-is-nan/-/number-is-nan-1.0.1.tgz";
        sha1 = "097b602b53422a522c1afb8790318336941a011d";
      };
    }

    {
      name = "nwmatcher-1.4.4.tgz";
      path = fetchurl {
        name = "nwmatcher-1.4.4.tgz";
        url  = "https://registry.yarnpkg.com/nwmatcher/-/nwmatcher-1.4.4.tgz";
        sha1 = "2285631f34a95f0d0395cd900c96ed39b58f346e";
      };
    }

    {
      name = "nwsapi-2.0.4.tgz";
      path = fetchurl {
        name = "nwsapi-2.0.4.tgz";
        url  = "https://registry.yarnpkg.com/nwsapi/-/nwsapi-2.0.4.tgz";
        sha1 = "dc79040a5f77b97716dc79565fc7fc3ef7d50570";
      };
    }

    {
      name = "oauth-sign-0.8.2.tgz";
      path = fetchurl {
        name = "oauth-sign-0.8.2.tgz";
        url  = "https://registry.yarnpkg.com/oauth-sign/-/oauth-sign-0.8.2.tgz";
        sha1 = "46a6ab7f0aead8deae9ec0565780b7d4efeb9d43";
      };
    }

    {
      name = "object-assign-3.0.0.tgz";
      path = fetchurl {
        name = "object-assign-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/object-assign/-/object-assign-3.0.0.tgz";
        sha1 = "9bedd5ca0897949bca47e7ff408062d549f587f2";
      };
    }

    {
      name = "object-assign-4.1.1.tgz";
      path = fetchurl {
        name = "object-assign-4.1.1.tgz";
        url  = "https://registry.yarnpkg.com/object-assign/-/object-assign-4.1.1.tgz";
        sha1 = "2109adc7965887cfc05cbbd442cac8bfbb360863";
      };
    }

    {
      name = "object-copy-0.1.0.tgz";
      path = fetchurl {
        name = "object-copy-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/object-copy/-/object-copy-0.1.0.tgz";
        sha1 = "7e7d858b781bd7c991a41ba975ed3812754e998c";
      };
    }

    {
      name = "object-get-own-property-descriptor-x-3.2.0.tgz";
      path = fetchurl {
        name = "object-get-own-property-descriptor-x-3.2.0.tgz";
        url  = "https://registry.yarnpkg.com/object-get-own-property-descriptor-x/-/object-get-own-property-descriptor-x-3.2.0.tgz";
        sha1 = "464585ad03e66108ed166c99325b8d2c5ba93712";
      };
    }

    {
      name = "object-get-2.1.0.tgz";
      path = fetchurl {
        name = "object-get-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/object-get/-/object-get-2.1.0.tgz";
        sha1 = "722bbdb60039efa47cad3c6dc2ce51a85c02c5ae";
      };
    }

    {
      name = "object-hash-1.3.0.tgz";
      path = fetchurl {
        name = "object-hash-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/object-hash/-/object-hash-1.3.0.tgz";
        sha1 = "76d9ba6ff113cf8efc0d996102851fe6723963e2";
      };
    }

    {
      name = "object-inspect-1.6.0.tgz";
      path = fetchurl {
        name = "object-inspect-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/object-inspect/-/object-inspect-1.6.0.tgz";
        sha1 = "c70b6cbf72f274aab4c34c0c82f5167bf82cf15b";
      };
    }

    {
      name = "object-is-1.0.1.tgz";
      path = fetchurl {
        name = "object-is-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/object-is/-/object-is-1.0.1.tgz";
        sha1 = "0aa60ec9989a0b3ed795cf4d06f62cf1ad6539b6";
      };
    }

    {
      name = "object-keys-1.0.12.tgz";
      path = fetchurl {
        name = "object-keys-1.0.12.tgz";
        url  = "https://registry.yarnpkg.com/object-keys/-/object-keys-1.0.12.tgz";
        sha1 = "09c53855377575310cca62f55bb334abff7b3ed2";
      };
    }

    {
      name = "object-path-0.11.4.tgz";
      path = fetchurl {
        name = "object-path-0.11.4.tgz";
        url  = "https://registry.yarnpkg.com/object-path/-/object-path-0.11.4.tgz";
        sha1 = "370ae752fbf37de3ea70a861c23bba8915691949";
      };
    }

    {
      name = "object-to-spawn-args-1.1.1.tgz";
      path = fetchurl {
        name = "object-to-spawn-args-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/object-to-spawn-args/-/object-to-spawn-args-1.1.1.tgz";
        sha1 = "77da8827f073d011c9e1b173f895781470246785";
      };
    }

    {
      name = "object-values-1.0.0.tgz";
      path = fetchurl {
        name = "object-values-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/object-values/-/object-values-1.0.0.tgz";
        sha1 = "72af839630119e5b98c3b02bb8c27e3237158105";
      };
    }

    {
      name = "object-visit-1.0.1.tgz";
      path = fetchurl {
        name = "object-visit-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/object-visit/-/object-visit-1.0.1.tgz";
        sha1 = "f79c4493af0c5377b59fe39d395e41042dd045bb";
      };
    }

    {
      name = "object.assign-4.1.0.tgz";
      path = fetchurl {
        name = "object.assign-4.1.0.tgz";
        url  = "https://registry.yarnpkg.com/object.assign/-/object.assign-4.1.0.tgz";
        sha1 = "968bf1100d7956bb3ca086f006f846b3bc4008da";
      };
    }

    {
      name = "object.entries-1.0.4.tgz";
      path = fetchurl {
        name = "object.entries-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/object.entries/-/object.entries-1.0.4.tgz";
        sha1 = "1bf9a4dd2288f5b33f3a993d257661f05d161a5f";
      };
    }

    {
      name = "object.getownpropertydescriptors-2.0.3.tgz";
      path = fetchurl {
        name = "object.getownpropertydescriptors-2.0.3.tgz";
        url  = "https://registry.yarnpkg.com/object.getownpropertydescriptors/-/object.getownpropertydescriptors-2.0.3.tgz";
        sha1 = "8758c846f5b407adab0f236e0986f14b051caa16";
      };
    }

    {
      name = "object.omit-2.0.1.tgz";
      path = fetchurl {
        name = "object.omit-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/object.omit/-/object.omit-2.0.1.tgz";
        sha1 = "1a9c744829f39dbb858c76ca3579ae2a54ebd1fa";
      };
    }

    {
      name = "object.pick-1.3.0.tgz";
      path = fetchurl {
        name = "object.pick-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/object.pick/-/object.pick-1.3.0.tgz";
        sha1 = "87a10ac4c1694bd2e1cbf53591a66141fb5dd747";
      };
    }

    {
      name = "object.values-1.0.4.tgz";
      path = fetchurl {
        name = "object.values-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/object.values/-/object.values-1.0.4.tgz";
        sha1 = "e524da09b4f66ff05df457546ec72ac99f13069a";
      };
    }

    {
      name = "obuf-1.1.2.tgz";
      path = fetchurl {
        name = "obuf-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/obuf/-/obuf-1.1.2.tgz";
        sha1 = "09bea3343d41859ebd446292d11c9d4db619084e";
      };
    }

    {
      name = "on-finished-2.3.0.tgz";
      path = fetchurl {
        name = "on-finished-2.3.0.tgz";
        url  = "https://registry.yarnpkg.com/on-finished/-/on-finished-2.3.0.tgz";
        sha1 = "20f1336481b083cd75337992a16971aa2d906947";
      };
    }

    {
      name = "on-headers-1.0.1.tgz";
      path = fetchurl {
        name = "on-headers-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/on-headers/-/on-headers-1.0.1.tgz";
        sha1 = "928f5d0f470d49342651ea6794b0857c100693f7";
      };
    }

    {
      name = "once-1.4.0.tgz";
      path = fetchurl {
        name = "once-1.4.0.tgz";
        url  = "https://registry.yarnpkg.com/once/-/once-1.4.0.tgz";
        sha1 = "583b1aa775961d4b113ac17d9c50baef9dd76bd1";
      };
    }

    {
      name = "onetime-1.1.0.tgz";
      path = fetchurl {
        name = "onetime-1.1.0.tgz";
        url  = "http://registry.npmjs.org/onetime/-/onetime-1.1.0.tgz";
        sha1 = "a1f7838f8314c516f05ecefcbc4ccfe04b4ed789";
      };
    }

    {
      name = "onetime-2.0.1.tgz";
      path = fetchurl {
        name = "onetime-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/onetime/-/onetime-2.0.1.tgz";
        sha1 = "067428230fd67443b2794b22bba528b6867962d4";
      };
    }

    {
      name = "opn-5.2.0.tgz";
      path = fetchurl {
        name = "opn-5.2.0.tgz";
        url  = "https://registry.yarnpkg.com/opn/-/opn-5.2.0.tgz";
        sha1 = "71fdf934d6827d676cecbea1531f95d354641225";
      };
    }

    {
      name = "opn-5.3.0.tgz";
      path = fetchurl {
        name = "opn-5.3.0.tgz";
        url  = "https://registry.yarnpkg.com/opn/-/opn-5.3.0.tgz";
        sha1 = "64871565c863875f052cfdf53d3e3cb5adb53b1c";
      };
    }

    {
      name = "optimist-0.2.8.tgz";
      path = fetchurl {
        name = "optimist-0.2.8.tgz";
        url  = "https://registry.yarnpkg.com/optimist/-/optimist-0.2.8.tgz";
        sha1 = "e981ab7e268b457948593b55674c099a815cac31";
      };
    }

    {
      name = "optimist-0.6.0.tgz";
      path = fetchurl {
        name = "optimist-0.6.0.tgz";
        url  = "https://registry.yarnpkg.com/optimist/-/optimist-0.6.0.tgz";
        sha1 = "69424826f3405f79f142e6fc3d9ae58d4dbb9200";
      };
    }

    {
      name = "optimist-0.6.1.tgz";
      path = fetchurl {
        name = "optimist-0.6.1.tgz";
        url  = "https://registry.yarnpkg.com/optimist/-/optimist-0.6.1.tgz";
        sha1 = "da3ea74686fa21a19a111c326e90eb15a0196686";
      };
    }

    {
      name = "optionator-0.8.2.tgz";
      path = fetchurl {
        name = "optionator-0.8.2.tgz";
        url  = "https://registry.yarnpkg.com/optionator/-/optionator-0.8.2.tgz";
        sha1 = "364c5e409d3f4d6301d6c0b4c05bba50180aeb64";
      };
    }

    {
      name = "ora-0.2.3.tgz";
      path = fetchurl {
        name = "ora-0.2.3.tgz";
        url  = "https://registry.yarnpkg.com/ora/-/ora-0.2.3.tgz";
        sha1 = "37527d220adcd53c39b73571d754156d5db657a4";
      };
    }

    {
      name = "ora-2.1.0.tgz";
      path = fetchurl {
        name = "ora-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/ora/-/ora-2.1.0.tgz";
        sha1 = "6caf2830eb924941861ec53a173799e008b51e5b";
      };
    }

    {
      name = "original-1.0.1.tgz";
      path = fetchurl {
        name = "original-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/original/-/original-1.0.1.tgz";
        sha1 = "b0a53ff42ba997a8c9cd1fb5daaeb42b9d693190";
      };
    }

    {
      name = "os-browserify-0.3.0.tgz";
      path = fetchurl {
        name = "os-browserify-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/os-browserify/-/os-browserify-0.3.0.tgz";
        sha1 = "854373c7f5c2315914fc9bfc6bd8238fdda1ec27";
      };
    }

    {
      name = "os-family-1.0.0.tgz";
      path = fetchurl {
        name = "os-family-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/os-family/-/os-family-1.0.0.tgz";
        sha1 = "d12308c424a36302a1c106a95287bbdd5ca2477f";
      };
    }

    {
      name = "os-homedir-1.0.2.tgz";
      path = fetchurl {
        name = "os-homedir-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/os-homedir/-/os-homedir-1.0.2.tgz";
        sha1 = "ffbc4988336e0e833de0c168c7ef152121aa7fb3";
      };
    }

    {
      name = "os-locale-1.4.0.tgz";
      path = fetchurl {
        name = "os-locale-1.4.0.tgz";
        url  = "https://registry.yarnpkg.com/os-locale/-/os-locale-1.4.0.tgz";
        sha1 = "20f9f17ae29ed345e8bde583b13d2009803c14d9";
      };
    }

    {
      name = "os-locale-2.1.0.tgz";
      path = fetchurl {
        name = "os-locale-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/os-locale/-/os-locale-2.1.0.tgz";
        sha1 = "42bc2900a6b5b8bd17376c8e882b65afccf24bf2";
      };
    }

    {
      name = "os-tmpdir-1.0.2.tgz";
      path = fetchurl {
        name = "os-tmpdir-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/os-tmpdir/-/os-tmpdir-1.0.2.tgz";
        sha1 = "bbe67406c79aa85c5cfec766fe5734555dfa1274";
      };
    }

    {
      name = "osenv-0.1.5.tgz";
      path = fetchurl {
        name = "osenv-0.1.5.tgz";
        url  = "https://registry.yarnpkg.com/osenv/-/osenv-0.1.5.tgz";
        sha1 = "85cdfafaeb28e8677f416e287592b5f3f49ea410";
      };
    }

    {
      name = "p-finally-1.0.0.tgz";
      path = fetchurl {
        name = "p-finally-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/p-finally/-/p-finally-1.0.0.tgz";
        sha1 = "3fbcfb15b899a44123b34b6dcc18b724336a2cae";
      };
    }

    {
      name = "p-limit-1.3.0.tgz";
      path = fetchurl {
        name = "p-limit-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/p-limit/-/p-limit-1.3.0.tgz";
        sha1 = "b86bd5f0c25690911c7590fcbfc2010d54b3ccb8";
      };
    }

    {
      name = "p-locate-2.0.0.tgz";
      path = fetchurl {
        name = "p-locate-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/p-locate/-/p-locate-2.0.0.tgz";
        sha1 = "20a0103b222a70c8fd39cc2e580680f3dde5ec43";
      };
    }

    {
      name = "p-map-1.2.0.tgz";
      path = fetchurl {
        name = "p-map-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/p-map/-/p-map-1.2.0.tgz";
        sha1 = "e4e94f311eabbc8633a1e79908165fca26241b6b";
      };
    }

    {
      name = "p-try-1.0.0.tgz";
      path = fetchurl {
        name = "p-try-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/p-try/-/p-try-1.0.0.tgz";
        sha1 = "cbc79cdbaf8fd4228e13f621f2b1a237c1b207b3";
      };
    }

    {
      name = "package-json-4.0.1.tgz";
      path = fetchurl {
        name = "package-json-4.0.1.tgz";
        url  = "https://registry.yarnpkg.com/package-json/-/package-json-4.0.1.tgz";
        sha1 = "8869a0401253661c4c4ca3da6c2121ed555f5eed";
      };
    }

    {
      name = "packet-reader-0.3.1.tgz";
      path = fetchurl {
        name = "packet-reader-0.3.1.tgz";
        url  = "https://registry.yarnpkg.com/packet-reader/-/packet-reader-0.3.1.tgz";
        sha1 = "cd62e60af8d7fea8a705ec4ff990871c46871f27";
      };
    }

    {
      name = "pako-1.0.6.tgz";
      path = fetchurl {
        name = "pako-1.0.6.tgz";
        url  = "https://registry.yarnpkg.com/pako/-/pako-1.0.6.tgz";
        sha1 = "0101211baa70c4bca4a0f63f2206e97b7dfaf258";
      };
    }

    {
      name = "parallel-transform-1.1.0.tgz";
      path = fetchurl {
        name = "parallel-transform-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/parallel-transform/-/parallel-transform-1.1.0.tgz";
        sha1 = "d410f065b05da23081fcd10f28854c29bda33b06";
      };
    }

    {
      name = "param-case-2.1.1.tgz";
      path = fetchurl {
        name = "param-case-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/param-case/-/param-case-2.1.1.tgz";
        sha1 = "df94fd8cf6531ecf75e6bef9a0858fbc72be2247";
      };
    }

    {
      name = "parse-asn1-5.1.1.tgz";
      path = fetchurl {
        name = "parse-asn1-5.1.1.tgz";
        url  = "https://registry.yarnpkg.com/parse-asn1/-/parse-asn1-5.1.1.tgz";
        sha1 = "f6bf293818332bd0dab54efb16087724745e6ca8";
      };
    }

    {
      name = "parse-entities-1.1.2.tgz";
      path = fetchurl {
        name = "parse-entities-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/parse-entities/-/parse-entities-1.1.2.tgz";
        sha1 = "9eaf719b29dc3bd62246b4332009072e01527777";
      };
    }

    {
      name = "parse-github-repo-url-1.4.1.tgz";
      path = fetchurl {
        name = "parse-github-repo-url-1.4.1.tgz";
        url  = "https://registry.yarnpkg.com/parse-github-repo-url/-/parse-github-repo-url-1.4.1.tgz";
        sha1 = "9e7d8bb252a6cb6ba42595060b7bf6df3dbc1f50";
      };
    }

    {
      name = "parse-glob-3.0.4.tgz";
      path = fetchurl {
        name = "parse-glob-3.0.4.tgz";
        url  = "https://registry.yarnpkg.com/parse-glob/-/parse-glob-3.0.4.tgz";
        sha1 = "b2c376cfb11f35513badd173ef0bb6e3a388391c";
      };
    }

    {
      name = "parse-int-x-2.0.0.tgz";
      path = fetchurl {
        name = "parse-int-x-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/parse-int-x/-/parse-int-x-2.0.0.tgz";
        sha1 = "9f979d4115930df2f4706a41810b9c712405552f";
      };
    }

    {
      name = "parse-json-2.2.0.tgz";
      path = fetchurl {
        name = "parse-json-2.2.0.tgz";
        url  = "https://registry.yarnpkg.com/parse-json/-/parse-json-2.2.0.tgz";
        sha1 = "f480f40434ef80741f8469099f8dea18f55a4dc9";
      };
    }

    {
      name = "parse-json-3.0.0.tgz";
      path = fetchurl {
        name = "parse-json-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/parse-json/-/parse-json-3.0.0.tgz";
        sha1 = "fa6f47b18e23826ead32f263e744d0e1e847fb13";
      };
    }

    {
      name = "parse-json-4.0.0.tgz";
      path = fetchurl {
        name = "parse-json-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/parse-json/-/parse-json-4.0.0.tgz";
        sha1 = "be35f5425be1f7f6c747184f98a788cb99477ee0";
      };
    }

    {
      name = "parse-passwd-1.0.0.tgz";
      path = fetchurl {
        name = "parse-passwd-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/parse-passwd/-/parse-passwd-1.0.0.tgz";
        sha1 = "6d5b934a456993b23d37f40a382d6f1666a8e5c6";
      };
    }

    {
      name = "parse5-4.0.0.tgz";
      path = fetchurl {
        name = "parse5-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/parse5/-/parse5-4.0.0.tgz";
        sha1 = "6d78656e3da8d78b4ec0b906f7c08ef1dfe3f608";
      };
    }

    {
      name = "parse5-1.5.1.tgz";
      path = fetchurl {
        name = "parse5-1.5.1.tgz";
        url  = "https://registry.yarnpkg.com/parse5/-/parse5-1.5.1.tgz";
        sha1 = "9b7f3b0de32be78dc2401b17573ccaf0f6f59d94";
      };
    }

    {
      name = "parse5-2.2.3.tgz";
      path = fetchurl {
        name = "parse5-2.2.3.tgz";
        url  = "https://registry.yarnpkg.com/parse5/-/parse5-2.2.3.tgz";
        sha1 = "0c4fc41c1000c5e6b93d48b03f8083837834e9f6";
      };
    }

    {
      name = "parse5-3.0.3.tgz";
      path = fetchurl {
        name = "parse5-3.0.3.tgz";
        url  = "https://registry.yarnpkg.com/parse5/-/parse5-3.0.3.tgz";
        sha1 = "042f792ffdd36851551cf4e9e066b3874ab45b5c";
      };
    }

    {
      name = "parseurl-1.3.2.tgz";
      path = fetchurl {
        name = "parseurl-1.3.2.tgz";
        url  = "https://registry.yarnpkg.com/parseurl/-/parseurl-1.3.2.tgz";
        sha1 = "fc289d4ed8993119460c156253262cdc8de65bf3";
      };
    }

    {
      name = "pascalcase-0.1.1.tgz";
      path = fetchurl {
        name = "pascalcase-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/pascalcase/-/pascalcase-0.1.1.tgz";
        sha1 = "b363e55e8006ca6fe21784d2db22bd15d7917f14";
      };
    }

    {
      name = "passport-anonymous-1.0.1.tgz";
      path = fetchurl {
        name = "passport-anonymous-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/passport-anonymous/-/passport-anonymous-1.0.1.tgz";
        sha1 = "241e37274ec44dfb7f6cad234b41c438386bc117";
      };
    }

    {
      name = "passport-http-bearer-1.0.1.tgz";
      path = fetchurl {
        name = "passport-http-bearer-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/passport-http-bearer/-/passport-http-bearer-1.0.1.tgz";
        sha1 = "147469ea3669e2a84c6167ef99dbb77e1f0098a8";
      };
    }

    {
      name = "passport-local-1.0.0.tgz";
      path = fetchurl {
        name = "passport-local-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/passport-local/-/passport-local-1.0.0.tgz";
        sha1 = "1fe63268c92e75606626437e3b906662c15ba6ee";
      };
    }

    {
      name = "passport-strategy-1.0.0.tgz";
      path = fetchurl {
        name = "passport-strategy-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/passport-strategy/-/passport-strategy-1.0.0.tgz";
        sha1 = "b5539aa8fc225a3d1ad179476ddf236b440f52e4";
      };
    }

    {
      name = "passport-0.3.2.tgz";
      path = fetchurl {
        name = "passport-0.3.2.tgz";
        url  = "https://registry.yarnpkg.com/passport/-/passport-0.3.2.tgz";
        sha1 = "9dd009f915e8fe095b0124a01b8f82da07510102";
      };
    }

    {
      name = "path-browserify-0.0.0.tgz";
      path = fetchurl {
        name = "path-browserify-0.0.0.tgz";
        url  = "https://registry.yarnpkg.com/path-browserify/-/path-browserify-0.0.0.tgz";
        sha1 = "a0b870729aae214005b7d5032ec2cbbb0fb4451a";
      };
    }

    {
      name = "path-dirname-1.0.2.tgz";
      path = fetchurl {
        name = "path-dirname-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/path-dirname/-/path-dirname-1.0.2.tgz";
        sha1 = "cc33d24d525e099a5388c0336c6e32b9160609e0";
      };
    }

    {
      name = "path-exists-2.1.0.tgz";
      path = fetchurl {
        name = "path-exists-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/path-exists/-/path-exists-2.1.0.tgz";
        sha1 = "0feb6c64f0fc518d9a754dd5efb62c7022761f4b";
      };
    }

    {
      name = "path-exists-3.0.0.tgz";
      path = fetchurl {
        name = "path-exists-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/path-exists/-/path-exists-3.0.0.tgz";
        sha1 = "ce0ebeaa5f78cb18925ea7d810d7b59b010fd515";
      };
    }

    {
      name = "path-is-absolute-1.0.1.tgz";
      path = fetchurl {
        name = "path-is-absolute-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/path-is-absolute/-/path-is-absolute-1.0.1.tgz";
        sha1 = "174b9268735534ffbc7ace6bf53a5a9e1b5c5f5f";
      };
    }

    {
      name = "path-is-inside-1.0.2.tgz";
      path = fetchurl {
        name = "path-is-inside-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/path-is-inside/-/path-is-inside-1.0.2.tgz";
        sha1 = "365417dede44430d1c11af61027facf074bdfc53";
      };
    }

    {
      name = "path-key-2.0.1.tgz";
      path = fetchurl {
        name = "path-key-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/path-key/-/path-key-2.0.1.tgz";
        sha1 = "411cadb574c5a140d3a4b1910d40d80cc9f40b40";
      };
    }

    {
      name = "path-parse-1.0.5.tgz";
      path = fetchurl {
        name = "path-parse-1.0.5.tgz";
        url  = "https://registry.yarnpkg.com/path-parse/-/path-parse-1.0.5.tgz";
        sha1 = "3c1adf871ea9cd6c9431b6ea2bd74a0ff055c4c1";
      };
    }

    {
      name = "path-to-regexp-0.1.7.tgz";
      path = fetchurl {
        name = "path-to-regexp-0.1.7.tgz";
        url  = "https://registry.yarnpkg.com/path-to-regexp/-/path-to-regexp-0.1.7.tgz";
        sha1 = "df604178005f522f15eb4490e7247a1bfaa67f8c";
      };
    }

    {
      name = "path-to-regexp-1.7.0.tgz";
      path = fetchurl {
        name = "path-to-regexp-1.7.0.tgz";
        url  = "https://registry.yarnpkg.com/path-to-regexp/-/path-to-regexp-1.7.0.tgz";
        sha1 = "59fde0f435badacba103a84e9d3bc64e96b9937d";
      };
    }

    {
      name = "path-type-1.1.0.tgz";
      path = fetchurl {
        name = "path-type-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/path-type/-/path-type-1.1.0.tgz";
        sha1 = "59c44f7ee491da704da415da5a4070ba4f8fe441";
      };
    }

    {
      name = "path-type-2.0.0.tgz";
      path = fetchurl {
        name = "path-type-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/path-type/-/path-type-2.0.0.tgz";
        sha1 = "f012ccb8415b7096fc2daa1054c3d72389594c73";
      };
    }

    {
      name = "path-type-3.0.0.tgz";
      path = fetchurl {
        name = "path-type-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/path-type/-/path-type-3.0.0.tgz";
        sha1 = "cef31dc8e0a1a3bb0d105c0cd97cf3bf47f4e36f";
      };
    }

    {
      name = "pause-0.0.1.tgz";
      path = fetchurl {
        name = "pause-0.0.1.tgz";
        url  = "https://registry.yarnpkg.com/pause/-/pause-0.0.1.tgz";
        sha1 = "1d408b3fdb76923b9543d96fb4c9dfd535d9cb5d";
      };
    }

    {
      name = "pbkdf2-3.0.16.tgz";
      path = fetchurl {
        name = "pbkdf2-3.0.16.tgz";
        url  = "https://registry.yarnpkg.com/pbkdf2/-/pbkdf2-3.0.16.tgz";
        sha1 = "7404208ec6b01b62d85bf83853a8064f8d9c2a5c";
      };
    }

    {
      name = "pend-1.2.0.tgz";
      path = fetchurl {
        name = "pend-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/pend/-/pend-1.2.0.tgz";
        sha1 = "7a57eb550a6783f9115331fcf4663d5c8e007a50";
      };
    }

    {
      name = "performance-now-0.2.0.tgz";
      path = fetchurl {
        name = "performance-now-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/performance-now/-/performance-now-0.2.0.tgz";
        sha1 = "33ef30c5c77d4ea21c5a53869d91b56d8f2555e5";
      };
    }

    {
      name = "performance-now-2.1.0.tgz";
      path = fetchurl {
        name = "performance-now-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/performance-now/-/performance-now-2.1.0.tgz";
        sha1 = "6309f4e0e5fa913ec1c69307ae364b4b377c9e7b";
      };
    }

    {
      name = "pg-connection-string-0.1.3.tgz";
      path = fetchurl {
        name = "pg-connection-string-0.1.3.tgz";
        url  = "https://registry.yarnpkg.com/pg-connection-string/-/pg-connection-string-0.1.3.tgz";
        sha1 = "da1847b20940e42ee1492beaf65d49d91b245df7";
      };
    }

    {
      name = "pg-pool-2.0.3.tgz";
      path = fetchurl {
        name = "pg-pool-2.0.3.tgz";
        url  = "https://registry.yarnpkg.com/pg-pool/-/pg-pool-2.0.3.tgz";
        sha1 = "c022032c8949f312a4f91fb6409ce04076be3257";
      };
    }

    {
      name = "pg-types-1.12.1.tgz";
      path = fetchurl {
        name = "pg-types-1.12.1.tgz";
        url  = "https://registry.yarnpkg.com/pg-types/-/pg-types-1.12.1.tgz";
        sha1 = "d64087e3903b58ffaad279e7595c52208a14c3d2";
      };
    }

    {
      name = "pg-7.4.3.tgz";
      path = fetchurl {
        name = "pg-7.4.3.tgz";
        url  = "https://registry.yarnpkg.com/pg/-/pg-7.4.3.tgz";
        sha1 = "f7b6f93f5340ecc2596afbb94a13e3d6b609834b";
      };
    }

    {
      name = "pgpass-1.0.2.tgz";
      path = fetchurl {
        name = "pgpass-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/pgpass/-/pgpass-1.0.2.tgz";
        sha1 = "2a7bb41b6065b67907e91da1b07c1847c877b306";
      };
    }

    {
      name = "pify-2.3.0.tgz";
      path = fetchurl {
        name = "pify-2.3.0.tgz";
        url  = "https://registry.yarnpkg.com/pify/-/pify-2.3.0.tgz";
        sha1 = "ed141a6ac043a849ea588498e7dca8b15330e90c";
      };
    }

    {
      name = "pify-3.0.0.tgz";
      path = fetchurl {
        name = "pify-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/pify/-/pify-3.0.0.tgz";
        sha1 = "e5a4acd2c101fdf3d9a4d07f0dbc4db49dd28176";
      };
    }

    {
      name = "pinkie-promise-1.0.0.tgz";
      path = fetchurl {
        name = "pinkie-promise-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/pinkie-promise/-/pinkie-promise-1.0.0.tgz";
        sha1 = "d1da67f5482563bb7cf57f286ae2822ecfbf3670";
      };
    }

    {
      name = "pinkie-promise-2.0.1.tgz";
      path = fetchurl {
        name = "pinkie-promise-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/pinkie-promise/-/pinkie-promise-2.0.1.tgz";
        sha1 = "2135d6dfa7a358c069ac9b178776288228450ffa";
      };
    }

    {
      name = "pinkie-1.0.0.tgz";
      path = fetchurl {
        name = "pinkie-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/pinkie/-/pinkie-1.0.0.tgz";
        sha1 = "5a47f28ba1015d0201bda7bf0f358e47bec8c7e4";
      };
    }

    {
      name = "pinkie-2.0.4.tgz";
      path = fetchurl {
        name = "pinkie-2.0.4.tgz";
        url  = "https://registry.yarnpkg.com/pinkie/-/pinkie-2.0.4.tgz";
        sha1 = "72556b80cfa0d48a974e80e77248e80ed4f7f870";
      };
    }

    {
      name = "pkg-conf-2.1.0.tgz";
      path = fetchurl {
        name = "pkg-conf-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/pkg-conf/-/pkg-conf-2.1.0.tgz";
        sha1 = "2126514ca6f2abfebd168596df18ba57867f0058";
      };
    }

    {
      name = "pkg-config-1.1.1.tgz";
      path = fetchurl {
        name = "pkg-config-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/pkg-config/-/pkg-config-1.1.1.tgz";
        sha1 = "557ef22d73da3c8837107766c52eadabde298fe4";
      };
    }

    {
      name = "pkg-dir-1.0.0.tgz";
      path = fetchurl {
        name = "pkg-dir-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/pkg-dir/-/pkg-dir-1.0.0.tgz";
        sha1 = "7a4b508a8d5bb2d629d447056ff4e9c9314cf3d4";
      };
    }

    {
      name = "pkg-dir-2.0.0.tgz";
      path = fetchurl {
        name = "pkg-dir-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/pkg-dir/-/pkg-dir-2.0.0.tgz";
        sha1 = "f6d5d1109e19d63edf428e0bd57e12777615334b";
      };
    }

    {
      name = "pkg-up-1.0.0.tgz";
      path = fetchurl {
        name = "pkg-up-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/pkg-up/-/pkg-up-1.0.0.tgz";
        sha1 = "3e08fb461525c4421624a33b9f7e6d0af5b05a26";
      };
    }

    {
      name = "pkginfo-0.3.1.tgz";
      path = fetchurl {
        name = "pkginfo-0.3.1.tgz";
        url  = "https://registry.yarnpkg.com/pkginfo/-/pkginfo-0.3.1.tgz";
        sha1 = "5b29f6a81f70717142e09e765bbeab97b4f81e21";
      };
    }

    {
      name = "platform-1.3.5.tgz";
      path = fetchurl {
        name = "platform-1.3.5.tgz";
        url  = "https://registry.yarnpkg.com/platform/-/platform-1.3.5.tgz";
        sha1 = "fb6958c696e07e2918d2eeda0f0bc9448d733444";
      };
    }

    {
      name = "pluralize-1.2.1.tgz";
      path = fetchurl {
        name = "pluralize-1.2.1.tgz";
        url  = "https://registry.yarnpkg.com/pluralize/-/pluralize-1.2.1.tgz";
        sha1 = "d1a21483fd22bb41e58a12fa3421823140897c45";
      };
    }

    {
      name = "pluralize-7.0.0.tgz";
      path = fetchurl {
        name = "pluralize-7.0.0.tgz";
        url  = "https://registry.yarnpkg.com/pluralize/-/pluralize-7.0.0.tgz";
        sha1 = "298b89df8b93b0221dbf421ad2b1b1ea23fc6777";
      };
    }

    {
      name = "pn-1.1.0.tgz";
      path = fetchurl {
        name = "pn-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/pn/-/pn-1.1.0.tgz";
        sha1 = "e2f4cef0e219f463c179ab37463e4e1ecdccbafb";
      };
    }

    {
      name = "portfinder-1.0.13.tgz";
      path = fetchurl {
        name = "portfinder-1.0.13.tgz";
        url  = "https://registry.yarnpkg.com/portfinder/-/portfinder-1.0.13.tgz";
        sha1 = "bb32ecd87c27104ae6ee44b5a3ccbf0ebb1aede9";
      };
    }

    {
      name = "posix-character-classes-0.1.1.tgz";
      path = fetchurl {
        name = "posix-character-classes-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/posix-character-classes/-/posix-character-classes-0.1.1.tgz";
        sha1 = "01eac0fe3b5af71a2a6c02feabb8c1fef7e00eab";
      };
    }

    {
      name = "postcss-calc-5.3.1.tgz";
      path = fetchurl {
        name = "postcss-calc-5.3.1.tgz";
        url  = "https://registry.yarnpkg.com/postcss-calc/-/postcss-calc-5.3.1.tgz";
        sha1 = "77bae7ca928ad85716e2fda42f261bf7c1d65b5e";
      };
    }

    {
      name = "postcss-colormin-2.2.2.tgz";
      path = fetchurl {
        name = "postcss-colormin-2.2.2.tgz";
        url  = "https://registry.yarnpkg.com/postcss-colormin/-/postcss-colormin-2.2.2.tgz";
        sha1 = "6631417d5f0e909a3d7ec26b24c8a8d1e4f96e4b";
      };
    }

    {
      name = "postcss-convert-values-2.6.1.tgz";
      path = fetchurl {
        name = "postcss-convert-values-2.6.1.tgz";
        url  = "https://registry.yarnpkg.com/postcss-convert-values/-/postcss-convert-values-2.6.1.tgz";
        sha1 = "bbd8593c5c1fd2e3d1c322bb925dcae8dae4d62d";
      };
    }

    {
      name = "postcss-discard-comments-2.0.4.tgz";
      path = fetchurl {
        name = "postcss-discard-comments-2.0.4.tgz";
        url  = "https://registry.yarnpkg.com/postcss-discard-comments/-/postcss-discard-comments-2.0.4.tgz";
        sha1 = "befe89fafd5b3dace5ccce51b76b81514be00e3d";
      };
    }

    {
      name = "postcss-discard-duplicates-2.1.0.tgz";
      path = fetchurl {
        name = "postcss-discard-duplicates-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/postcss-discard-duplicates/-/postcss-discard-duplicates-2.1.0.tgz";
        sha1 = "b9abf27b88ac188158a5eb12abcae20263b91932";
      };
    }

    {
      name = "postcss-discard-empty-2.1.0.tgz";
      path = fetchurl {
        name = "postcss-discard-empty-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/postcss-discard-empty/-/postcss-discard-empty-2.1.0.tgz";
        sha1 = "d2b4bd9d5ced5ebd8dcade7640c7d7cd7f4f92b5";
      };
    }

    {
      name = "postcss-discard-overridden-0.1.1.tgz";
      path = fetchurl {
        name = "postcss-discard-overridden-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/postcss-discard-overridden/-/postcss-discard-overridden-0.1.1.tgz";
        sha1 = "8b1eaf554f686fb288cd874c55667b0aa3668d58";
      };
    }

    {
      name = "postcss-discard-unused-2.2.3.tgz";
      path = fetchurl {
        name = "postcss-discard-unused-2.2.3.tgz";
        url  = "https://registry.yarnpkg.com/postcss-discard-unused/-/postcss-discard-unused-2.2.3.tgz";
        sha1 = "bce30b2cc591ffc634322b5fb3464b6d934f4433";
      };
    }

    {
      name = "postcss-filter-plugins-2.0.3.tgz";
      path = fetchurl {
        name = "postcss-filter-plugins-2.0.3.tgz";
        url  = "https://registry.yarnpkg.com/postcss-filter-plugins/-/postcss-filter-plugins-2.0.3.tgz";
        sha1 = "82245fdf82337041645e477114d8e593aa18b8ec";
      };
    }

    {
      name = "postcss-html-0.12.0.tgz";
      path = fetchurl {
        name = "postcss-html-0.12.0.tgz";
        url  = "https://registry.yarnpkg.com/postcss-html/-/postcss-html-0.12.0.tgz";
        sha1 = "39b6adb4005dfc5464df7999c0f81c95bced7e50";
      };
    }

    {
      name = "postcss-less-1.1.5.tgz";
      path = fetchurl {
        name = "postcss-less-1.1.5.tgz";
        url  = "https://registry.yarnpkg.com/postcss-less/-/postcss-less-1.1.5.tgz";
        sha1 = "a6f0ce180cf3797eeee1d4adc0e9e6d6db665609";
      };
    }

    {
      name = "postcss-media-query-parser-0.2.3.tgz";
      path = fetchurl {
        name = "postcss-media-query-parser-0.2.3.tgz";
        url  = "https://registry.yarnpkg.com/postcss-media-query-parser/-/postcss-media-query-parser-0.2.3.tgz";
        sha1 = "27b39c6f4d94f81b1a73b8f76351c609e5cef244";
      };
    }

    {
      name = "postcss-merge-idents-2.1.7.tgz";
      path = fetchurl {
        name = "postcss-merge-idents-2.1.7.tgz";
        url  = "https://registry.yarnpkg.com/postcss-merge-idents/-/postcss-merge-idents-2.1.7.tgz";
        sha1 = "4c5530313c08e1d5b3bbf3d2bbc747e278eea270";
      };
    }

    {
      name = "postcss-merge-longhand-2.0.2.tgz";
      path = fetchurl {
        name = "postcss-merge-longhand-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/postcss-merge-longhand/-/postcss-merge-longhand-2.0.2.tgz";
        sha1 = "23d90cd127b0a77994915332739034a1a4f3d658";
      };
    }

    {
      name = "postcss-merge-rules-2.1.2.tgz";
      path = fetchurl {
        name = "postcss-merge-rules-2.1.2.tgz";
        url  = "https://registry.yarnpkg.com/postcss-merge-rules/-/postcss-merge-rules-2.1.2.tgz";
        sha1 = "d1df5dfaa7b1acc3be553f0e9e10e87c61b5f721";
      };
    }

    {
      name = "postcss-message-helpers-2.0.0.tgz";
      path = fetchurl {
        name = "postcss-message-helpers-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/postcss-message-helpers/-/postcss-message-helpers-2.0.0.tgz";
        sha1 = "a4f2f4fab6e4fe002f0aed000478cdf52f9ba60e";
      };
    }

    {
      name = "postcss-minify-font-values-1.0.5.tgz";
      path = fetchurl {
        name = "postcss-minify-font-values-1.0.5.tgz";
        url  = "https://registry.yarnpkg.com/postcss-minify-font-values/-/postcss-minify-font-values-1.0.5.tgz";
        sha1 = "4b58edb56641eba7c8474ab3526cafd7bbdecb69";
      };
    }

    {
      name = "postcss-minify-gradients-1.0.5.tgz";
      path = fetchurl {
        name = "postcss-minify-gradients-1.0.5.tgz";
        url  = "https://registry.yarnpkg.com/postcss-minify-gradients/-/postcss-minify-gradients-1.0.5.tgz";
        sha1 = "5dbda11373703f83cfb4a3ea3881d8d75ff5e6e1";
      };
    }

    {
      name = "postcss-minify-params-1.2.2.tgz";
      path = fetchurl {
        name = "postcss-minify-params-1.2.2.tgz";
        url  = "https://registry.yarnpkg.com/postcss-minify-params/-/postcss-minify-params-1.2.2.tgz";
        sha1 = "ad2ce071373b943b3d930a3fa59a358c28d6f1f3";
      };
    }

    {
      name = "postcss-minify-selectors-2.1.1.tgz";
      path = fetchurl {
        name = "postcss-minify-selectors-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/postcss-minify-selectors/-/postcss-minify-selectors-2.1.1.tgz";
        sha1 = "b2c6a98c0072cf91b932d1a496508114311735bf";
      };
    }

    {
      name = "postcss-modules-extract-imports-1.2.0.tgz";
      path = fetchurl {
        name = "postcss-modules-extract-imports-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/postcss-modules-extract-imports/-/postcss-modules-extract-imports-1.2.0.tgz";
        sha1 = "66140ecece38ef06bf0d3e355d69bf59d141ea85";
      };
    }

    {
      name = "postcss-modules-local-by-default-1.2.0.tgz";
      path = fetchurl {
        name = "postcss-modules-local-by-default-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/postcss-modules-local-by-default/-/postcss-modules-local-by-default-1.2.0.tgz";
        sha1 = "f7d80c398c5a393fa7964466bd19500a7d61c069";
      };
    }

    {
      name = "postcss-modules-scope-1.1.0.tgz";
      path = fetchurl {
        name = "postcss-modules-scope-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/postcss-modules-scope/-/postcss-modules-scope-1.1.0.tgz";
        sha1 = "d6ea64994c79f97b62a72b426fbe6056a194bb90";
      };
    }

    {
      name = "postcss-modules-values-1.3.0.tgz";
      path = fetchurl {
        name = "postcss-modules-values-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/postcss-modules-values/-/postcss-modules-values-1.3.0.tgz";
        sha1 = "ecffa9d7e192518389f42ad0e83f72aec456ea20";
      };
    }

    {
      name = "postcss-normalize-charset-1.1.1.tgz";
      path = fetchurl {
        name = "postcss-normalize-charset-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/postcss-normalize-charset/-/postcss-normalize-charset-1.1.1.tgz";
        sha1 = "ef9ee71212d7fe759c78ed162f61ed62b5cb93f1";
      };
    }

    {
      name = "postcss-normalize-url-3.0.8.tgz";
      path = fetchurl {
        name = "postcss-normalize-url-3.0.8.tgz";
        url  = "https://registry.yarnpkg.com/postcss-normalize-url/-/postcss-normalize-url-3.0.8.tgz";
        sha1 = "108f74b3f2fcdaf891a2ffa3ea4592279fc78222";
      };
    }

    {
      name = "postcss-ordered-values-2.2.3.tgz";
      path = fetchurl {
        name = "postcss-ordered-values-2.2.3.tgz";
        url  = "https://registry.yarnpkg.com/postcss-ordered-values/-/postcss-ordered-values-2.2.3.tgz";
        sha1 = "eec6c2a67b6c412a8db2042e77fe8da43f95c11d";
      };
    }

    {
      name = "postcss-reduce-idents-2.4.0.tgz";
      path = fetchurl {
        name = "postcss-reduce-idents-2.4.0.tgz";
        url  = "https://registry.yarnpkg.com/postcss-reduce-idents/-/postcss-reduce-idents-2.4.0.tgz";
        sha1 = "c2c6d20cc958284f6abfbe63f7609bf409059ad3";
      };
    }

    {
      name = "postcss-reduce-initial-1.0.1.tgz";
      path = fetchurl {
        name = "postcss-reduce-initial-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/postcss-reduce-initial/-/postcss-reduce-initial-1.0.1.tgz";
        sha1 = "68f80695f045d08263a879ad240df8dd64f644ea";
      };
    }

    {
      name = "postcss-reduce-transforms-1.0.4.tgz";
      path = fetchurl {
        name = "postcss-reduce-transforms-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/postcss-reduce-transforms/-/postcss-reduce-transforms-1.0.4.tgz";
        sha1 = "ff76f4d8212437b31c298a42d2e1444025771ae1";
      };
    }

    {
      name = "postcss-reporter-5.0.0.tgz";
      path = fetchurl {
        name = "postcss-reporter-5.0.0.tgz";
        url  = "https://registry.yarnpkg.com/postcss-reporter/-/postcss-reporter-5.0.0.tgz";
        sha1 = "a14177fd1342829d291653f2786efd67110332c3";
      };
    }

    {
      name = "postcss-resolve-nested-selector-0.1.1.tgz";
      path = fetchurl {
        name = "postcss-resolve-nested-selector-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/postcss-resolve-nested-selector/-/postcss-resolve-nested-selector-0.1.1.tgz";
        sha1 = "29ccbc7c37dedfac304e9fff0bf1596b3f6a0e4e";
      };
    }

    {
      name = "postcss-safe-parser-3.0.1.tgz";
      path = fetchurl {
        name = "postcss-safe-parser-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/postcss-safe-parser/-/postcss-safe-parser-3.0.1.tgz";
        sha1 = "b753eff6c7c0aea5e8375fbe4cde8bf9063ff142";
      };
    }

    {
      name = "postcss-sass-0.2.0.tgz";
      path = fetchurl {
        name = "postcss-sass-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/postcss-sass/-/postcss-sass-0.2.0.tgz";
        sha1 = "e55516441e9526ba4b380a730d3a02e9eaa78c7a";
      };
    }

    {
      name = "postcss-scss-1.0.6.tgz";
      path = fetchurl {
        name = "postcss-scss-1.0.6.tgz";
        url  = "https://registry.yarnpkg.com/postcss-scss/-/postcss-scss-1.0.6.tgz";
        sha1 = "ab903f3bb20161bc177896462293a53d4bff5f7a";
      };
    }

    {
      name = "postcss-selector-parser-2.2.3.tgz";
      path = fetchurl {
        name = "postcss-selector-parser-2.2.3.tgz";
        url  = "https://registry.yarnpkg.com/postcss-selector-parser/-/postcss-selector-parser-2.2.3.tgz";
        sha1 = "f9437788606c3c9acee16ffe8d8b16297f27bb90";
      };
    }

    {
      name = "postcss-selector-parser-3.1.1.tgz";
      path = fetchurl {
        name = "postcss-selector-parser-3.1.1.tgz";
        url  = "https://registry.yarnpkg.com/postcss-selector-parser/-/postcss-selector-parser-3.1.1.tgz";
        sha1 = "4f875f4afb0c96573d5cf4d74011aee250a7e865";
      };
    }

    {
      name = "postcss-sorting-3.1.0.tgz";
      path = fetchurl {
        name = "postcss-sorting-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/postcss-sorting/-/postcss-sorting-3.1.0.tgz";
        sha1 = "af7c90ee73ad12569a57664eaf06735c2e25bec0";
      };
    }

    {
      name = "postcss-svgo-2.1.6.tgz";
      path = fetchurl {
        name = "postcss-svgo-2.1.6.tgz";
        url  = "https://registry.yarnpkg.com/postcss-svgo/-/postcss-svgo-2.1.6.tgz";
        sha1 = "b6df18aa613b666e133f08adb5219c2684ac108d";
      };
    }

    {
      name = "postcss-unique-selectors-2.0.2.tgz";
      path = fetchurl {
        name = "postcss-unique-selectors-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/postcss-unique-selectors/-/postcss-unique-selectors-2.0.2.tgz";
        sha1 = "981d57d29ddcb33e7b1dfe1fd43b8649f933ca1d";
      };
    }

    {
      name = "postcss-value-parser-3.3.0.tgz";
      path = fetchurl {
        name = "postcss-value-parser-3.3.0.tgz";
        url  = "https://registry.yarnpkg.com/postcss-value-parser/-/postcss-value-parser-3.3.0.tgz";
        sha1 = "87f38f9f18f774a4ab4c8a232f5c5ce8872a9d15";
      };
    }

    {
      name = "postcss-zindex-2.2.0.tgz";
      path = fetchurl {
        name = "postcss-zindex-2.2.0.tgz";
        url  = "https://registry.yarnpkg.com/postcss-zindex/-/postcss-zindex-2.2.0.tgz";
        sha1 = "d2109ddc055b91af67fc4cb3b025946639d2af22";
      };
    }

    {
      name = "postcss-5.2.18.tgz";
      path = fetchurl {
        name = "postcss-5.2.18.tgz";
        url  = "https://registry.yarnpkg.com/postcss/-/postcss-5.2.18.tgz";
        sha1 = "badfa1497d46244f6390f58b319830d9107853c5";
      };
    }

    {
      name = "postcss-6.0.23.tgz";
      path = fetchurl {
        name = "postcss-6.0.23.tgz";
        url  = "https://registry.yarnpkg.com/postcss/-/postcss-6.0.23.tgz";
        sha1 = "61c82cc328ac60e677645f979054eb98bc0e3324";
      };
    }

    {
      name = "postgres-array-1.0.2.tgz";
      path = fetchurl {
        name = "postgres-array-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/postgres-array/-/postgres-array-1.0.2.tgz";
        sha1 = "8e0b32eb03bf77a5c0a7851e0441c169a256a238";
      };
    }

    {
      name = "postgres-bytea-1.0.0.tgz";
      path = fetchurl {
        name = "postgres-bytea-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/postgres-bytea/-/postgres-bytea-1.0.0.tgz";
        sha1 = "027b533c0aa890e26d172d47cf9ccecc521acd35";
      };
    }

    {
      name = "postgres-date-1.0.3.tgz";
      path = fetchurl {
        name = "postgres-date-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/postgres-date/-/postgres-date-1.0.3.tgz";
        sha1 = "e2d89702efdb258ff9d9cee0fe91bd06975257a8";
      };
    }

    {
      name = "postgres-interval-1.1.1.tgz";
      path = fetchurl {
        name = "postgres-interval-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/postgres-interval/-/postgres-interval-1.1.1.tgz";
        sha1 = "acdb0f897b4b1c6e496d9d4e0a853e1c428f06f0";
      };
    }

    {
      name = "pouchdb-adapter-leveldb-core-6.4.3.tgz";
      path = fetchurl {
        name = "pouchdb-adapter-leveldb-core-6.4.3.tgz";
        url  = "https://registry.yarnpkg.com/pouchdb-adapter-leveldb-core/-/pouchdb-adapter-leveldb-core-6.4.3.tgz";
        sha1 = "0b623fc12e63acbf5606508ba2008e501803076a";
      };
    }

    {
      name = "pouchdb-adapter-memory-6.4.3.tgz";
      path = fetchurl {
        name = "pouchdb-adapter-memory-6.4.3.tgz";
        url  = "https://registry.yarnpkg.com/pouchdb-adapter-memory/-/pouchdb-adapter-memory-6.4.3.tgz";
        sha1 = "06edb687be9d063b27e9b58ca30ea1a08a9b94f4";
      };
    }

    {
      name = "pouchdb-adapter-utils-6.4.3.tgz";
      path = fetchurl {
        name = "pouchdb-adapter-utils-6.4.3.tgz";
        url  = "https://registry.yarnpkg.com/pouchdb-adapter-utils/-/pouchdb-adapter-utils-6.4.3.tgz";
        sha1 = "384bb1bcd37dc7d473016eb450cec53d665bcae4";
      };
    }

    {
      name = "pouchdb-binary-utils-6.4.3.tgz";
      path = fetchurl {
        name = "pouchdb-binary-utils-6.4.3.tgz";
        url  = "https://registry.yarnpkg.com/pouchdb-binary-utils/-/pouchdb-binary-utils-6.4.3.tgz";
        sha1 = "ba6d9b9d289a359d47b53c1ec017fd9715a777a9";
      };
    }

    {
      name = "pouchdb-collections-6.4.3.tgz";
      path = fetchurl {
        name = "pouchdb-collections-6.4.3.tgz";
        url  = "https://registry.yarnpkg.com/pouchdb-collections/-/pouchdb-collections-6.4.3.tgz";
        sha1 = "2b70ca3143134c361dba6e466518b4f4d8e92ff4";
      };
    }

    {
      name = "pouchdb-errors-6.4.3.tgz";
      path = fetchurl {
        name = "pouchdb-errors-6.4.3.tgz";
        url  = "https://registry.yarnpkg.com/pouchdb-errors/-/pouchdb-errors-6.4.3.tgz";
        sha1 = "9fa4a13f64ee50c8d593e3235b18b1458977f8d1";
      };
    }

    {
      name = "pouchdb-json-6.4.3.tgz";
      path = fetchurl {
        name = "pouchdb-json-6.4.3.tgz";
        url  = "https://registry.yarnpkg.com/pouchdb-json/-/pouchdb-json-6.4.3.tgz";
        sha1 = "a1702c8eb9d656f6566920aaec9fb3e7e1265132";
      };
    }

    {
      name = "pouchdb-md5-6.4.3.tgz";
      path = fetchurl {
        name = "pouchdb-md5-6.4.3.tgz";
        url  = "https://registry.yarnpkg.com/pouchdb-md5/-/pouchdb-md5-6.4.3.tgz";
        sha1 = "d414315366e4bb428fb6048a25655b1eca591797";
      };
    }

    {
      name = "pouchdb-merge-6.4.3.tgz";
      path = fetchurl {
        name = "pouchdb-merge-6.4.3.tgz";
        url  = "https://registry.yarnpkg.com/pouchdb-merge/-/pouchdb-merge-6.4.3.tgz";
        sha1 = "4ef901f4aaa27be6aec0108998a127fe55bb0628";
      };
    }

    {
      name = "pouchdb-promise-6.4.3.tgz";
      path = fetchurl {
        name = "pouchdb-promise-6.4.3.tgz";
        url  = "https://registry.yarnpkg.com/pouchdb-promise/-/pouchdb-promise-6.4.3.tgz";
        sha1 = "74516f4acf74957b54debd0fb2c0e5b5a68ca7b3";
      };
    }

    {
      name = "pouchdb-utils-6.4.3.tgz";
      path = fetchurl {
        name = "pouchdb-utils-6.4.3.tgz";
        url  = "https://registry.yarnpkg.com/pouchdb-utils/-/pouchdb-utils-6.4.3.tgz";
        sha1 = "aeb6bb8cbd8cf2d9f04e499bc3b70d1ce2a6c78a";
      };
    }

    {
      name = "prelude-ls-1.1.2.tgz";
      path = fetchurl {
        name = "prelude-ls-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/prelude-ls/-/prelude-ls-1.1.2.tgz";
        sha1 = "21932a549f5e52ffd9a827f570e04be62a97da54";
      };
    }

    {
      name = "prepend-http-1.0.4.tgz";
      path = fetchurl {
        name = "prepend-http-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/prepend-http/-/prepend-http-1.0.4.tgz";
        sha1 = "d4f4562b0ce3696e41ac52d0e002e57a635dc6dc";
      };
    }

    {
      name = "preserve-0.2.0.tgz";
      path = fetchurl {
        name = "preserve-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/preserve/-/preserve-0.2.0.tgz";
        sha1 = "815ed1f6ebc65926f865b310c0713bcb3315ce4b";
      };
    }

    {
      name = "prettier-1.13.7.tgz";
      path = fetchurl {
        name = "prettier-1.13.7.tgz";
        url  = "https://registry.yarnpkg.com/prettier/-/prettier-1.13.7.tgz";
        sha1 = "850f3b8af784a49a6ea2d2eaa7ed1428a34b7281";
      };
    }

    {
      name = "pretty-error-2.1.1.tgz";
      path = fetchurl {
        name = "pretty-error-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/pretty-error/-/pretty-error-2.1.1.tgz";
        sha1 = "5f4f87c8f91e5ae3f3ba87ab4cf5e03b1a17f1a3";
      };
    }

    {
      name = "pretty-format-18.1.0.tgz";
      path = fetchurl {
        name = "pretty-format-18.1.0.tgz";
        url  = "https://registry.yarnpkg.com/pretty-format/-/pretty-format-18.1.0.tgz";
        sha1 = "fb65a86f7a7f9194963eee91865c1bcf1039e284";
      };
    }

    {
      name = "pretty-format-20.0.3.tgz";
      path = fetchurl {
        name = "pretty-format-20.0.3.tgz";
        url  = "https://registry.yarnpkg.com/pretty-format/-/pretty-format-20.0.3.tgz";
        sha1 = "020e350a560a1fe1a98dc3beb6ccffb386de8b14";
      };
    }

    {
      name = "pretty-format-21.2.1.tgz";
      path = fetchurl {
        name = "pretty-format-21.2.1.tgz";
        url  = "https://registry.yarnpkg.com/pretty-format/-/pretty-format-21.2.1.tgz";
        sha1 = "ae5407f3cf21066cd011aa1ba5fce7b6a2eddb36";
      };
    }

    {
      name = "pretty-format-22.4.3.tgz";
      path = fetchurl {
        name = "pretty-format-22.4.3.tgz";
        url  = "https://registry.yarnpkg.com/pretty-format/-/pretty-format-22.4.3.tgz";
        sha1 = "f873d780839a9c02e9664c8a082e9ee79eaac16f";
      };
    }

    {
      name = "private-0.1.8.tgz";
      path = fetchurl {
        name = "private-0.1.8.tgz";
        url  = "https://registry.yarnpkg.com/private/-/private-0.1.8.tgz";
        sha1 = "2381edb3689f7a53d653190060fcf822d2f368ff";
      };
    }

    {
      name = "process-nextick-args-1.0.7.tgz";
      path = fetchurl {
        name = "process-nextick-args-1.0.7.tgz";
        url  = "https://registry.yarnpkg.com/process-nextick-args/-/process-nextick-args-1.0.7.tgz";
        sha1 = "150e20b756590ad3f91093f25a4f2ad8bff30ba3";
      };
    }

    {
      name = "process-nextick-args-2.0.0.tgz";
      path = fetchurl {
        name = "process-nextick-args-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/process-nextick-args/-/process-nextick-args-2.0.0.tgz";
        sha1 = "a37d732f4271b4ab1ad070d35508e8290788ffaa";
      };
    }

    {
      name = "process-0.11.10.tgz";
      path = fetchurl {
        name = "process-0.11.10.tgz";
        url  = "https://registry.yarnpkg.com/process/-/process-0.11.10.tgz";
        sha1 = "7332300e840161bda3e69a1d1d91a7d4bc16f182";
      };
    }

    {
      name = "process-0.5.2.tgz";
      path = fetchurl {
        name = "process-0.5.2.tgz";
        url  = "https://registry.yarnpkg.com/process/-/process-0.5.2.tgz";
        sha1 = "1638d8a8e34c2f440a91db95ab9aeb677fc185cf";
      };
    }

    {
      name = "progress-1.1.8.tgz";
      path = fetchurl {
        name = "progress-1.1.8.tgz";
        url  = "https://registry.yarnpkg.com/progress/-/progress-1.1.8.tgz";
        sha1 = "e260c78f6161cdd9b0e56cc3e0a85de17c7a57be";
      };
    }

    {
      name = "progress-2.0.0.tgz";
      path = fetchurl {
        name = "progress-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/progress/-/progress-2.0.0.tgz";
        sha1 = "8a1be366bf8fc23db2bd23f10c6fe920b4389d1f";
      };
    }

    {
      name = "promise-inflight-1.0.1.tgz";
      path = fetchurl {
        name = "promise-inflight-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/promise-inflight/-/promise-inflight-1.0.1.tgz";
        sha1 = "98472870bf228132fcbdd868129bad12c3c029e3";
      };
    }

    {
      name = "promise-queue-2.2.5.tgz";
      path = fetchurl {
        name = "promise-queue-2.2.5.tgz";
        url  = "https://registry.yarnpkg.com/promise-queue/-/promise-queue-2.2.5.tgz";
        sha1 = "2f6f5f7c0f6d08109e967659c79b88a9ed5e93b4";
      };
    }

    {
      name = "promise-7.3.1.tgz";
      path = fetchurl {
        name = "promise-7.3.1.tgz";
        url  = "https://registry.yarnpkg.com/promise/-/promise-7.3.1.tgz";
        sha1 = "064b72602b18f90f29192b8b1bc418ffd1ebd3bf";
      };
    }

    {
      name = "promisify-event-1.0.0.tgz";
      path = fetchurl {
        name = "promisify-event-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/promisify-event/-/promisify-event-1.0.0.tgz";
        sha1 = "bd7523ea06b70162f370979016b53a686c60e90f";
      };
    }

    {
      name = "1c95d1d8d333b5fbc13fa5f0619f3dcf0d514f87";
      path = fetchurl {
        name = "1c95d1d8d333b5fbc13fa5f0619f3dcf0d514f87";
        url  = "https://codeload.github.com/flatiron/prompt/tar.gz/1c95d1d8d333b5fbc13fa5f0619f3dcf0d514f87";
        sha1 = "0c885cd640c74285f792592c381680cbf2b76e99";
      };
    }

    {
      name = "prop-types-extra-1.1.0.tgz";
      path = fetchurl {
        name = "prop-types-extra-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/prop-types-extra/-/prop-types-extra-1.1.0.tgz";
        sha1 = "32609910ea2dcf190366bacd3490d5a6412a605f";
      };
    }

    {
      name = "prop-types-15.6.2.tgz";
      path = fetchurl {
        name = "prop-types-15.6.2.tgz";
        url  = "https://registry.yarnpkg.com/prop-types/-/prop-types-15.6.2.tgz";
        sha1 = "05d5ca77b4453e985d60fc7ff8c859094a497102";
      };
    }

    {
      name = "property-is-enumerable-x-1.1.0.tgz";
      path = fetchurl {
        name = "property-is-enumerable-x-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/property-is-enumerable-x/-/property-is-enumerable-x-1.1.0.tgz";
        sha1 = "7ca48917476cd0914b37809bfd05776a0d942f6f";
      };
    }

    {
      name = "proxy-addr-2.0.3.tgz";
      path = fetchurl {
        name = "proxy-addr-2.0.3.tgz";
        url  = "https://registry.yarnpkg.com/proxy-addr/-/proxy-addr-2.0.3.tgz";
        sha1 = "355f262505a621646b3130a728eb647e22055341";
      };
    }

    {
      name = "prr-1.0.1.tgz";
      path = fetchurl {
        name = "prr-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/prr/-/prr-1.0.1.tgz";
        sha1 = "d3fc114ba06995a45ec6893f484ceb1d78f5f476";
      };
    }

    {
      name = "ps-node-0.1.6.tgz";
      path = fetchurl {
        name = "ps-node-0.1.6.tgz";
        url  = "https://registry.yarnpkg.com/ps-node/-/ps-node-0.1.6.tgz";
        sha1 = "9af67a99d7b1d0132e51a503099d38a8d2ace2c3";
      };
    }

    {
      name = "ps-tree-0.0.3.tgz";
      path = fetchurl {
        name = "ps-tree-0.0.3.tgz";
        url  = "https://registry.yarnpkg.com/ps-tree/-/ps-tree-0.0.3.tgz";
        sha1 = "dbf8d752a7fe22fa7d58635689499610e9276ddc";
      };
    }

    {
      name = "pseudomap-1.0.2.tgz";
      path = fetchurl {
        name = "pseudomap-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/pseudomap/-/pseudomap-1.0.2.tgz";
        sha1 = "f052a28da70e618917ef0a8ac34c1ae5a68286b3";
      };
    }

    {
      name = "psl-1.1.28.tgz";
      path = fetchurl {
        name = "psl-1.1.28.tgz";
        url  = "https://registry.yarnpkg.com/psl/-/psl-1.1.28.tgz";
        sha1 = "4fb6ceb08a1e2214d4fd4de0ca22dae13740bc7b";
      };
    }

    {
      name = "public-encrypt-4.0.2.tgz";
      path = fetchurl {
        name = "public-encrypt-4.0.2.tgz";
        url  = "https://registry.yarnpkg.com/public-encrypt/-/public-encrypt-4.0.2.tgz";
        sha1 = "46eb9107206bf73489f8b85b69d91334c6610994";
      };
    }

    {
      name = "pubsweet-client-2.5.5.tgz";
      path = fetchurl {
        name = "pubsweet-client-2.5.5.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-client/-/pubsweet-client-2.5.5.tgz";
        sha1 = "53235a55c2e806d22e572a12cf53da769c0adba2";
      };
    }

    {
      name = "pubsweet-component-epub-frontend-0.1.5.tgz";
      path = fetchurl {
        name = "pubsweet-component-epub-frontend-0.1.5.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-component-epub-frontend/-/pubsweet-component-epub-frontend-0.1.5.tgz";
        sha1 = "178065186eec0dc221763484ca76e949be61a0e6";
      };
    }

    {
      name = "pubsweet-component-epub-0.3.1.tgz";
      path = fetchurl {
        name = "pubsweet-component-epub-0.3.1.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-component-epub/-/pubsweet-component-epub-0.3.1.tgz";
        sha1 = "db5f02498595ba1d49959e6d994753475d26b9c5";
      };
    }

    {
      name = "pubsweet-component-ink-backend-0.1.1.tgz";
      path = fetchurl {
        name = "pubsweet-component-ink-backend-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-component-ink-backend/-/pubsweet-component-ink-backend-0.1.1.tgz";
        sha1 = "a1ed929c91503c14e1d8aaedfde1d33c365ab30c";
      };
    }

    {
      name = "pubsweet-component-ink-frontend-0.2.4.tgz";
      path = fetchurl {
        name = "pubsweet-component-ink-frontend-0.2.4.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-component-ink-frontend/-/pubsweet-component-ink-frontend-0.2.4.tgz";
        sha1 = "a5fbe4281c6f3fed759cfdb181ffadce61d49ef9";
      };
    }

    {
      name = "pubsweet-component-login-0.5.7.tgz";
      path = fetchurl {
        name = "pubsweet-component-login-0.5.7.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-component-login/-/pubsweet-component-login-0.5.7.tgz";
        sha1 = "10cac6a2d907bc9eda5be355d29b38499c87422f";
      };
    }

    {
      name = "pubsweet-component-manage-1.0.0.tgz";
      path = fetchurl {
        name = "pubsweet-component-manage-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-component-manage/-/pubsweet-component-manage-1.0.0.tgz";
        sha1 = "9424e5be947c1a34ae1e62f3a14a2ad93bfea00e";
      };
    }

    {
      name = "pubsweet-component-navigation-1.0.3.tgz";
      path = fetchurl {
        name = "pubsweet-component-navigation-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-component-navigation/-/pubsweet-component-navigation-1.0.3.tgz";
        sha1 = "7de9f04839969dbd613fa9d5996d82e4ea366966";
      };
    }

    {
      name = "pubsweet-component-password-reset-backend-1.0.0.tgz";
      path = fetchurl {
        name = "pubsweet-component-password-reset-backend-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-component-password-reset-backend/-/pubsweet-component-password-reset-backend-1.0.0.tgz";
        sha1 = "6911e73978c8a233bba092bf1f1cbcf6335e2a60";
      };
    }

    {
      name = "pubsweet-component-password-reset-frontend-1.0.0.tgz";
      path = fetchurl {
        name = "pubsweet-component-password-reset-frontend-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-component-password-reset-frontend/-/pubsweet-component-password-reset-frontend-1.0.0.tgz";
        sha1 = "8b2340eb179903571553dffeb3d8b5f15ad0c6d4";
      };
    }

    {
      name = "pubsweet-component-signup-0.4.3.tgz";
      path = fetchurl {
        name = "pubsweet-component-signup-0.4.3.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-component-signup/-/pubsweet-component-signup-0.4.3.tgz";
        sha1 = "031748751c66c597b76b5b523ed8c707efda86f1";
      };
    }

    {
      name = "pubsweet-component-teams-manager-1.0.0.tgz";
      path = fetchurl {
        name = "pubsweet-component-teams-manager-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-component-teams-manager/-/pubsweet-component-teams-manager-1.0.0.tgz";
        sha1 = "af2a931669342c7fb9e8385eeda266dd99b603cd";
      };
    }

    {
      name = "pubsweet-component-users-manager-1.0.0.tgz";
      path = fetchurl {
        name = "pubsweet-component-users-manager-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-component-users-manager/-/pubsweet-component-users-manager-1.0.0.tgz";
        sha1 = "1659ad808dc882f515dbb4a761e5c2243bab2e06";
      };
    }

    {
      name = "pubsweet-component-wax-0.6.7.tgz";
      path = fetchurl {
        name = "pubsweet-component-wax-0.6.7.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-component-wax/-/pubsweet-component-wax-0.6.7.tgz";
        sha1 = "8b7348343324d4d8a69905cec9f5e0a9b14d7a32";
      };
    }

    {
      name = "pubsweet-server-7.2.0.tgz";
      path = fetchurl {
        name = "pubsweet-server-7.2.0.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-server/-/pubsweet-server-7.2.0.tgz";
        sha1 = "b930f910b013957e2dfd54b856f2f91ead2b9351";
      };
    }

    {
      name = "pubsweet-sse-1.0.0.tgz";
      path = fetchurl {
        name = "pubsweet-sse-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-sse/-/pubsweet-sse-1.0.0.tgz";
        sha1 = "dd36aa378a302b518d417b545b064da65aec876a";
      };
    }

    {
      name = "pubsweet-theme-plugin-0.0.3.tgz";
      path = fetchurl {
        name = "pubsweet-theme-plugin-0.0.3.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet-theme-plugin/-/pubsweet-theme-plugin-0.0.3.tgz";
        sha1 = "1773543a95ed9f56eb8b14f13f24496e034d140b";
      };
    }

    {
      name = "pubsweet-2.2.8.tgz";
      path = fetchurl {
        name = "pubsweet-2.2.8.tgz";
        url  = "https://registry.yarnpkg.com/pubsweet/-/pubsweet-2.2.8.tgz";
        sha1 = "c0bd09d837a78fec673c011a42cc3578d31fc474";
      };
    }

    {
      name = "pump-2.0.1.tgz";
      path = fetchurl {
        name = "pump-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/pump/-/pump-2.0.1.tgz";
        sha1 = "12399add6e4cf7526d973cbc8b5ce2e2908b3909";
      };
    }

    {
      name = "pumpify-1.5.1.tgz";
      path = fetchurl {
        name = "pumpify-1.5.1.tgz";
        url  = "https://registry.yarnpkg.com/pumpify/-/pumpify-1.5.1.tgz";
        sha1 = "36513be246ab27570b1a374a5ce278bfd74370ce";
      };
    }

    {
      name = "punycode-1.3.2.tgz";
      path = fetchurl {
        name = "punycode-1.3.2.tgz";
        url  = "https://registry.yarnpkg.com/punycode/-/punycode-1.3.2.tgz";
        sha1 = "9653a036fb7c1ee42342f2325cceefea3926c48d";
      };
    }

    {
      name = "punycode-2.1.1.tgz";
      path = fetchurl {
        name = "punycode-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/punycode/-/punycode-2.1.1.tgz";
        sha1 = "b58b010ac40c22c5657616c8d2c2c02c7bf479ec";
      };
    }

    {
      name = "punycode-1.4.1.tgz";
      path = fetchurl {
        name = "punycode-1.4.1.tgz";
        url  = "https://registry.yarnpkg.com/punycode/-/punycode-1.4.1.tgz";
        sha1 = "c0d5a63b2718800ad8e1eb0fa5269c84dd41845e";
      };
    }

    {
      name = "q-i-2.0.1.tgz";
      path = fetchurl {
        name = "q-i-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/q-i/-/q-i-2.0.1.tgz";
        sha1 = "fec7e3f0e713f3467358bb5ac80bcc4c115187d6";
      };
    }

    {
      name = "q-1.5.1.tgz";
      path = fetchurl {
        name = "q-1.5.1.tgz";
        url  = "https://registry.yarnpkg.com/q/-/q-1.5.1.tgz";
        sha1 = "7e32f75b41381291d04611f1bf14109ac00651d7";
      };
    }

    {
      name = "qrcode-terminal-0.10.0.tgz";
      path = fetchurl {
        name = "qrcode-terminal-0.10.0.tgz";
        url  = "https://registry.yarnpkg.com/qrcode-terminal/-/qrcode-terminal-0.10.0.tgz";
        sha1 = "a76a48e2610a18f97fa3a2bd532b682acff86c53";
      };
    }

    {
      name = "qs-6.5.1.tgz";
      path = fetchurl {
        name = "qs-6.5.1.tgz";
        url  = "https://registry.yarnpkg.com/qs/-/qs-6.5.1.tgz";
        sha1 = "349cdf6eef89ec45c12d7d5eb3fc0c870343a6d8";
      };
    }

    {
      name = "qs-6.5.2.tgz";
      path = fetchurl {
        name = "qs-6.5.2.tgz";
        url  = "https://registry.yarnpkg.com/qs/-/qs-6.5.2.tgz";
        sha1 = "cb3ae806e8740444584ef154ce8ee98d403f3e36";
      };
    }

    {
      name = "qs-6.4.0.tgz";
      path = fetchurl {
        name = "qs-6.4.0.tgz";
        url  = "https://registry.yarnpkg.com/qs/-/qs-6.4.0.tgz";
        sha1 = "13e26d28ad6b0ffaa91312cd3bf708ed351e7233";
      };
    }

    {
      name = "query-string-4.3.4.tgz";
      path = fetchurl {
        name = "query-string-4.3.4.tgz";
        url  = "https://registry.yarnpkg.com/query-string/-/query-string-4.3.4.tgz";
        sha1 = "bbb693b9ca915c232515b228b1a02b609043dbeb";
      };
    }

    {
      name = "query-string-5.1.1.tgz";
      path = fetchurl {
        name = "query-string-5.1.1.tgz";
        url  = "https://registry.yarnpkg.com/query-string/-/query-string-5.1.1.tgz";
        sha1 = "a78c012b71c17e05f2e3fa2319dd330682efb3cb";
      };
    }

    {
      name = "querystring-es3-0.2.1.tgz";
      path = fetchurl {
        name = "querystring-es3-0.2.1.tgz";
        url  = "https://registry.yarnpkg.com/querystring-es3/-/querystring-es3-0.2.1.tgz";
        sha1 = "9ec61f79049875707d69414596fd907a4d711e73";
      };
    }

    {
      name = "querystring-0.2.0.tgz";
      path = fetchurl {
        name = "querystring-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/querystring/-/querystring-0.2.0.tgz";
        sha1 = "b209849203bb25df820da756e747005878521620";
      };
    }

    {
      name = "querystringify-2.0.0.tgz";
      path = fetchurl {
        name = "querystringify-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/querystringify/-/querystringify-2.0.0.tgz";
        sha1 = "fa3ed6e68eb15159457c89b37bc6472833195755";
      };
    }

    {
      name = "quick-lru-1.1.0.tgz";
      path = fetchurl {
        name = "quick-lru-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/quick-lru/-/quick-lru-1.1.0.tgz";
        sha1 = "4360b17c61136ad38078397ff11416e186dcfbb8";
      };
    }

    {
      name = "raf-3.4.0.tgz";
      path = fetchurl {
        name = "raf-3.4.0.tgz";
        url  = "https://registry.yarnpkg.com/raf/-/raf-3.4.0.tgz";
        sha1 = "a28876881b4bc2ca9117d4138163ddb80f781575";
      };
    }

    {
      name = "railroad-diagrams-1.0.0.tgz";
      path = fetchurl {
        name = "railroad-diagrams-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/railroad-diagrams/-/railroad-diagrams-1.0.0.tgz";
        sha1 = "eb7e6267548ddedfb899c1b90e57374559cddb7e";
      };
    }

    {
      name = "randexp-0.4.6.tgz";
      path = fetchurl {
        name = "randexp-0.4.6.tgz";
        url  = "https://registry.yarnpkg.com/randexp/-/randexp-0.4.6.tgz";
        sha1 = "e986ad5e5e31dae13ddd6f7b3019aa7c87f60ca3";
      };
    }

    {
      name = "randomatic-3.0.0.tgz";
      path = fetchurl {
        name = "randomatic-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/randomatic/-/randomatic-3.0.0.tgz";
        sha1 = "d35490030eb4f7578de292ce6dfb04a91a128923";
      };
    }

    {
      name = "randombytes-2.0.6.tgz";
      path = fetchurl {
        name = "randombytes-2.0.6.tgz";
        url  = "https://registry.yarnpkg.com/randombytes/-/randombytes-2.0.6.tgz";
        sha1 = "d302c522948588848a8d300c932b44c24231da80";
      };
    }

    {
      name = "randomfill-1.0.4.tgz";
      path = fetchurl {
        name = "randomfill-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/randomfill/-/randomfill-1.0.4.tgz";
        sha1 = "c92196fc86ab42be983f1bf31778224931d61458";
      };
    }

    {
      name = "range-parser-1.2.0.tgz";
      path = fetchurl {
        name = "range-parser-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/range-parser/-/range-parser-1.2.0.tgz";
        sha1 = "f49be6b487894ddc40dcc94a322f611092e00d5e";
      };
    }

    {
      name = "raw-body-2.3.2.tgz";
      path = fetchurl {
        name = "raw-body-2.3.2.tgz";
        url  = "https://registry.yarnpkg.com/raw-body/-/raw-body-2.3.2.tgz";
        sha1 = "bcd60c77d3eb93cde0050295c3f379389bc88f89";
      };
    }

    {
      name = "raw-body-2.3.3.tgz";
      path = fetchurl {
        name = "raw-body-2.3.3.tgz";
        url  = "https://registry.yarnpkg.com/raw-body/-/raw-body-2.3.3.tgz";
        sha1 = "1b324ece6b5706e153855bc1148c65bb7f6ea0c3";
      };
    }

    {
      name = "raw-loader-0.5.1.tgz";
      path = fetchurl {
        name = "raw-loader-0.5.1.tgz";
        url  = "https://registry.yarnpkg.com/raw-loader/-/raw-loader-0.5.1.tgz";
        sha1 = "0c3d0beaed8a01c966d9787bf778281252a979aa";
      };
    }

    {
      name = "rc-1.2.8.tgz";
      path = fetchurl {
        name = "rc-1.2.8.tgz";
        url  = "https://registry.yarnpkg.com/rc/-/rc-1.2.8.tgz";
        sha1 = "cd924bf5200a075b83c188cd6b9e211b7fc0d3ed";
      };
    }

    {
      name = "react-addons-test-utils-15.6.2.tgz";
      path = fetchurl {
        name = "react-addons-test-utils-15.6.2.tgz";
        url  = "https://registry.yarnpkg.com/react-addons-test-utils/-/react-addons-test-utils-15.6.2.tgz";
        sha1 = "c12b6efdc2247c10da7b8770d185080a7b047156";
      };
    }

    {
      name = "react-apollo-2.1.9.tgz";
      path = fetchurl {
        name = "react-apollo-2.1.9.tgz";
        url  = "https://registry.yarnpkg.com/react-apollo/-/react-apollo-2.1.9.tgz";
        sha1 = "1fd30ea2116375197bd53daa725e6fb8ab43ab80";
      };
    }

    {
      name = "react-bootstrap-0.32.1.tgz";
      path = fetchurl {
        name = "react-bootstrap-0.32.1.tgz";
        url  = "https://registry.yarnpkg.com/react-bootstrap/-/react-bootstrap-0.32.1.tgz";
        sha1 = "60624c1b48a39d773ef6cce6421a4f33ecc166bb";
      };
    }

    {
      name = "react-bootstrap-0.31.5.tgz";
      path = fetchurl {
        name = "react-bootstrap-0.31.5.tgz";
        url  = "https://registry.yarnpkg.com/react-bootstrap/-/react-bootstrap-0.31.5.tgz";
        sha1 = "57040fa8b1274e1e074803c21a1b895fdabea05a";
      };
    }

    {
      name = "react-codemirror2-4.3.0.tgz";
      path = fetchurl {
        name = "react-codemirror2-4.3.0.tgz";
        url  = "https://registry.yarnpkg.com/react-codemirror2/-/react-codemirror2-4.3.0.tgz";
        sha1 = "e79aedca4da60d22402d2cd74f2885a3e5c009fd";
      };
    }

    {
      name = "react-deep-force-update-2.1.1.tgz";
      path = fetchurl {
        name = "react-deep-force-update-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/react-deep-force-update/-/react-deep-force-update-2.1.1.tgz";
        sha1 = "8ea4263cd6455a050b37445b3f08fd839d86e909";
      };
    }

    {
      name = "react-dev-utils-5.0.1.tgz";
      path = fetchurl {
        name = "react-dev-utils-5.0.1.tgz";
        url  = "https://registry.yarnpkg.com/react-dev-utils/-/react-dev-utils-5.0.1.tgz";
        sha1 = "1f396e161fe44b595db1b186a40067289bf06613";
      };
    }

    {
      name = "react-dnd-html5-backend-2.5.4.tgz";
      path = fetchurl {
        name = "react-dnd-html5-backend-2.5.4.tgz";
        url  = "https://registry.yarnpkg.com/react-dnd-html5-backend/-/react-dnd-html5-backend-2.5.4.tgz";
        sha1 = "974ad083f67b12d56977a5b171f5ffeb29d78352";
      };
    }

    {
      name = "react-dnd-2.5.4.tgz";
      path = fetchurl {
        name = "react-dnd-2.5.4.tgz";
        url  = "https://registry.yarnpkg.com/react-dnd/-/react-dnd-2.5.4.tgz";
        sha1 = "0b6dc5e9d0dfc2909f4f4fe736e5534f3afd1bd9";
      };
    }

    {
      name = "react-docgen-annotation-resolver-1.0.0.tgz";
      path = fetchurl {
        name = "react-docgen-annotation-resolver-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/react-docgen-annotation-resolver/-/react-docgen-annotation-resolver-1.0.0.tgz";
        sha1 = "abbb343698b3b319537142082b6bb7d835fe2f1f";
      };
    }

    {
      name = "react-docgen-displayname-handler-1.0.1.tgz";
      path = fetchurl {
        name = "react-docgen-displayname-handler-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/react-docgen-displayname-handler/-/react-docgen-displayname-handler-1.0.1.tgz";
        sha1 = "6944875d19c51d3f657f2506610958bb19c66fcc";
      };
    }

    {
      name = "react-docgen-3.0.0-beta9.tgz";
      path = fetchurl {
        name = "react-docgen-3.0.0-beta9.tgz";
        url  = "https://registry.yarnpkg.com/react-docgen/-/react-docgen-3.0.0-beta9.tgz";
        sha1 = "6be987e640786ecb10ce2dd22157a022c8285e95";
      };
    }

    {
      name = "react-dom-16.4.1.tgz";
      path = fetchurl {
        name = "react-dom-16.4.1.tgz";
        url  = "https://registry.yarnpkg.com/react-dom/-/react-dom-16.4.1.tgz";
        sha1 = "7f8b0223b3a5fbe205116c56deb85de32685dad6";
      };
    }

    {
      name = "react-dropzone-3.13.4.tgz";
      path = fetchurl {
        name = "react-dropzone-3.13.4.tgz";
        url  = "https://registry.yarnpkg.com/react-dropzone/-/react-dropzone-3.13.4.tgz";
        sha1 = "84da26815c40339691c49b4544c2ef7a16912ccc";
      };
    }

    {
      name = "react-error-overlay-4.0.0.tgz";
      path = fetchurl {
        name = "react-error-overlay-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/react-error-overlay/-/react-error-overlay-4.0.0.tgz";
        sha1 = "d198408a85b4070937a98667f500c832f86bd5d4";
      };
    }

    {
      name = "react-feather-1.1.1.tgz";
      path = fetchurl {
        name = "react-feather-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/react-feather/-/react-feather-1.1.1.tgz";
        sha1 = "dd59143af457601e68f2cd3bf32c0d94d30f89e7";
      };
    }

    {
      name = "react-group-1.0.6.tgz";
      path = fetchurl {
        name = "react-group-1.0.6.tgz";
        url  = "https://registry.yarnpkg.com/react-group/-/react-group-1.0.6.tgz";
        sha1 = "8dd7c00c3b35d05ce164021458bb07d580e3001a";
      };
    }

    {
      name = "react-hot-loader-3.1.3.tgz";
      path = fetchurl {
        name = "react-hot-loader-3.1.3.tgz";
        url  = "https://registry.yarnpkg.com/react-hot-loader/-/react-hot-loader-3.1.3.tgz";
        sha1 = "6f92877326958c7cb0134b512474517869126082";
      };
    }

    {
      name = "react-icon-base-2.1.0.tgz";
      path = fetchurl {
        name = "react-icon-base-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/react-icon-base/-/react-icon-base-2.1.0.tgz";
        sha1 = "a196e33fdf1e7aaa1fda3aefbb68bdad9e82a79d";
      };
    }

    {
      name = "react-icons-2.2.7.tgz";
      path = fetchurl {
        name = "react-icons-2.2.7.tgz";
        url  = "https://registry.yarnpkg.com/react-icons/-/react-icons-2.2.7.tgz";
        sha1 = "d7860826b258557510dac10680abea5ca23cf650";
      };
    }

    {
      name = "react-input-autosize-2.2.1.tgz";
      path = fetchurl {
        name = "react-input-autosize-2.2.1.tgz";
        url  = "https://registry.yarnpkg.com/react-input-autosize/-/react-input-autosize-2.2.1.tgz";
        sha1 = "ec428fa15b1592994fb5f9aa15bb1eb6baf420f8";
      };
    }

    {
      name = "react-is-16.4.1.tgz";
      path = fetchurl {
        name = "react-is-16.4.1.tgz";
        url  = "https://registry.yarnpkg.com/react-is/-/react-is-16.4.1.tgz";
        sha1 = "d624c4650d2c65dbd52c72622bbf389435d9776e";
      };
    }

    {
      name = "react-lifecycles-compat-3.0.4.tgz";
      path = fetchurl {
        name = "react-lifecycles-compat-3.0.4.tgz";
        url  = "https://registry.yarnpkg.com/react-lifecycles-compat/-/react-lifecycles-compat-3.0.4.tgz";
        sha1 = "4f1a273afdfc8f3488a8c516bfda78f872352362";
      };
    }

    {
      name = "react-overlays-0.7.4.tgz";
      path = fetchurl {
        name = "react-overlays-0.7.4.tgz";
        url  = "https://registry.yarnpkg.com/react-overlays/-/react-overlays-0.7.4.tgz";
        sha1 = "ef2ec652c3444ab8aa014262b18f662068e56d5c";
      };
    }

    {
      name = "react-overlays-0.8.3.tgz";
      path = fetchurl {
        name = "react-overlays-0.8.3.tgz";
        url  = "https://registry.yarnpkg.com/react-overlays/-/react-overlays-0.8.3.tgz";
        sha1 = "fad65eea5b24301cca192a169f5dddb0b20d3ac5";
      };
    }

    {
      name = "react-prop-types-0.4.0.tgz";
      path = fetchurl {
        name = "react-prop-types-0.4.0.tgz";
        url  = "https://registry.yarnpkg.com/react-prop-types/-/react-prop-types-0.4.0.tgz";
        sha1 = "f99b0bfb4006929c9af2051e7c1414a5c75b93d0";
      };
    }

    {
      name = "react-proxy-3.0.0-alpha.1.tgz";
      path = fetchurl {
        name = "react-proxy-3.0.0-alpha.1.tgz";
        url  = "https://registry.yarnpkg.com/react-proxy/-/react-proxy-3.0.0-alpha.1.tgz";
        sha1 = "4400426bcfa80caa6724c7755695315209fa4b07";
      };
    }

    {
      name = "react-reconciler-0.7.0.tgz";
      path = fetchurl {
        name = "react-reconciler-0.7.0.tgz";
        url  = "https://registry.yarnpkg.com/react-reconciler/-/react-reconciler-0.7.0.tgz";
        sha1 = "9614894103e5f138deeeb5eabaf3ee80eb1d026d";
      };
    }

    {
      name = "react-redux-5.0.4.tgz";
      path = fetchurl {
        name = "react-redux-5.0.4.tgz";
        url  = "https://registry.yarnpkg.com/react-redux/-/react-redux-5.0.4.tgz";
        sha1 = "1563babadcfb2672f57f9ceaa439fb16bf85d55b";
      };
    }

    {
      name = "react-redux-5.0.7.tgz";
      path = fetchurl {
        name = "react-redux-5.0.7.tgz";
        url  = "https://registry.yarnpkg.com/react-redux/-/react-redux-5.0.7.tgz";
        sha1 = "0dc1076d9afb4670f993ffaef44b8f8c1155a4c8";
      };
    }

    {
      name = "react-router-bootstrap-0.24.4.tgz";
      path = fetchurl {
        name = "react-router-bootstrap-0.24.4.tgz";
        url  = "https://registry.yarnpkg.com/react-router-bootstrap/-/react-router-bootstrap-0.24.4.tgz";
        sha1 = "6e89481d8a8979649a0dd4535e4a68df4a3d0b12";
      };
    }

    {
      name = "react-router-dom-4.2.2.tgz";
      path = fetchurl {
        name = "react-router-dom-4.2.2.tgz";
        url  = "https://registry.yarnpkg.com/react-router-dom/-/react-router-dom-4.2.2.tgz";
        sha1 = "c8a81df3adc58bba8a76782e946cbd4eae649b8d";
      };
    }

    {
      name = "react-router-dom-4.3.1.tgz";
      path = fetchurl {
        name = "react-router-dom-4.3.1.tgz";
        url  = "https://registry.yarnpkg.com/react-router-dom/-/react-router-dom-4.3.1.tgz";
        sha1 = "4c2619fc24c4fa87c9fd18f4fb4a43fe63fbd5c6";
      };
    }

    {
      name = "react-router-redux-4.0.8.tgz";
      path = fetchurl {
        name = "react-router-redux-4.0.8.tgz";
        url  = "https://registry.yarnpkg.com/react-router-redux/-/react-router-redux-4.0.8.tgz";
        sha1 = "227403596b5151e182377dab835b5d45f0f8054e";
      };
    }

    {
      name = "react-router-redux-5.0.0-alpha.9.tgz";
      path = fetchurl {
        name = "react-router-redux-5.0.0-alpha.9.tgz";
        url  = "https://registry.yarnpkg.com/react-router-redux/-/react-router-redux-5.0.0-alpha.9.tgz";
        sha1 = "825431516e0e6f1fd93b8807f6bd595e23ec3d10";
      };
    }

    {
      name = "react-router-4.3.1.tgz";
      path = fetchurl {
        name = "react-router-4.3.1.tgz";
        url  = "https://registry.yarnpkg.com/react-router/-/react-router-4.3.1.tgz";
        sha1 = "aada4aef14c809cb2e686b05cee4742234506c4e";
      };
    }

    {
      name = "react-select-1.2.1.tgz";
      path = fetchurl {
        name = "react-select-1.2.1.tgz";
        url  = "https://registry.yarnpkg.com/react-select/-/react-select-1.2.1.tgz";
        sha1 = "a2fe58a569eb14dcaa6543816260b97e538120d1";
      };
    }

    {
      name = "react-styleguidist-6.5.3.tgz";
      path = fetchurl {
        name = "react-styleguidist-6.5.3.tgz";
        url  = "https://registry.yarnpkg.com/react-styleguidist/-/react-styleguidist-6.5.3.tgz";
        sha1 = "17abbfd14cfc4e0eb8921bb03d7cbd74836b0b5b";
      };
    }

    {
      name = "react-tag-autocomplete-5.5.1.tgz";
      path = fetchurl {
        name = "react-tag-autocomplete-5.5.1.tgz";
        url  = "https://registry.yarnpkg.com/react-tag-autocomplete/-/react-tag-autocomplete-5.5.1.tgz";
        sha1 = "6b3f253d3d69eb546925118cdf43138a9aafe113";
      };
    }

    {
      name = "react-test-renderer-15.6.2.tgz";
      path = fetchurl {
        name = "react-test-renderer-15.6.2.tgz";
        url  = "https://registry.yarnpkg.com/react-test-renderer/-/react-test-renderer-15.6.2.tgz";
        sha1 = "d0333434fc2c438092696ca770da5ed48037efa8";
      };
    }

    {
      name = "react-test-renderer-16.4.1.tgz";
      path = fetchurl {
        name = "react-test-renderer-16.4.1.tgz";
        url  = "https://registry.yarnpkg.com/react-test-renderer/-/react-test-renderer-16.4.1.tgz";
        sha1 = "f2fb30c2c7b517db6e5b10ed20bb6b0a7ccd8d70";
      };
    }

    {
      name = "react-transition-group-2.4.0.tgz";
      path = fetchurl {
        name = "react-transition-group-2.4.0.tgz";
        url  = "https://registry.yarnpkg.com/react-transition-group/-/react-transition-group-2.4.0.tgz";
        sha1 = "1d9391fabfd82e016f26fabd1eec329dbd922b5a";
      };
    }

    {
      name = "react-16.4.1.tgz";
      path = fetchurl {
        name = "react-16.4.1.tgz";
        url  = "https://registry.yarnpkg.com/react/-/react-16.4.1.tgz";
        sha1 = "de51ba5764b5dbcd1f9079037b862bd26b82fe32";
      };
    }

    {
      name = "read-cmd-shim-1.0.1.tgz";
      path = fetchurl {
        name = "read-cmd-shim-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/read-cmd-shim/-/read-cmd-shim-1.0.1.tgz";
        sha1 = "2d5d157786a37c055d22077c32c53f8329e91c7b";
      };
    }

    {
      name = "read-file-relative-1.2.0.tgz";
      path = fetchurl {
        name = "read-file-relative-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/read-file-relative/-/read-file-relative-1.2.0.tgz";
        sha1 = "98f7d96eaa21d2b4c7a2febd63d2fc8cf35e9f9b";
      };
    }

    {
      name = "read-pkg-up-1.0.1.tgz";
      path = fetchurl {
        name = "read-pkg-up-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/read-pkg-up/-/read-pkg-up-1.0.1.tgz";
        sha1 = "9d63c13276c065918d57f002a57f40a1b643fb02";
      };
    }

    {
      name = "read-pkg-up-2.0.0.tgz";
      path = fetchurl {
        name = "read-pkg-up-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/read-pkg-up/-/read-pkg-up-2.0.0.tgz";
        sha1 = "6b72a8048984e0c41e79510fd5e9fa99b3b549be";
      };
    }

    {
      name = "read-pkg-up-3.0.0.tgz";
      path = fetchurl {
        name = "read-pkg-up-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/read-pkg-up/-/read-pkg-up-3.0.0.tgz";
        sha1 = "3ed496685dba0f8fe118d0691dc51f4a1ff96f07";
      };
    }

    {
      name = "read-pkg-1.1.0.tgz";
      path = fetchurl {
        name = "read-pkg-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/read-pkg/-/read-pkg-1.1.0.tgz";
        sha1 = "f5ffaa5ecd29cb31c0474bca7d756b6bb29e3f28";
      };
    }

    {
      name = "read-pkg-2.0.0.tgz";
      path = fetchurl {
        name = "read-pkg-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/read-pkg/-/read-pkg-2.0.0.tgz";
        sha1 = "8ef1c0623c6a6db0dc6713c4bfac46332b2368f8";
      };
    }

    {
      name = "read-pkg-3.0.0.tgz";
      path = fetchurl {
        name = "read-pkg-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/read-pkg/-/read-pkg-3.0.0.tgz";
        sha1 = "9cbc686978fee65d16c00e2b19c237fcf6e38389";
      };
    }

    {
      name = "read-1.0.7.tgz";
      path = fetchurl {
        name = "read-1.0.7.tgz";
        url  = "https://registry.yarnpkg.com/read/-/read-1.0.7.tgz";
        sha1 = "b3da19bd052431a97671d44a42634adf710b40c4";
      };
    }

    {
      name = "readable-stream-2.3.6.tgz";
      path = fetchurl {
        name = "readable-stream-2.3.6.tgz";
        url  = "https://registry.yarnpkg.com/readable-stream/-/readable-stream-2.3.6.tgz";
        sha1 = "b11c27d88b8ff1fbe070643cf94b0c79ae1b0aaf";
      };
    }

    {
      name = "readable-stream-1.0.34.tgz";
      path = fetchurl {
        name = "readable-stream-1.0.34.tgz";
        url  = "https://registry.yarnpkg.com/readable-stream/-/readable-stream-1.0.34.tgz";
        sha1 = "125820e34bc842d2f2aaafafe4c2916ee32c157c";
      };
    }

    {
      name = "readable-stream-1.0.33.tgz";
      path = fetchurl {
        name = "readable-stream-1.0.33.tgz";
        url  = "https://registry.yarnpkg.com/readable-stream/-/readable-stream-1.0.33.tgz";
        sha1 = "3a360dd66c1b1d7fd4705389860eda1d0f61126c";
      };
    }

    {
      name = "readable-stream-1.1.14.tgz";
      path = fetchurl {
        name = "readable-stream-1.1.14.tgz";
        url  = "https://registry.yarnpkg.com/readable-stream/-/readable-stream-1.1.14.tgz";
        sha1 = "7cf4c54ef648e3813084c636dd2079e166c081d9";
      };
    }

    {
      name = "readable-stream-2.1.5.tgz";
      path = fetchurl {
        name = "readable-stream-2.1.5.tgz";
        url  = "https://registry.yarnpkg.com/readable-stream/-/readable-stream-2.1.5.tgz";
        sha1 = "66fa8b720e1438b364681f2ad1a63c618448c9d0";
      };
    }

    {
      name = "readdirp-2.1.0.tgz";
      path = fetchurl {
        name = "readdirp-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/readdirp/-/readdirp-2.1.0.tgz";
        sha1 = "4ed0ad060df3073300c48440373f72d1cc642d78";
      };
    }

    {
      name = "readline2-1.0.1.tgz";
      path = fetchurl {
        name = "readline2-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/readline2/-/readline2-1.0.1.tgz";
        sha1 = "41059608ffc154757b715d9989d199ffbf372e35";
      };
    }

    {
      name = "realpath-native-1.0.1.tgz";
      path = fetchurl {
        name = "realpath-native-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/realpath-native/-/realpath-native-1.0.1.tgz";
        sha1 = "07f40a0cce8f8261e2e8b7ebebf5c95965d7b633";
      };
    }

    {
      name = "recast-0.12.6.tgz";
      path = fetchurl {
        name = "recast-0.12.6.tgz";
        url  = "https://registry.yarnpkg.com/recast/-/recast-0.12.6.tgz";
        sha1 = "4b0fb82feb1d10b3bd62d34943426d9b3ed30d4c";
      };
    }

    {
      name = "recast-0.12.9.tgz";
      path = fetchurl {
        name = "recast-0.12.9.tgz";
        url  = "https://registry.yarnpkg.com/recast/-/recast-0.12.9.tgz";
        sha1 = "e8e52bdb9691af462ccbd7c15d5a5113647a15f1";
      };
    }

    {
      name = "rechoir-0.6.2.tgz";
      path = fetchurl {
        name = "rechoir-0.6.2.tgz";
        url  = "https://registry.yarnpkg.com/rechoir/-/rechoir-0.6.2.tgz";
        sha1 = "85204b54dba82d5742e28c96756ef43af50e3384";
      };
    }

    {
      name = "recompose-0.26.0.tgz";
      path = fetchurl {
        name = "recompose-0.26.0.tgz";
        url  = "https://registry.yarnpkg.com/recompose/-/recompose-0.26.0.tgz";
        sha1 = "9babff039cb72ba5bd17366d55d7232fbdfb2d30";
      };
    }

    {
      name = "recursive-readdir-2.2.1.tgz";
      path = fetchurl {
        name = "recursive-readdir-2.2.1.tgz";
        url  = "https://registry.yarnpkg.com/recursive-readdir/-/recursive-readdir-2.2.1.tgz";
        sha1 = "90ef231d0778c5ce093c9a48d74e5c5422d13a99";
      };
    }

    {
      name = "redbox-react-1.6.0.tgz";
      path = fetchurl {
        name = "redbox-react-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/redbox-react/-/redbox-react-1.6.0.tgz";
        sha1 = "e753ac02595bc1bf695b3935889a4f5b1b5a21a1";
      };
    }

    {
      name = "redent-1.0.0.tgz";
      path = fetchurl {
        name = "redent-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/redent/-/redent-1.0.0.tgz";
        sha1 = "cf916ab1fd5f1f16dfb20822dd6ec7f730c2afde";
      };
    }

    {
      name = "redent-2.0.0.tgz";
      path = fetchurl {
        name = "redent-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/redent/-/redent-2.0.0.tgz";
        sha1 = "c1b2007b42d57eb1389079b3c8333639d5e1ccaa";
      };
    }

    {
      name = "redeyed-1.0.1.tgz";
      path = fetchurl {
        name = "redeyed-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/redeyed/-/redeyed-1.0.1.tgz";
        sha1 = "e96c193b40c0816b00aec842698e61185e55498a";
      };
    }

    {
      name = "reduce-css-calc-1.3.0.tgz";
      path = fetchurl {
        name = "reduce-css-calc-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/reduce-css-calc/-/reduce-css-calc-1.3.0.tgz";
        sha1 = "747c914e049614a4c9cfbba629871ad1d2927716";
      };
    }

    {
      name = "reduce-extract-1.0.0.tgz";
      path = fetchurl {
        name = "reduce-extract-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/reduce-extract/-/reduce-extract-1.0.0.tgz";
        sha1 = "67f2385beda65061b5f5f4312662e8b080ca1525";
      };
    }

    {
      name = "reduce-flatten-1.0.1.tgz";
      path = fetchurl {
        name = "reduce-flatten-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/reduce-flatten/-/reduce-flatten-1.0.1.tgz";
        sha1 = "258c78efd153ddf93cb561237f61184f3696e327";
      };
    }

    {
      name = "reduce-function-call-1.0.2.tgz";
      path = fetchurl {
        name = "reduce-function-call-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/reduce-function-call/-/reduce-function-call-1.0.2.tgz";
        sha1 = "5a200bf92e0e37751752fe45b0ab330fd4b6be99";
      };
    }

    {
      name = "reduce-unique-1.0.0.tgz";
      path = fetchurl {
        name = "reduce-unique-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/reduce-unique/-/reduce-unique-1.0.0.tgz";
        sha1 = "7e586bcf87a4e32b6d7abd8277fad6cdec9f4803";
      };
    }

    {
      name = "reduce-without-1.0.1.tgz";
      path = fetchurl {
        name = "reduce-without-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/reduce-without/-/reduce-without-1.0.1.tgz";
        sha1 = "68ad0ead11855c9a37d4e8256c15bbf87972fc8c";
      };
    }

    {
      name = "redux-form-7.4.2.tgz";
      path = fetchurl {
        name = "redux-form-7.4.2.tgz";
        url  = "https://registry.yarnpkg.com/redux-form/-/redux-form-7.4.2.tgz";
        sha1 = "d6061088fb682eb9fc5fb9749bd8b102f03154b0";
      };
    }

    {
      name = "redux-logger-3.0.6.tgz";
      path = fetchurl {
        name = "redux-logger-3.0.6.tgz";
        url  = "https://registry.yarnpkg.com/redux-logger/-/redux-logger-3.0.6.tgz";
        sha1 = "f7555966f3098f3c88604c449cf0baf5778274bf";
      };
    }

    {
      name = "redux-thunk-2.3.0.tgz";
      path = fetchurl {
        name = "redux-thunk-2.3.0.tgz";
        url  = "https://registry.yarnpkg.com/redux-thunk/-/redux-thunk-2.3.0.tgz";
        sha1 = "51c2c19a185ed5187aaa9a2d08b666d0d6467622";
      };
    }

    {
      name = "redux-3.6.0.tgz";
      path = fetchurl {
        name = "redux-3.6.0.tgz";
        url  = "https://registry.yarnpkg.com/redux/-/redux-3.6.0.tgz";
        sha1 = "887c2b3d0b9bd86eca2be70571c27654c19e188d";
      };
    }

    {
      name = "redux-3.7.2.tgz";
      path = fetchurl {
        name = "redux-3.7.2.tgz";
        url  = "https://registry.yarnpkg.com/redux/-/redux-3.7.2.tgz";
        sha1 = "06b73123215901d25d065be342eb026bc1c8537b";
      };
    }

    {
      name = "referrer-policy-1.1.0.tgz";
      path = fetchurl {
        name = "referrer-policy-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/referrer-policy/-/referrer-policy-1.1.0.tgz";
        sha1 = "35774eb735bf50fb6c078e83334b472350207d79";
      };
    }

    {
      name = "regenerate-1.4.0.tgz";
      path = fetchurl {
        name = "regenerate-1.4.0.tgz";
        url  = "https://registry.yarnpkg.com/regenerate/-/regenerate-1.4.0.tgz";
        sha1 = "4a856ec4b56e4077c557589cae85e7a4c8869a11";
      };
    }

    {
      name = "regenerator-runtime-0.11.1.tgz";
      path = fetchurl {
        name = "regenerator-runtime-0.11.1.tgz";
        url  = "https://registry.yarnpkg.com/regenerator-runtime/-/regenerator-runtime-0.11.1.tgz";
        sha1 = "be05ad7f9bf7d22e056f9726cee5017fbf19e2e9";
      };
    }

    {
      name = "regenerator-runtime-0.12.0.tgz";
      path = fetchurl {
        name = "regenerator-runtime-0.12.0.tgz";
        url  = "https://registry.yarnpkg.com/regenerator-runtime/-/regenerator-runtime-0.12.0.tgz";
        sha1 = "8052ac952d85b10f3425192cd0c53f45cf65c6cb";
      };
    }

    {
      name = "regenerator-transform-0.10.1.tgz";
      path = fetchurl {
        name = "regenerator-transform-0.10.1.tgz";
        url  = "https://registry.yarnpkg.com/regenerator-transform/-/regenerator-transform-0.10.1.tgz";
        sha1 = "1e4996837231da8b7f3cf4114d71b5691a0680dd";
      };
    }

    {
      name = "regex-cache-0.4.4.tgz";
      path = fetchurl {
        name = "regex-cache-0.4.4.tgz";
        url  = "https://registry.yarnpkg.com/regex-cache/-/regex-cache-0.4.4.tgz";
        sha1 = "75bdc58a2a1496cec48a12835bc54c8d562336dd";
      };
    }

    {
      name = "regex-not-1.0.2.tgz";
      path = fetchurl {
        name = "regex-not-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/regex-not/-/regex-not-1.0.2.tgz";
        sha1 = "1f4ece27e00b0b65e0247a6810e6a85d83a5752c";
      };
    }

    {
      name = "regexpp-1.1.0.tgz";
      path = fetchurl {
        name = "regexpp-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/regexpp/-/regexpp-1.1.0.tgz";
        sha1 = "0e3516dd0b7904f413d2d4193dce4618c3a689ab";
      };
    }

    {
      name = "regexpu-core-1.0.0.tgz";
      path = fetchurl {
        name = "regexpu-core-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/regexpu-core/-/regexpu-core-1.0.0.tgz";
        sha1 = "86a763f58ee4d7c2f6b102e4764050de7ed90c6b";
      };
    }

    {
      name = "regexpu-core-2.0.0.tgz";
      path = fetchurl {
        name = "regexpu-core-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/regexpu-core/-/regexpu-core-2.0.0.tgz";
        sha1 = "49d038837b8dcf8bfa5b9a42139938e6ea2ae240";
      };
    }

    {
      name = "registry-auth-token-3.3.2.tgz";
      path = fetchurl {
        name = "registry-auth-token-3.3.2.tgz";
        url  = "https://registry.yarnpkg.com/registry-auth-token/-/registry-auth-token-3.3.2.tgz";
        sha1 = "851fd49038eecb586911115af845260eec983f20";
      };
    }

    {
      name = "registry-url-3.1.0.tgz";
      path = fetchurl {
        name = "registry-url-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/registry-url/-/registry-url-3.1.0.tgz";
        sha1 = "3d4ef870f73dde1d77f0cf9a381432444e174942";
      };
    }

    {
      name = "regjsgen-0.2.0.tgz";
      path = fetchurl {
        name = "regjsgen-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/regjsgen/-/regjsgen-0.2.0.tgz";
        sha1 = "6c016adeac554f75823fe37ac05b92d5a4edb1f7";
      };
    }

    {
      name = "regjsparser-0.1.5.tgz";
      path = fetchurl {
        name = "regjsparser-0.1.5.tgz";
        url  = "https://registry.yarnpkg.com/regjsparser/-/regjsparser-0.1.5.tgz";
        sha1 = "7ee8f84dc6fa792d3fd0ae228d24bd949ead205c";
      };
    }

    {
      name = "relateurl-0.2.7.tgz";
      path = fetchurl {
        name = "relateurl-0.2.7.tgz";
        url  = "https://registry.yarnpkg.com/relateurl/-/relateurl-0.2.7.tgz";
        sha1 = "54dbf377e51440aca90a4cd274600d3ff2d888a9";
      };
    }

    {
      name = "remark-parse-4.0.0.tgz";
      path = fetchurl {
        name = "remark-parse-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/remark-parse/-/remark-parse-4.0.0.tgz";
        sha1 = "99f1f049afac80382366e2e0d0bd55429dd45d8b";
      };
    }

    {
      name = "remark-parse-5.0.0.tgz";
      path = fetchurl {
        name = "remark-parse-5.0.0.tgz";
        url  = "https://registry.yarnpkg.com/remark-parse/-/remark-parse-5.0.0.tgz";
        sha1 = "4c077f9e499044d1d5c13f80d7a98cf7b9285d95";
      };
    }

    {
      name = "remark-stringify-4.0.0.tgz";
      path = fetchurl {
        name = "remark-stringify-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/remark-stringify/-/remark-stringify-4.0.0.tgz";
        sha1 = "4431884c0418f112da44991b4e356cfe37facd87";
      };
    }

    {
      name = "remark-stringify-5.0.0.tgz";
      path = fetchurl {
        name = "remark-stringify-5.0.0.tgz";
        url  = "https://registry.yarnpkg.com/remark-stringify/-/remark-stringify-5.0.0.tgz";
        sha1 = "336d3a4d4a6a3390d933eeba62e8de4bd280afba";
      };
    }

    {
      name = "remark-8.0.0.tgz";
      path = fetchurl {
        name = "remark-8.0.0.tgz";
        url  = "https://registry.yarnpkg.com/remark/-/remark-8.0.0.tgz";
        sha1 = "287b6df2fe1190e263c1d15e486d3fa835594d6d";
      };
    }

    {
      name = "remark-9.0.0.tgz";
      path = fetchurl {
        name = "remark-9.0.0.tgz";
        url  = "https://registry.yarnpkg.com/remark/-/remark-9.0.0.tgz";
        sha1 = "c5cfa8ec535c73a67c4b0f12bfdbd3a67d8b2f60";
      };
    }

    {
      name = "remove-trailing-separator-1.1.0.tgz";
      path = fetchurl {
        name = "remove-trailing-separator-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/remove-trailing-separator/-/remove-trailing-separator-1.1.0.tgz";
        sha1 = "c24bce2a283adad5bc3f58e0d48249b92379d8ef";
      };
    }

    {
      name = "renderkid-2.0.1.tgz";
      path = fetchurl {
        name = "renderkid-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/renderkid/-/renderkid-2.0.1.tgz";
        sha1 = "898cabfc8bede4b7b91135a3ffd323e58c0db319";
      };
    }

    {
      name = "repeat-element-1.1.2.tgz";
      path = fetchurl {
        name = "repeat-element-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/repeat-element/-/repeat-element-1.1.2.tgz";
        sha1 = "ef089a178d1483baae4d93eb98b4f9e4e11d990a";
      };
    }

    {
      name = "repeat-string-1.6.1.tgz";
      path = fetchurl {
        name = "repeat-string-1.6.1.tgz";
        url  = "https://registry.yarnpkg.com/repeat-string/-/repeat-string-1.6.1.tgz";
        sha1 = "8dcae470e1c88abc2d600fff4a776286da75e637";
      };
    }

    {
      name = "repeating-1.1.3.tgz";
      path = fetchurl {
        name = "repeating-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/repeating/-/repeating-1.1.3.tgz";
        sha1 = "3d4114218877537494f97f77f9785fab810fa4ac";
      };
    }

    {
      name = "repeating-2.0.1.tgz";
      path = fetchurl {
        name = "repeating-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/repeating/-/repeating-2.0.1.tgz";
        sha1 = "5214c53a926d3552707527fbab415dbc08d06dda";
      };
    }

    {
      name = "replace-comments-x-2.0.0.tgz";
      path = fetchurl {
        name = "replace-comments-x-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/replace-comments-x/-/replace-comments-x-2.0.0.tgz";
        sha1 = "a5cec18efd912aad78a7c3c4b69d01768556d140";
      };
    }

    {
      name = "replace-ext-1.0.0.tgz";
      path = fetchurl {
        name = "replace-ext-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/replace-ext/-/replace-ext-1.0.0.tgz";
        sha1 = "de63128373fcbf7c3ccfa4de5a480c45a67958eb";
      };
    }

    {
      name = "replicator-1.0.2.tgz";
      path = fetchurl {
        name = "replicator-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/replicator/-/replicator-1.0.2.tgz";
        sha1 = "f21812f28f3b853a34795a7d52814581df652fe1";
      };
    }

    {
      name = "request-promise-core-1.1.1.tgz";
      path = fetchurl {
        name = "request-promise-core-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/request-promise-core/-/request-promise-core-1.1.1.tgz";
        sha1 = "3eee00b2c5aa83239cfb04c5700da36f81cd08b6";
      };
    }

    {
      name = "request-promise-native-1.0.5.tgz";
      path = fetchurl {
        name = "request-promise-native-1.0.5.tgz";
        url  = "https://registry.yarnpkg.com/request-promise-native/-/request-promise-native-1.0.5.tgz";
        sha1 = "5281770f68e0c9719e5163fd3fab482215f4fda5";
      };
    }

    {
      name = "request-2.81.0.tgz";
      path = fetchurl {
        name = "request-2.81.0.tgz";
        url  = "https://registry.yarnpkg.com/request/-/request-2.81.0.tgz";
        sha1 = "c6928946a0e06c5f8d6f8a9333469ffda46298a0";
      };
    }

    {
      name = "request-2.87.0.tgz";
      path = fetchurl {
        name = "request-2.87.0.tgz";
        url  = "https://registry.yarnpkg.com/request/-/request-2.87.0.tgz";
        sha1 = "32f00235cd08d482b4d0d68db93a829c0ed5756e";
      };
    }

    {
      name = "require-coercible-to-string-x-1.0.2.tgz";
      path = fetchurl {
        name = "require-coercible-to-string-x-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/require-coercible-to-string-x/-/require-coercible-to-string-x-1.0.2.tgz";
        sha1 = "b8c96ab42962ab7b28f3311fc6b198124c56f9f6";
      };
    }

    {
      name = "require-directory-2.1.1.tgz";
      path = fetchurl {
        name = "require-directory-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/require-directory/-/require-directory-2.1.1.tgz";
        sha1 = "8c64ad5fd30dab1c976e2344ffe7f792a6a6df42";
      };
    }

    {
      name = "require-from-string-1.2.1.tgz";
      path = fetchurl {
        name = "require-from-string-1.2.1.tgz";
        url  = "https://registry.yarnpkg.com/require-from-string/-/require-from-string-1.2.1.tgz";
        sha1 = "529c9ccef27380adfec9a2f965b649bbee636418";
      };
    }

    {
      name = "require-from-string-2.0.2.tgz";
      path = fetchurl {
        name = "require-from-string-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/require-from-string/-/require-from-string-2.0.2.tgz";
        sha1 = "89a7fdd938261267318eafe14f9c32e598c36909";
      };
    }

    {
      name = "require-main-filename-1.0.1.tgz";
      path = fetchurl {
        name = "require-main-filename-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/require-main-filename/-/require-main-filename-1.0.1.tgz";
        sha1 = "97f717b69d48784f5f526a6c5aa8ffdda055a4d1";
      };
    }

    {
      name = "require-object-coercible-x-1.4.3.tgz";
      path = fetchurl {
        name = "require-object-coercible-x-1.4.3.tgz";
        url  = "https://registry.yarnpkg.com/require-object-coercible-x/-/require-object-coercible-x-1.4.3.tgz";
        sha1 = "783719a23a5c0ce24e845fcc50cd55b6421ea4bb";
      };
    }

    {
      name = "require-relative-0.8.7.tgz";
      path = fetchurl {
        name = "require-relative-0.8.7.tgz";
        url  = "https://registry.yarnpkg.com/require-relative/-/require-relative-0.8.7.tgz";
        sha1 = "7999539fc9e047a37928fa196f8e1563dabd36de";
      };
    }

    {
      name = "require-uncached-1.0.3.tgz";
      path = fetchurl {
        name = "require-uncached-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/require-uncached/-/require-uncached-1.0.3.tgz";
        sha1 = "4e0d56d6c9662fd31e43011c4b95aa49955421d3";
      };
    }

    {
      name = "requires-port-1.0.0.tgz";
      path = fetchurl {
        name = "requires-port-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/requires-port/-/requires-port-1.0.0.tgz";
        sha1 = "925d2601d39ac485e091cf0da5c6e694dc3dcaff";
      };
    }

    {
      name = "requizzle-0.2.1.tgz";
      path = fetchurl {
        name = "requizzle-0.2.1.tgz";
        url  = "https://registry.yarnpkg.com/requizzle/-/requizzle-0.2.1.tgz";
        sha1 = "6943c3530c4d9a7e46f1cddd51c158fc670cdbde";
      };
    }

    {
      name = "reselect-3.0.1.tgz";
      path = fetchurl {
        name = "reselect-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/reselect/-/reselect-3.0.1.tgz";
        sha1 = "efdaa98ea7451324d092b2b2163a6a1d7a9a2147";
      };
    }

    {
      name = "resolve-cwd-1.0.0.tgz";
      path = fetchurl {
        name = "resolve-cwd-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/resolve-cwd/-/resolve-cwd-1.0.0.tgz";
        sha1 = "4eaeea41ed040d1702457df64a42b2b07d246f9f";
      };
    }

    {
      name = "resolve-cwd-2.0.0.tgz";
      path = fetchurl {
        name = "resolve-cwd-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/resolve-cwd/-/resolve-cwd-2.0.0.tgz";
        sha1 = "00a9f7387556e27038eae232caa372a6a59b665a";
      };
    }

    {
      name = "resolve-dir-1.0.1.tgz";
      path = fetchurl {
        name = "resolve-dir-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/resolve-dir/-/resolve-dir-1.0.1.tgz";
        sha1 = "79a40644c362be82f26effe739c9bb5382046f43";
      };
    }

    {
      name = "resolve-from-1.0.1.tgz";
      path = fetchurl {
        name = "resolve-from-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/resolve-from/-/resolve-from-1.0.1.tgz";
        sha1 = "26cbfe935d1aeeeabb29bc3fe5aeb01e93d44226";
      };
    }

    {
      name = "resolve-from-2.0.0.tgz";
      path = fetchurl {
        name = "resolve-from-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/resolve-from/-/resolve-from-2.0.0.tgz";
        sha1 = "9480ab20e94ffa1d9e80a804c7ea147611966b57";
      };
    }

    {
      name = "resolve-from-3.0.0.tgz";
      path = fetchurl {
        name = "resolve-from-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/resolve-from/-/resolve-from-3.0.0.tgz";
        sha1 = "b22c7af7d9d6881bc8b6e653335eebcb0a188748";
      };
    }

    {
      name = "resolve-from-4.0.0.tgz";
      path = fetchurl {
        name = "resolve-from-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/resolve-from/-/resolve-from-4.0.0.tgz";
        sha1 = "4abcd852ad32dd7baabfe9b40e00a36db5f392e6";
      };
    }

    {
      name = "resolve-pathname-2.2.0.tgz";
      path = fetchurl {
        name = "resolve-pathname-2.2.0.tgz";
        url  = "https://registry.yarnpkg.com/resolve-pathname/-/resolve-pathname-2.2.0.tgz";
        sha1 = "7e9ae21ed815fd63ab189adeee64dc831eefa879";
      };
    }

    {
      name = "resolve-url-0.2.1.tgz";
      path = fetchurl {
        name = "resolve-url-0.2.1.tgz";
        url  = "https://registry.yarnpkg.com/resolve-url/-/resolve-url-0.2.1.tgz";
        sha1 = "2c637fe77c893afd2a663fe21aa9080068e2052a";
      };
    }

    {
      name = "resolve-1.1.7.tgz";
      path = fetchurl {
        name = "resolve-1.1.7.tgz";
        url  = "https://registry.yarnpkg.com/resolve/-/resolve-1.1.7.tgz";
        sha1 = "203114d82ad2c5ed9e8e0411b3932875e889e97b";
      };
    }

    {
      name = "resolve-1.8.1.tgz";
      path = fetchurl {
        name = "resolve-1.8.1.tgz";
        url  = "https://registry.yarnpkg.com/resolve/-/resolve-1.8.1.tgz";
        sha1 = "82f1ec19a423ac1fbd080b0bab06ba36e84a7a26";
      };
    }

    {
      name = "restore-cursor-1.0.1.tgz";
      path = fetchurl {
        name = "restore-cursor-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/restore-cursor/-/restore-cursor-1.0.1.tgz";
        sha1 = "34661f46886327fed2991479152252df92daa541";
      };
    }

    {
      name = "restore-cursor-2.0.0.tgz";
      path = fetchurl {
        name = "restore-cursor-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/restore-cursor/-/restore-cursor-2.0.0.tgz";
        sha1 = "9f7ee287f82fd326d4fd162923d62129eee0dfaf";
      };
    }

    {
      name = "ret-0.1.15.tgz";
      path = fetchurl {
        name = "ret-0.1.15.tgz";
        url  = "https://registry.yarnpkg.com/ret/-/ret-0.1.15.tgz";
        sha1 = "b8a4825d5bdb1fc3f6f53c2bc33f81388681c7bc";
      };
    }

    {
      name = "revalidator-0.1.8.tgz";
      path = fetchurl {
        name = "revalidator-0.1.8.tgz";
        url  = "https://registry.yarnpkg.com/revalidator/-/revalidator-0.1.8.tgz";
        sha1 = "fece61bfa0c1b52a206bd6b18198184bdd523a3b";
      };
    }

    {
      name = "right-align-0.1.3.tgz";
      path = fetchurl {
        name = "right-align-0.1.3.tgz";
        url  = "https://registry.yarnpkg.com/right-align/-/right-align-0.1.3.tgz";
        sha1 = "61339b722fe6a3515689210d24e14c96148613ef";
      };
    }

    {
      name = "rimraf-2.6.2.tgz";
      path = fetchurl {
        name = "rimraf-2.6.2.tgz";
        url  = "https://registry.yarnpkg.com/rimraf/-/rimraf-2.6.2.tgz";
        sha1 = "2ed8150d24a16ea8651e6d6ef0f47c4158ce7a36";
      };
    }

    {
      name = "rimraf-2.2.8.tgz";
      path = fetchurl {
        name = "rimraf-2.2.8.tgz";
        url  = "https://registry.yarnpkg.com/rimraf/-/rimraf-2.2.8.tgz";
        sha1 = "e439be2aaee327321952730f99a8929e4fc50582";
      };
    }

    {
      name = "ripemd160-2.0.2.tgz";
      path = fetchurl {
        name = "ripemd160-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/ripemd160/-/ripemd160-2.0.2.tgz";
        sha1 = "a1c1a6f624751577ba5d07914cbc92850585890c";
      };
    }

    {
      name = "rst-selector-parser-2.2.3.tgz";
      path = fetchurl {
        name = "rst-selector-parser-2.2.3.tgz";
        url  = "https://registry.yarnpkg.com/rst-selector-parser/-/rst-selector-parser-2.2.3.tgz";
        sha1 = "81b230ea2fcc6066c89e3472de794285d9b03d91";
      };
    }

    {
      name = "rsvp-3.6.2.tgz";
      path = fetchurl {
        name = "rsvp-3.6.2.tgz";
        url  = "https://registry.yarnpkg.com/rsvp/-/rsvp-3.6.2.tgz";
        sha1 = "2e96491599a96cde1b515d5674a8f7a91452926a";
      };
    }

    {
      name = "run-async-0.1.0.tgz";
      path = fetchurl {
        name = "run-async-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/run-async/-/run-async-0.1.0.tgz";
        sha1 = "c8ad4a5e110661e402a7d21b530e009f25f8e389";
      };
    }

    {
      name = "run-async-2.3.0.tgz";
      path = fetchurl {
        name = "run-async-2.3.0.tgz";
        url  = "https://registry.yarnpkg.com/run-async/-/run-async-2.3.0.tgz";
        sha1 = "0371ab4ae0bdd720d4166d7dfda64ff7a445a6c0";
      };
    }

    {
      name = "run-parallel-1.1.9.tgz";
      path = fetchurl {
        name = "run-parallel-1.1.9.tgz";
        url  = "https://registry.yarnpkg.com/run-parallel/-/run-parallel-1.1.9.tgz";
        sha1 = "c9dd3a7cf9f4b2c4b6244e173a6ed866e61dd679";
      };
    }

    {
      name = "run-queue-1.0.3.tgz";
      path = fetchurl {
        name = "run-queue-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/run-queue/-/run-queue-1.0.3.tgz";
        sha1 = "e848396f057d223f24386924618e25694161ec47";
      };
    }

    {
      name = "rx-lite-aggregates-4.0.8.tgz";
      path = fetchurl {
        name = "rx-lite-aggregates-4.0.8.tgz";
        url  = "https://registry.yarnpkg.com/rx-lite-aggregates/-/rx-lite-aggregates-4.0.8.tgz";
        sha1 = "753b87a89a11c95467c4ac1626c4efc4e05c67be";
      };
    }

    {
      name = "rx-lite-4.0.8.tgz";
      path = fetchurl {
        name = "rx-lite-4.0.8.tgz";
        url  = "https://registry.yarnpkg.com/rx-lite/-/rx-lite-4.0.8.tgz";
        sha1 = "0b1e11af8bc44836f04a6407e92da42467b79444";
      };
    }

    {
      name = "rx-lite-3.1.2.tgz";
      path = fetchurl {
        name = "rx-lite-3.1.2.tgz";
        url  = "https://registry.yarnpkg.com/rx-lite/-/rx-lite-3.1.2.tgz";
        sha1 = "19ce502ca572665f3b647b10939f97fd1615f102";
      };
    }

    {
      name = "rxjs-5.5.11.tgz";
      path = fetchurl {
        name = "rxjs-5.5.11.tgz";
        url  = "https://registry.yarnpkg.com/rxjs/-/rxjs-5.5.11.tgz";
        sha1 = "f733027ca43e3bec6b994473be4ab98ad43ced87";
      };
    }

    {
      name = "safe-buffer-5.1.1.tgz";
      path = fetchurl {
        name = "safe-buffer-5.1.1.tgz";
        url  = "https://registry.yarnpkg.com/safe-buffer/-/safe-buffer-5.1.1.tgz";
        sha1 = "893312af69b2123def71f57889001671eeb2c853";
      };
    }

    {
      name = "safe-buffer-5.1.2.tgz";
      path = fetchurl {
        name = "safe-buffer-5.1.2.tgz";
        url  = "https://registry.yarnpkg.com/safe-buffer/-/safe-buffer-5.1.2.tgz";
        sha1 = "991ec69d296e0313747d59bdfd2b745c35f8828d";
      };
    }

    {
      name = "safe-regex-1.1.0.tgz";
      path = fetchurl {
        name = "safe-regex-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/safe-regex/-/safe-regex-1.1.0.tgz";
        sha1 = "40a3669f3b077d1e943d44629e157dd48023bf2e";
      };
    }

    {
      name = "safer-buffer-2.1.2.tgz";
      path = fetchurl {
        name = "safer-buffer-2.1.2.tgz";
        url  = "https://registry.yarnpkg.com/safer-buffer/-/safer-buffer-2.1.2.tgz";
        sha1 = "44fa161b0187b9549dd84bb91802f9bd8385cd6a";
      };
    }

    {
      name = "samsam-1.1.2.tgz";
      path = fetchurl {
        name = "samsam-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/samsam/-/samsam-1.1.2.tgz";
        sha1 = "bec11fdc83a9fda063401210e40176c3024d1567";
      };
    }

    {
      name = "samsam-1.3.0.tgz";
      path = fetchurl {
        name = "samsam-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/samsam/-/samsam-1.3.0.tgz";
        sha1 = "8d1d9350e25622da30de3e44ba692b5221ab7c50";
      };
    }

    {
      name = "samsam-1.1.3.tgz";
      path = fetchurl {
        name = "samsam-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/samsam/-/samsam-1.1.3.tgz";
        sha1 = "9f5087419b4d091f232571e7fa52e90b0f552621";
      };
    }

    {
      name = "sane-2.5.2.tgz";
      path = fetchurl {
        name = "sane-2.5.2.tgz";
        url  = "https://registry.yarnpkg.com/sane/-/sane-2.5.2.tgz";
        sha1 = "b4dc1861c21b427e929507a3e751e2a2cb8ab3fa";
      };
    }

    {
      name = "sane-1.4.1.tgz";
      path = fetchurl {
        name = "sane-1.4.1.tgz";
        url  = "https://registry.yarnpkg.com/sane/-/sane-1.4.1.tgz";
        sha1 = "88f763d74040f5f0c256b6163db399bf110ac715";
      };
    }

    {
      name = "sane-1.6.0.tgz";
      path = fetchurl {
        name = "sane-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/sane/-/sane-1.6.0.tgz";
        sha1 = "9610c452307a135d29c1fdfe2547034180c46775";
      };
    }

    {
      name = "sanitize-filename-1.6.1.tgz";
      path = fetchurl {
        name = "sanitize-filename-1.6.1.tgz";
        url  = "https://registry.yarnpkg.com/sanitize-filename/-/sanitize-filename-1.6.1.tgz";
        sha1 = "612da1c96473fa02dccda92dcd5b4ab164a6772a";
      };
    }

    {
      name = "sass-graph-2.2.4.tgz";
      path = fetchurl {
        name = "sass-graph-2.2.4.tgz";
        url  = "https://registry.yarnpkg.com/sass-graph/-/sass-graph-2.2.4.tgz";
        sha1 = "13fbd63cd1caf0908b9fd93476ad43a51d1e0b49";
      };
    }

    {
      name = "sass-loader-6.0.7.tgz";
      path = fetchurl {
        name = "sass-loader-6.0.7.tgz";
        url  = "https://registry.yarnpkg.com/sass-loader/-/sass-loader-6.0.7.tgz";
        sha1 = "dd2fdb3e7eeff4a53f35ba6ac408715488353d00";
      };
    }

    {
      name = "sax-1.2.4.tgz";
      path = fetchurl {
        name = "sax-1.2.4.tgz";
        url  = "https://registry.yarnpkg.com/sax/-/sax-1.2.4.tgz";
        sha1 = "2816234e2378bddc4e5354fab5caa895df7100d9";
      };
    }

    {
      name = "schema-utils-0.3.0.tgz";
      path = fetchurl {
        name = "schema-utils-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/schema-utils/-/schema-utils-0.3.0.tgz";
        sha1 = "f5877222ce3e931edae039f17eb3716e7137f8cf";
      };
    }

    {
      name = "schema-utils-0.4.5.tgz";
      path = fetchurl {
        name = "schema-utils-0.4.5.tgz";
        url  = "https://registry.yarnpkg.com/schema-utils/-/schema-utils-0.4.5.tgz";
        sha1 = "21836f0608aac17b78f9e3e24daff14a5ca13a3e";
      };
    }

    {
      name = "script-loader-0.7.2.tgz";
      path = fetchurl {
        name = "script-loader-0.7.2.tgz";
        url  = "https://registry.yarnpkg.com/script-loader/-/script-loader-0.7.2.tgz";
        sha1 = "2016db6f86f25f5cf56da38915d83378bb166ba7";
      };
    }

    {
      name = "scss-tokenizer-0.2.3.tgz";
      path = fetchurl {
        name = "scss-tokenizer-0.2.3.tgz";
        url  = "https://registry.yarnpkg.com/scss-tokenizer/-/scss-tokenizer-0.2.3.tgz";
        sha1 = "8eb06db9a9723333824d3f5530641149847ce5d1";
      };
    }

    {
      name = "select-hose-2.0.0.tgz";
      path = fetchurl {
        name = "select-hose-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/select-hose/-/select-hose-2.0.0.tgz";
        sha1 = "625d8658f865af43ec962bfc376a37359a4994ca";
      };
    }

    {
      name = "selfsigned-1.10.3.tgz";
      path = fetchurl {
        name = "selfsigned-1.10.3.tgz";
        url  = "https://registry.yarnpkg.com/selfsigned/-/selfsigned-1.10.3.tgz";
        sha1 = "d628ecf9e3735f84e8bafba936b3cf85bea43823";
      };
    }

    {
      name = "semver-utils-1.1.2.tgz";
      path = fetchurl {
        name = "semver-utils-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/semver-utils/-/semver-utils-1.1.2.tgz";
        sha1 = "197d758a0a28c3d3a009338cfbcc1211bccd76d4";
      };
    }

    {
      name = "semver-5.5.0.tgz";
      path = fetchurl {
        name = "semver-5.5.0.tgz";
        url  = "https://registry.yarnpkg.com/semver/-/semver-5.5.0.tgz";
        sha1 = "dc4bbc7a6ca9d916dee5d43516f0092b58f7b8ab";
      };
    }

    {
      name = "semver-4.3.2.tgz";
      path = fetchurl {
        name = "semver-4.3.2.tgz";
        url  = "https://registry.yarnpkg.com/semver/-/semver-4.3.2.tgz";
        sha1 = "c7a07158a80bedd052355b770d82d6640f803be7";
      };
    }

    {
      name = "semver-5.3.0.tgz";
      path = fetchurl {
        name = "semver-5.3.0.tgz";
        url  = "https://registry.yarnpkg.com/semver/-/semver-5.3.0.tgz";
        sha1 = "9b2ce5d3de02d17c6012ad326aa6b4d0cf54f94f";
      };
    }

    {
      name = "send-0.16.2.tgz";
      path = fetchurl {
        name = "send-0.16.2.tgz";
        url  = "https://registry.yarnpkg.com/send/-/send-0.16.2.tgz";
        sha1 = "6ecca1e0f8c156d141597559848df64730a6bbc1";
      };
    }

    {
      name = "serialize-javascript-1.5.0.tgz";
      path = fetchurl {
        name = "serialize-javascript-1.5.0.tgz";
        url  = "https://registry.yarnpkg.com/serialize-javascript/-/serialize-javascript-1.5.0.tgz";
        sha1 = "1aa336162c88a890ddad5384baebc93a655161fe";
      };
    }

    {
      name = "serve-index-1.9.1.tgz";
      path = fetchurl {
        name = "serve-index-1.9.1.tgz";
        url  = "https://registry.yarnpkg.com/serve-index/-/serve-index-1.9.1.tgz";
        sha1 = "d3768d69b1e7d82e5ce050fff5b453bea12a9239";
      };
    }

    {
      name = "serve-static-1.13.2.tgz";
      path = fetchurl {
        name = "serve-static-1.13.2.tgz";
        url  = "https://registry.yarnpkg.com/serve-static/-/serve-static-1.13.2.tgz";
        sha1 = "095e8472fd5b46237db50ce486a43f4b86c6cec1";
      };
    }

    {
      name = "set-blocking-2.0.0.tgz";
      path = fetchurl {
        name = "set-blocking-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/set-blocking/-/set-blocking-2.0.0.tgz";
        sha1 = "045f9782d011ae9a6803ddd382b24392b3d890f7";
      };
    }

    {
      name = "set-immediate-shim-1.0.1.tgz";
      path = fetchurl {
        name = "set-immediate-shim-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/set-immediate-shim/-/set-immediate-shim-1.0.1.tgz";
        sha1 = "4b2b1b27eb808a9f8dcc481a58e5e56f599f3f61";
      };
    }

    {
      name = "set-value-0.4.3.tgz";
      path = fetchurl {
        name = "set-value-0.4.3.tgz";
        url  = "https://registry.yarnpkg.com/set-value/-/set-value-0.4.3.tgz";
        sha1 = "7db08f9d3d22dc7f78e53af3c3bf4666ecdfccf1";
      };
    }

    {
      name = "set-value-2.0.0.tgz";
      path = fetchurl {
        name = "set-value-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/set-value/-/set-value-2.0.0.tgz";
        sha1 = "71ae4a88f0feefbbf52d1ea604f3fb315ebb6274";
      };
    }

    {
      name = "setimmediate-1.0.5.tgz";
      path = fetchurl {
        name = "setimmediate-1.0.5.tgz";
        url  = "https://registry.yarnpkg.com/setimmediate/-/setimmediate-1.0.5.tgz";
        sha1 = "290cbb232e306942d7d7ea9b83732ab7856f8285";
      };
    }

    {
      name = "setprototypeof-1.0.3.tgz";
      path = fetchurl {
        name = "setprototypeof-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/setprototypeof/-/setprototypeof-1.0.3.tgz";
        sha1 = "66567e37043eeb4f04d91bd658c0cbefb55b8e04";
      };
    }

    {
      name = "setprototypeof-1.1.0.tgz";
      path = fetchurl {
        name = "setprototypeof-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/setprototypeof/-/setprototypeof-1.1.0.tgz";
        sha1 = "d0bd85536887b6fe7c0d818cb962d9d91c54e656";
      };
    }

    {
      name = "sha.js-2.4.11.tgz";
      path = fetchurl {
        name = "sha.js-2.4.11.tgz";
        url  = "https://registry.yarnpkg.com/sha.js/-/sha.js-2.4.11.tgz";
        sha1 = "37a5cf0b81ecbc6943de109ba2960d1b26584ae7";
      };
    }

    {
      name = "shallow-clone-1.0.0.tgz";
      path = fetchurl {
        name = "shallow-clone-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/shallow-clone/-/shallow-clone-1.0.0.tgz";
        sha1 = "4480cd06e882ef68b2ad88a3ea54832e2c48b571";
      };
    }

    {
      name = "shebang-command-1.2.0.tgz";
      path = fetchurl {
        name = "shebang-command-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/shebang-command/-/shebang-command-1.2.0.tgz";
        sha1 = "44aac65b695b03398968c39f363fee5deafdf1ea";
      };
    }

    {
      name = "shebang-regex-1.0.0.tgz";
      path = fetchurl {
        name = "shebang-regex-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/shebang-regex/-/shebang-regex-1.0.0.tgz";
        sha1 = "da42f49740c0b42db2ca9728571cb190c98efea3";
      };
    }

    {
      name = "shell-quote-1.6.1.tgz";
      path = fetchurl {
        name = "shell-quote-1.6.1.tgz";
        url  = "https://registry.yarnpkg.com/shell-quote/-/shell-quote-1.6.1.tgz";
        sha1 = "f4781949cce402697127430ea3b3c5476f481767";
      };
    }

    {
      name = "shelljs-0.7.8.tgz";
      path = fetchurl {
        name = "shelljs-0.7.8.tgz";
        url  = "https://registry.yarnpkg.com/shelljs/-/shelljs-0.7.8.tgz";
        sha1 = "decbcf874b0d1e5fb72e14b164a9683048e9acb3";
      };
    }

    {
      name = "shellwords-0.1.1.tgz";
      path = fetchurl {
        name = "shellwords-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/shellwords/-/shellwords-0.1.1.tgz";
        sha1 = "d6b9181c1a48d397324c84871efbcfc73fc0654b";
      };
    }

    {
      name = "shortid-2.2.11.tgz";
      path = fetchurl {
        name = "shortid-2.2.11.tgz";
        url  = "https://registry.yarnpkg.com/shortid/-/shortid-2.2.11.tgz";
        sha1 = "a77896f086b0dae7fce1237e29232d2aeef5738e";
      };
    }

    {
      name = "signal-exit-3.0.2.tgz";
      path = fetchurl {
        name = "signal-exit-3.0.2.tgz";
        url  = "https://registry.yarnpkg.com/signal-exit/-/signal-exit-3.0.2.tgz";
        sha1 = "b5fdc08f1287ea1178628e415e25132b73646c6d";
      };
    }

    {
      name = "sinon-as-promised-4.0.3.tgz";
      path = fetchurl {
        name = "sinon-as-promised-4.0.3.tgz";
        url  = "https://registry.yarnpkg.com/sinon-as-promised/-/sinon-as-promised-4.0.3.tgz";
        sha1 = "c0545b1685fd813588a4ed697012487ed11d151b";
      };
    }

    {
      name = "sinon-1.17.7.tgz";
      path = fetchurl {
        name = "sinon-1.17.7.tgz";
        url  = "https://registry.yarnpkg.com/sinon/-/sinon-1.17.7.tgz";
        sha1 = "4542a4f49ba0c45c05eb2e9dd9d203e2b8efe0bf";
      };
    }

    {
      name = "sinon-2.4.1.tgz";
      path = fetchurl {
        name = "sinon-2.4.1.tgz";
        url  = "https://registry.yarnpkg.com/sinon/-/sinon-2.4.1.tgz";
        sha1 = "021fd64b54cb77d9d2fb0d43cdedfae7629c3a36";
      };
    }

    {
      name = "slash-1.0.0.tgz";
      path = fetchurl {
        name = "slash-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/slash/-/slash-1.0.0.tgz";
        sha1 = "c41f2f6c39fc16d1cd17ad4b5d896114ae470d55";
      };
    }

    {
      name = "slice-ansi-0.0.4.tgz";
      path = fetchurl {
        name = "slice-ansi-0.0.4.tgz";
        url  = "https://registry.yarnpkg.com/slice-ansi/-/slice-ansi-0.0.4.tgz";
        sha1 = "edbf8903f66f7ce2f8eafd6ceed65e264c831b35";
      };
    }

    {
      name = "slice-ansi-1.0.0.tgz";
      path = fetchurl {
        name = "slice-ansi-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/slice-ansi/-/slice-ansi-1.0.0.tgz";
        sha1 = "044f1a49d8842ff307aad6b505ed178bd950134d";
      };
    }

    {
      name = "smtp-server-3.4.6.tgz";
      path = fetchurl {
        name = "smtp-server-3.4.6.tgz";
        url  = "https://registry.yarnpkg.com/smtp-server/-/smtp-server-3.4.6.tgz";
        sha1 = "0f2505158ae42846f55bf374cb1a3386cabcf700";
      };
    }

    {
      name = "snapdragon-node-2.1.1.tgz";
      path = fetchurl {
        name = "snapdragon-node-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/snapdragon-node/-/snapdragon-node-2.1.1.tgz";
        sha1 = "6c175f86ff14bdb0724563e8f3c1b021a286853b";
      };
    }

    {
      name = "snapdragon-util-3.0.1.tgz";
      path = fetchurl {
        name = "snapdragon-util-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/snapdragon-util/-/snapdragon-util-3.0.1.tgz";
        sha1 = "f956479486f2acd79700693f6f7b805e45ab56e2";
      };
    }

    {
      name = "snapdragon-0.8.2.tgz";
      path = fetchurl {
        name = "snapdragon-0.8.2.tgz";
        url  = "https://registry.yarnpkg.com/snapdragon/-/snapdragon-0.8.2.tgz";
        sha1 = "64922e7c565b0e14204ba1aa7d6964278d25182d";
      };
    }

    {
      name = "sntp-1.0.9.tgz";
      path = fetchurl {
        name = "sntp-1.0.9.tgz";
        url  = "https://registry.yarnpkg.com/sntp/-/sntp-1.0.9.tgz";
        sha1 = "6541184cc90aeea6c6e7b35e2659082443c66198";
      };
    }

    {
      name = "sockjs-client-1.1.4.tgz";
      path = fetchurl {
        name = "sockjs-client-1.1.4.tgz";
        url  = "https://registry.yarnpkg.com/sockjs-client/-/sockjs-client-1.1.4.tgz";
        sha1 = "5babe386b775e4cf14e7520911452654016c8b12";
      };
    }

    {
      name = "sockjs-0.3.19.tgz";
      path = fetchurl {
        name = "sockjs-0.3.19.tgz";
        url  = "https://registry.yarnpkg.com/sockjs/-/sockjs-0.3.19.tgz";
        sha1 = "d976bbe800af7bd20ae08598d582393508993c0d";
      };
    }

    {
      name = "sort-array-2.0.0.tgz";
      path = fetchurl {
        name = "sort-array-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/sort-array/-/sort-array-2.0.0.tgz";
        sha1 = "38a9c6da27fd7d147b42e60554f281187b4df472";
      };
    }

    {
      name = "sort-keys-1.1.2.tgz";
      path = fetchurl {
        name = "sort-keys-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/sort-keys/-/sort-keys-1.1.2.tgz";
        sha1 = "441b6d4d346798f1b4e49e8920adfba0e543f9ad";
      };
    }

    {
      name = "sort-keys-2.0.0.tgz";
      path = fetchurl {
        name = "sort-keys-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/sort-keys/-/sort-keys-2.0.0.tgz";
        sha1 = "658535584861ec97d730d6cf41822e1f56684128";
      };
    }

    {
      name = "source-list-map-2.0.0.tgz";
      path = fetchurl {
        name = "source-list-map-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/source-list-map/-/source-list-map-2.0.0.tgz";
        sha1 = "aaa47403f7b245a92fbc97ea08f250d6087ed085";
      };
    }

    {
      name = "source-list-map-0.1.8.tgz";
      path = fetchurl {
        name = "source-list-map-0.1.8.tgz";
        url  = "https://registry.yarnpkg.com/source-list-map/-/source-list-map-0.1.8.tgz";
        sha1 = "c550b2ab5427f6b3f21f5afead88c4f5587b2106";
      };
    }

    {
      name = "source-map-resolve-0.3.1.tgz";
      path = fetchurl {
        name = "source-map-resolve-0.3.1.tgz";
        url  = "https://registry.yarnpkg.com/source-map-resolve/-/source-map-resolve-0.3.1.tgz";
        sha1 = "610f6122a445b8dd51535a2a71b783dfc1248761";
      };
    }

    {
      name = "source-map-resolve-0.5.2.tgz";
      path = fetchurl {
        name = "source-map-resolve-0.5.2.tgz";
        url  = "https://registry.yarnpkg.com/source-map-resolve/-/source-map-resolve-0.5.2.tgz";
        sha1 = "72e2cc34095543e43b2c62b2c4c10d4a9054f259";
      };
    }

    {
      name = "source-map-support-0.4.18.tgz";
      path = fetchurl {
        name = "source-map-support-0.4.18.tgz";
        url  = "https://registry.yarnpkg.com/source-map-support/-/source-map-support-0.4.18.tgz";
        sha1 = "0286a6de8be42641338594e97ccea75f0a2c585f";
      };
    }

    {
      name = "source-map-support-0.5.6.tgz";
      path = fetchurl {
        name = "source-map-support-0.5.6.tgz";
        url  = "https://registry.yarnpkg.com/source-map-support/-/source-map-support-0.5.6.tgz";
        sha1 = "4435cee46b1aab62b8e8610ce60f788091c51c13";
      };
    }

    {
      name = "source-map-url-0.4.0.tgz";
      path = fetchurl {
        name = "source-map-url-0.4.0.tgz";
        url  = "https://registry.yarnpkg.com/source-map-url/-/source-map-url-0.4.0.tgz";
        sha1 = "3e935d7ddd73631b97659956d55128e87b5084a3";
      };
    }

    {
      name = "source-map-url-0.3.0.tgz";
      path = fetchurl {
        name = "source-map-url-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/source-map-url/-/source-map-url-0.3.0.tgz";
        sha1 = "7ecaf13b57bcd09da8a40c5d269db33799d4aaf9";
      };
    }

    {
      name = "source-map-0.5.6.tgz";
      path = fetchurl {
        name = "source-map-0.5.6.tgz";
        url  = "https://registry.yarnpkg.com/source-map/-/source-map-0.5.6.tgz";
        sha1 = "75ce38f52bf0733c5a7f0c118d81334a2bb5f412";
      };
    }

    {
      name = "source-map-0.5.7.tgz";
      path = fetchurl {
        name = "source-map-0.5.7.tgz";
        url  = "https://registry.yarnpkg.com/source-map/-/source-map-0.5.7.tgz";
        sha1 = "8a039d2d1021d22d1ea14c80d8ea468ba2ef3fcc";
      };
    }

    {
      name = "source-map-0.1.43.tgz";
      path = fetchurl {
        name = "source-map-0.1.43.tgz";
        url  = "https://registry.yarnpkg.com/source-map/-/source-map-0.1.43.tgz";
        sha1 = "c24bc146ca517c1471f5dacbe2571b2b7f9e3346";
      };
    }

    {
      name = "source-map-0.4.4.tgz";
      path = fetchurl {
        name = "source-map-0.4.4.tgz";
        url  = "https://registry.yarnpkg.com/source-map/-/source-map-0.4.4.tgz";
        sha1 = "eba4f5da9c0dc999de68032d8b4f76173652036b";
      };
    }

    {
      name = "source-map-0.6.1.tgz";
      path = fetchurl {
        name = "source-map-0.6.1.tgz";
        url  = "https://registry.yarnpkg.com/source-map/-/source-map-0.6.1.tgz";
        sha1 = "74722af32e9614e9c287a8d0bbde48b5e2f1a263";
      };
    }

    {
      name = "sourcemapped-stacktrace-1.1.8.tgz";
      path = fetchurl {
        name = "sourcemapped-stacktrace-1.1.8.tgz";
        url  = "https://registry.yarnpkg.com/sourcemapped-stacktrace/-/sourcemapped-stacktrace-1.1.8.tgz";
        sha1 = "6b7a3f1a6fb15f6d40e701e23ce404553480d688";
      };
    }

    {
      name = "spark-md5-3.0.0.tgz";
      path = fetchurl {
        name = "spark-md5-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/spark-md5/-/spark-md5-3.0.0.tgz";
        sha1 = "3722227c54e2faf24b1dc6d933cc144e6f71bfef";
      };
    }

    {
      name = "sparkles-1.0.1.tgz";
      path = fetchurl {
        name = "sparkles-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/sparkles/-/sparkles-1.0.1.tgz";
        sha1 = "008db65edce6c50eec0c5e228e1945061dd0437c";
      };
    }

    {
      name = "spdx-correct-3.0.0.tgz";
      path = fetchurl {
        name = "spdx-correct-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/spdx-correct/-/spdx-correct-3.0.0.tgz";
        sha1 = "05a5b4d7153a195bc92c3c425b69f3b2a9524c82";
      };
    }

    {
      name = "spdx-exceptions-2.1.0.tgz";
      path = fetchurl {
        name = "spdx-exceptions-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/spdx-exceptions/-/spdx-exceptions-2.1.0.tgz";
        sha1 = "2c7ae61056c714a5b9b9b2b2af7d311ef5c78fe9";
      };
    }

    {
      name = "spdx-expression-parse-3.0.0.tgz";
      path = fetchurl {
        name = "spdx-expression-parse-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/spdx-expression-parse/-/spdx-expression-parse-3.0.0.tgz";
        sha1 = "99e119b7a5da00e05491c9fa338b7904823b41d0";
      };
    }

    {
      name = "spdx-license-ids-3.0.0.tgz";
      path = fetchurl {
        name = "spdx-license-ids-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/spdx-license-ids/-/spdx-license-ids-3.0.0.tgz";
        sha1 = "7a7cd28470cc6d3a1cfe6d66886f6bc430d3ac87";
      };
    }

    {
      name = "spdy-transport-2.1.0.tgz";
      path = fetchurl {
        name = "spdy-transport-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/spdy-transport/-/spdy-transport-2.1.0.tgz";
        sha1 = "4bbb15aaffed0beefdd56ad61dbdc8ba3e2cb7a1";
      };
    }

    {
      name = "spdy-3.4.7.tgz";
      path = fetchurl {
        name = "spdy-3.4.7.tgz";
        url  = "https://registry.yarnpkg.com/spdy/-/spdy-3.4.7.tgz";
        sha1 = "42ff41ece5cc0f99a3a6c28aabb73f5c3b03acbc";
      };
    }

    {
      name = "specificity-0.3.2.tgz";
      path = fetchurl {
        name = "specificity-0.3.2.tgz";
        url  = "https://registry.yarnpkg.com/specificity/-/specificity-0.3.2.tgz";
        sha1 = "99e6511eceef0f8d9b57924937aac2cb13d13c42";
      };
    }

    {
      name = "split-string-3.1.0.tgz";
      path = fetchurl {
        name = "split-string-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/split-string/-/split-string-3.1.0.tgz";
        sha1 = "7cb09dda3a86585705c64b39a6466038682e8fe2";
      };
    }

    {
      name = "split2-2.2.0.tgz";
      path = fetchurl {
        name = "split2-2.2.0.tgz";
        url  = "https://registry.yarnpkg.com/split2/-/split2-2.2.0.tgz";
        sha1 = "186b2575bcf83e85b7d18465756238ee4ee42493";
      };
    }

    {
      name = "split-1.0.1.tgz";
      path = fetchurl {
        name = "split-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/split/-/split-1.0.1.tgz";
        sha1 = "605bd9be303aa59fb35f9229fbea0ddec9ea07d9";
      };
    }

    {
      name = "sprintf-js-1.0.3.tgz";
      path = fetchurl {
        name = "sprintf-js-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/sprintf-js/-/sprintf-js-1.0.3.tgz";
        sha1 = "04e6926f662895354f3dd015203633b857297e2c";
      };
    }

    {
      name = "sshpk-1.14.2.tgz";
      path = fetchurl {
        name = "sshpk-1.14.2.tgz";
        url  = "https://registry.yarnpkg.com/sshpk/-/sshpk-1.14.2.tgz";
        sha1 = "c6fc61648a3d9c4e764fd3fcdf4ea105e492ba98";
      };
    }

    {
      name = "ssri-5.3.0.tgz";
      path = fetchurl {
        name = "ssri-5.3.0.tgz";
        url  = "https://registry.yarnpkg.com/ssri/-/ssri-5.3.0.tgz";
        sha1 = "ba3872c9c6d33a0704a7d71ff045e5ec48999d06";
      };
    }

    {
      name = "stack-chain-1.3.7.tgz";
      path = fetchurl {
        name = "stack-chain-1.3.7.tgz";
        url  = "https://registry.yarnpkg.com/stack-chain/-/stack-chain-1.3.7.tgz";
        sha1 = "d192c9ff4ea6a22c94c4dd459171e3f00cea1285";
      };
    }

    {
      name = "stack-trace-0.0.10.tgz";
      path = fetchurl {
        name = "stack-trace-0.0.10.tgz";
        url  = "https://registry.yarnpkg.com/stack-trace/-/stack-trace-0.0.10.tgz";
        sha1 = "547c70b347e8d32b4e108ea1a2a159e5fdde19c0";
      };
    }

    {
      name = "stack-utils-1.0.1.tgz";
      path = fetchurl {
        name = "stack-utils-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/stack-utils/-/stack-utils-1.0.1.tgz";
        sha1 = "d4f33ab54e8e38778b0ca5cfd3b3afb12db68620";
      };
    }

    {
      name = "stackframe-0.3.1.tgz";
      path = fetchurl {
        name = "stackframe-0.3.1.tgz";
        url  = "https://registry.yarnpkg.com/stackframe/-/stackframe-0.3.1.tgz";
        sha1 = "33aa84f1177a5548c8935533cbfeb3420975f5a4";
      };
    }

    {
      name = "staged-git-files-0.0.4.tgz";
      path = fetchurl {
        name = "staged-git-files-0.0.4.tgz";
        url  = "https://registry.yarnpkg.com/staged-git-files/-/staged-git-files-0.0.4.tgz";
        sha1 = "d797e1b551ca7a639dec0237dc6eb4bb9be17d35";
      };
    }

    {
      name = "staged-git-files-1.0.0.tgz";
      path = fetchurl {
        name = "staged-git-files-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/staged-git-files/-/staged-git-files-1.0.0.tgz";
        sha1 = "cdb847837c1fcc52c08a872d4883cc0877668a80";
      };
    }

    {
      name = "standard-engine-7.0.0.tgz";
      path = fetchurl {
        name = "standard-engine-7.0.0.tgz";
        url  = "https://registry.yarnpkg.com/standard-engine/-/standard-engine-7.0.0.tgz";
        sha1 = "ebb77b9c8fc2c8165ffa353bd91ba0dff41af690";
      };
    }

    {
      name = "standard-10.0.3.tgz";
      path = fetchurl {
        name = "standard-10.0.3.tgz";
        url  = "https://registry.yarnpkg.com/standard/-/standard-10.0.3.tgz";
        sha1 = "7869bcbf422bdeeaab689a1ffb1fea9677dd50ea";
      };
    }

    {
      name = "state-toggle-1.0.1.tgz";
      path = fetchurl {
        name = "state-toggle-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/state-toggle/-/state-toggle-1.0.1.tgz";
        sha1 = "c3cb0974f40a6a0f8e905b96789eb41afa1cde3a";
      };
    }

    {
      name = "static-extend-0.1.2.tgz";
      path = fetchurl {
        name = "static-extend-0.1.2.tgz";
        url  = "https://registry.yarnpkg.com/static-extend/-/static-extend-0.1.2.tgz";
        sha1 = "60809c39cbff55337226fd5e0b520f341f1fb5c6";
      };
    }

    {
      name = "statuses-1.5.0.tgz";
      path = fetchurl {
        name = "statuses-1.5.0.tgz";
        url  = "https://registry.yarnpkg.com/statuses/-/statuses-1.5.0.tgz";
        sha1 = "161c7dac177659fd9811f43771fa99381478628c";
      };
    }

    {
      name = "statuses-1.4.0.tgz";
      path = fetchurl {
        name = "statuses-1.4.0.tgz";
        url  = "https://registry.yarnpkg.com/statuses/-/statuses-1.4.0.tgz";
        sha1 = "bb73d446da2796106efcc1b601a253d6c46bd087";
      };
    }

    {
      name = "stdout-stream-1.4.0.tgz";
      path = fetchurl {
        name = "stdout-stream-1.4.0.tgz";
        url  = "https://registry.yarnpkg.com/stdout-stream/-/stdout-stream-1.4.0.tgz";
        sha1 = "a2c7c8587e54d9427ea9edb3ac3f2cd522df378b";
      };
    }

    {
      name = "stealthy-require-1.1.1.tgz";
      path = fetchurl {
        name = "stealthy-require-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/stealthy-require/-/stealthy-require-1.1.1.tgz";
        sha1 = "35b09875b4ff49f26a777e509b3090a3226bf24b";
      };
    }

    {
      name = "stream-browserify-2.0.1.tgz";
      path = fetchurl {
        name = "stream-browserify-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/stream-browserify/-/stream-browserify-2.0.1.tgz";
        sha1 = "66266ee5f9bdb9940a4e4514cafb43bb71e5c9db";
      };
    }

    {
      name = "stream-connect-1.0.2.tgz";
      path = fetchurl {
        name = "stream-connect-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/stream-connect/-/stream-connect-1.0.2.tgz";
        sha1 = "18bc81f2edb35b8b5d9a8009200a985314428a97";
      };
    }

    {
      name = "stream-each-1.2.2.tgz";
      path = fetchurl {
        name = "stream-each-1.2.2.tgz";
        url  = "https://registry.yarnpkg.com/stream-each/-/stream-each-1.2.2.tgz";
        sha1 = "8e8c463f91da8991778765873fe4d960d8f616bd";
      };
    }

    {
      name = "stream-http-2.8.3.tgz";
      path = fetchurl {
        name = "stream-http-2.8.3.tgz";
        url  = "https://registry.yarnpkg.com/stream-http/-/stream-http-2.8.3.tgz";
        sha1 = "b2d242469288a5a27ec4fe8933acf623de6514fc";
      };
    }

    {
      name = "stream-shift-1.0.0.tgz";
      path = fetchurl {
        name = "stream-shift-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/stream-shift/-/stream-shift-1.0.0.tgz";
        sha1 = "d5c752825e5367e786f78e18e445ea223a155952";
      };
    }

    {
      name = "stream-to-observable-0.1.0.tgz";
      path = fetchurl {
        name = "stream-to-observable-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/stream-to-observable/-/stream-to-observable-0.1.0.tgz";
        sha1 = "45bf1d9f2d7dc09bed81f1c307c430e68b84cffe";
      };
    }

    {
      name = "stream-to-observable-0.2.0.tgz";
      path = fetchurl {
        name = "stream-to-observable-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/stream-to-observable/-/stream-to-observable-0.2.0.tgz";
        sha1 = "59d6ea393d87c2c0ddac10aa0d561bc6ba6f0e10";
      };
    }

    {
      name = "stream-via-1.0.4.tgz";
      path = fetchurl {
        name = "stream-via-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/stream-via/-/stream-via-1.0.4.tgz";
        sha1 = "8dccbb0ac909328eb8bc8e2a4bd3934afdaf606c";
      };
    }

    {
      name = "streamsearch-0.1.2.tgz";
      path = fetchurl {
        name = "streamsearch-0.1.2.tgz";
        url  = "https://registry.yarnpkg.com/streamsearch/-/streamsearch-0.1.2.tgz";
        sha1 = "808b9d0e56fc273d809ba57338e929919a1a9f1a";
      };
    }

    {
      name = "strict-uri-encode-1.1.0.tgz";
      path = fetchurl {
        name = "strict-uri-encode-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/strict-uri-encode/-/strict-uri-encode-1.1.0.tgz";
        sha1 = "279b225df1d582b1f54e65addd4352e18faa0713";
      };
    }

    {
      name = "string-length-1.0.1.tgz";
      path = fetchurl {
        name = "string-length-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/string-length/-/string-length-1.0.1.tgz";
        sha1 = "56970fb1c38558e9e70b728bf3de269ac45adfac";
      };
    }

    {
      name = "string-length-2.0.0.tgz";
      path = fetchurl {
        name = "string-length-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/string-length/-/string-length-2.0.0.tgz";
        sha1 = "d40dbb686a3ace960c1cffca562bf2c45f8363ed";
      };
    }

    {
      name = "string-replace-loader-1.3.0.tgz";
      path = fetchurl {
        name = "string-replace-loader-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/string-replace-loader/-/string-replace-loader-1.3.0.tgz";
        sha1 = "1d404a7bf5e2ec21b08ffc76d89445fbe49bc01d";
      };
    }

    {
      name = "string-width-1.0.2.tgz";
      path = fetchurl {
        name = "string-width-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/string-width/-/string-width-1.0.2.tgz";
        sha1 = "118bdf5b8cdc51a2a7e70d211e07e2b0b9b107d3";
      };
    }

    {
      name = "string-width-2.1.1.tgz";
      path = fetchurl {
        name = "string-width-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/string-width/-/string-width-2.1.1.tgz";
        sha1 = "ab93f27a8dc13d28cac815c462143a6d9012ae9e";
      };
    }

    {
      name = "string_decoder-1.1.1.tgz";
      path = fetchurl {
        name = "string_decoder-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/string_decoder/-/string_decoder-1.1.1.tgz";
        sha1 = "9cf1611ba62685d7030ae9e4ba34149c3af03fc8";
      };
    }

    {
      name = "string_decoder-0.10.31.tgz";
      path = fetchurl {
        name = "string_decoder-0.10.31.tgz";
        url  = "https://registry.yarnpkg.com/string_decoder/-/string_decoder-0.10.31.tgz";
        sha1 = "62e203bc41766c6c28c9fc84301dab1c5310fa94";
      };
    }

    {
      name = "stringify-entities-1.3.2.tgz";
      path = fetchurl {
        name = "stringify-entities-1.3.2.tgz";
        url  = "https://registry.yarnpkg.com/stringify-entities/-/stringify-entities-1.3.2.tgz";
        sha1 = "a98417e5471fd227b3e45d3db1861c11caf668f7";
      };
    }

    {
      name = "stringify-object-3.2.2.tgz";
      path = fetchurl {
        name = "stringify-object-3.2.2.tgz";
        url  = "https://registry.yarnpkg.com/stringify-object/-/stringify-object-3.2.2.tgz";
        sha1 = "9853052e5a88fb605a44cd27445aa257ad7ffbcd";
      };
    }

    {
      name = "stringstream-0.0.6.tgz";
      path = fetchurl {
        name = "stringstream-0.0.6.tgz";
        url  = "https://registry.yarnpkg.com/stringstream/-/stringstream-0.0.6.tgz";
        sha1 = "7880225b0d4ad10e30927d167a1d6f2fd3b33a72";
      };
    }

    {
      name = "strip-ansi-3.0.1.tgz";
      path = fetchurl {
        name = "strip-ansi-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/strip-ansi/-/strip-ansi-3.0.1.tgz";
        sha1 = "6a385fb8853d952d5ff05d0e8aaf94278dc63dcf";
      };
    }

    {
      name = "strip-ansi-4.0.0.tgz";
      path = fetchurl {
        name = "strip-ansi-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/strip-ansi/-/strip-ansi-4.0.0.tgz";
        sha1 = "a8479022eb1ac368a871389b635262c505ee368f";
      };
    }

    {
      name = "strip-bom-3.0.0.tgz";
      path = fetchurl {
        name = "strip-bom-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/strip-bom/-/strip-bom-3.0.0.tgz";
        sha1 = "2334c18e9c759f7bdd56fdef7e9ae3d588e68ed3";
      };
    }

    {
      name = "strip-bom-2.0.0.tgz";
      path = fetchurl {
        name = "strip-bom-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/strip-bom/-/strip-bom-2.0.0.tgz";
        sha1 = "6219a85616520491f35788bdbf1447a99c7e6b0e";
      };
    }

    {
      name = "strip-eof-1.0.0.tgz";
      path = fetchurl {
        name = "strip-eof-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/strip-eof/-/strip-eof-1.0.0.tgz";
        sha1 = "bb43ff5598a6eb05d89b59fcd129c983313606bf";
      };
    }

    {
      name = "strip-indent-1.0.1.tgz";
      path = fetchurl {
        name = "strip-indent-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/strip-indent/-/strip-indent-1.0.1.tgz";
        sha1 = "0c7962a6adefa7bbd4ac366460a638552ae1a0a2";
      };
    }

    {
      name = "strip-indent-2.0.0.tgz";
      path = fetchurl {
        name = "strip-indent-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/strip-indent/-/strip-indent-2.0.0.tgz";
        sha1 = "5ef8db295d01e6ed6cbf7aab96998d7822527b68";
      };
    }

    {
      name = "strip-json-comments-2.0.1.tgz";
      path = fetchurl {
        name = "strip-json-comments-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/strip-json-comments/-/strip-json-comments-2.0.1.tgz";
        sha1 = "3c531942e908c2697c0ec344858c286c7ca0a60a";
      };
    }

    {
      name = "strong-log-transformer-1.0.6.tgz";
      path = fetchurl {
        name = "strong-log-transformer-1.0.6.tgz";
        url  = "https://registry.yarnpkg.com/strong-log-transformer/-/strong-log-transformer-1.0.6.tgz";
        sha1 = "f7fb93758a69a571140181277eea0c2eb1301fa3";
      };
    }

    {
      name = "style-loader-0.19.1.tgz";
      path = fetchurl {
        name = "style-loader-0.19.1.tgz";
        url  = "https://registry.yarnpkg.com/style-loader/-/style-loader-0.19.1.tgz";
        sha1 = "591ffc80bcefe268b77c5d9ebc0505d772619f85";
      };
    }

    {
      name = "style-loader-0.20.3.tgz";
      path = fetchurl {
        name = "style-loader-0.20.3.tgz";
        url  = "https://registry.yarnpkg.com/style-loader/-/style-loader-0.20.3.tgz";
        sha1 = "ebef06b89dec491bcb1fdb3452e913a6fd1c10c4";
      };
    }

    {
      name = "style-search-0.1.0.tgz";
      path = fetchurl {
        name = "style-search-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/style-search/-/style-search-0.1.0.tgz";
        sha1 = "7958c793e47e32e07d2b5cafe5c0bf8e12e77902";
      };
    }

    {
      name = "styled-components-3.3.3.tgz";
      path = fetchurl {
        name = "styled-components-3.3.3.tgz";
        url  = "https://registry.yarnpkg.com/styled-components/-/styled-components-3.3.3.tgz";
        sha1 = "09e702055ab11f7a8eab8229b1c0d0b855095686";
      };
    }

    {
      name = "styled-normalize-3.0.1.tgz";
      path = fetchurl {
        name = "styled-normalize-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/styled-normalize/-/styled-normalize-3.0.1.tgz";
        sha1 = "217efb96598690addd04699ca71af0db3473fea2";
      };
    }

    {
      name = "stylelint-config-prettier-2.1.0.tgz";
      path = fetchurl {
        name = "stylelint-config-prettier-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/stylelint-config-prettier/-/stylelint-config-prettier-2.1.0.tgz";
        sha1 = "395874225ceef02ea8e31c2f4073098f4505b054";
      };
    }

    {
      name = "stylelint-config-pubsweet-0.0.3.tgz";
      path = fetchurl {
        name = "stylelint-config-pubsweet-0.0.3.tgz";
        url  = "https://registry.yarnpkg.com/stylelint-config-pubsweet/-/stylelint-config-pubsweet-0.0.3.tgz";
        sha1 = "1f2284a5ffca26dcfa6bfee225b6f65bbcb2d2f5";
      };
    }

    {
      name = "stylelint-config-recommended-2.1.0.tgz";
      path = fetchurl {
        name = "stylelint-config-recommended-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/stylelint-config-recommended/-/stylelint-config-recommended-2.1.0.tgz";
        sha1 = "f526d5c771c6811186d9eaedbed02195fee30858";
      };
    }

    {
      name = "stylelint-config-standard-18.2.0.tgz";
      path = fetchurl {
        name = "stylelint-config-standard-18.2.0.tgz";
        url  = "https://registry.yarnpkg.com/stylelint-config-standard/-/stylelint-config-standard-18.2.0.tgz";
        sha1 = "6283149aba7f64f18731aef8f0abfb35cf619e06";
      };
    }

    {
      name = "stylelint-order-0.7.0.tgz";
      path = fetchurl {
        name = "stylelint-order-0.7.0.tgz";
        url  = "https://registry.yarnpkg.com/stylelint-order/-/stylelint-order-0.7.0.tgz";
        sha1 = "ceab5cbe24aa33fa63590024995395f6edfc9ab7";
      };
    }

    {
      name = "stylelint-8.4.0.tgz";
      path = fetchurl {
        name = "stylelint-8.4.0.tgz";
        url  = "https://registry.yarnpkg.com/stylelint/-/stylelint-8.4.0.tgz";
        sha1 = "c2dbaeb17236917819f9206e1c0df5fddf6f83c3";
      };
    }

    {
      name = "stylis-rule-sheet-0.0.10.tgz";
      path = fetchurl {
        name = "stylis-rule-sheet-0.0.10.tgz";
        url  = "https://registry.yarnpkg.com/stylis-rule-sheet/-/stylis-rule-sheet-0.0.10.tgz";
        sha1 = "44e64a2b076643f4b52e5ff71efc04d8c3c4a430";
      };
    }

    {
      name = "stylis-3.5.1.tgz";
      path = fetchurl {
        name = "stylis-3.5.1.tgz";
        url  = "https://registry.yarnpkg.com/stylis/-/stylis-3.5.1.tgz";
        sha1 = "fd341d59f57f9aeb412bc14c9d8a8670b438e03b";
      };
    }

    {
      name = "sublevel-pouchdb-6.4.3.tgz";
      path = fetchurl {
        name = "sublevel-pouchdb-6.4.3.tgz";
        url  = "https://registry.yarnpkg.com/sublevel-pouchdb/-/sublevel-pouchdb-6.4.3.tgz";
        sha1 = "e4eca52d8ac7ba17ff6c18fcdc51f5ecbbb15597";
      };
    }

    {
      name = "substance-1.0.0-beta.6.5.tgz";
      path = fetchurl {
        name = "substance-1.0.0-beta.6.5.tgz";
        url  = "https://registry.yarnpkg.com/substance/-/substance-1.0.0-beta.6.5.tgz";
        sha1 = "0aa591d8e02445c980965c9c3eeb82479f1614ad";
      };
    }

    {
      name = "sugarss-1.0.1.tgz";
      path = fetchurl {
        name = "sugarss-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/sugarss/-/sugarss-1.0.1.tgz";
        sha1 = "be826d9003e0f247735f92365dc3fd7f1bae9e44";
      };
    }

    {
      name = "superagent-2.3.0.tgz";
      path = fetchurl {
        name = "superagent-2.3.0.tgz";
        url  = "https://registry.yarnpkg.com/superagent/-/superagent-2.3.0.tgz";
        sha1 = "703529a0714e57e123959ddefbce193b2e50d115";
      };
    }

    {
      name = "supertest-2.0.1.tgz";
      path = fetchurl {
        name = "supertest-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/supertest/-/supertest-2.0.1.tgz";
        sha1 = "a058081d788f1515d4700d7502881e6b759e44cd";
      };
    }

    {
      name = "supports-color-2.0.0.tgz";
      path = fetchurl {
        name = "supports-color-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/supports-color/-/supports-color-2.0.0.tgz";
        sha1 = "535d045ce6b6363fa40117084629995e9df324c7";
      };
    }

    {
      name = "supports-color-3.2.3.tgz";
      path = fetchurl {
        name = "supports-color-3.2.3.tgz";
        url  = "https://registry.yarnpkg.com/supports-color/-/supports-color-3.2.3.tgz";
        sha1 = "65ac0504b3954171d8a64946b2ae3cbb8a5f54f6";
      };
    }

    {
      name = "supports-color-4.5.0.tgz";
      path = fetchurl {
        name = "supports-color-4.5.0.tgz";
        url  = "https://registry.yarnpkg.com/supports-color/-/supports-color-4.5.0.tgz";
        sha1 = "be7a0de484dec5c5cddf8b3d59125044912f635b";
      };
    }

    {
      name = "supports-color-5.4.0.tgz";
      path = fetchurl {
        name = "supports-color-5.4.0.tgz";
        url  = "https://registry.yarnpkg.com/supports-color/-/supports-color-5.4.0.tgz";
        sha1 = "1c6b337402c2137605efe19f10fec390f6faab54";
      };
    }

    {
      name = "svg-tags-1.0.0.tgz";
      path = fetchurl {
        name = "svg-tags-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/svg-tags/-/svg-tags-1.0.0.tgz";
        sha1 = "58f71cee3bd519b59d4b2a843b6c7de64ac04764";
      };
    }

    {
      name = "svgo-0.7.2.tgz";
      path = fetchurl {
        name = "svgo-0.7.2.tgz";
        url  = "https://registry.yarnpkg.com/svgo/-/svgo-0.7.2.tgz";
        sha1 = "9f5772413952135c6fefbf40afe6a4faa88b4bb5";
      };
    }

    {
      name = "symbol-observable-1.0.1.tgz";
      path = fetchurl {
        name = "symbol-observable-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/symbol-observable/-/symbol-observable-1.0.1.tgz";
        sha1 = "8340fc4702c3122df5d22288f88283f513d3fdd4";
      };
    }

    {
      name = "symbol-observable-0.2.4.tgz";
      path = fetchurl {
        name = "symbol-observable-0.2.4.tgz";
        url  = "https://registry.yarnpkg.com/symbol-observable/-/symbol-observable-0.2.4.tgz";
        sha1 = "95a83db26186d6af7e7a18dbd9760a2f86d08f40";
      };
    }

    {
      name = "symbol-observable-1.2.0.tgz";
      path = fetchurl {
        name = "symbol-observable-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/symbol-observable/-/symbol-observable-1.2.0.tgz";
        sha1 = "c22688aed4eab3cdc2dfeacbb561660560a00804";
      };
    }

    {
      name = "symbol-tree-3.2.2.tgz";
      path = fetchurl {
        name = "symbol-tree-3.2.2.tgz";
        url  = "https://registry.yarnpkg.com/symbol-tree/-/symbol-tree-3.2.2.tgz";
        sha1 = "ae27db38f660a7ae2e1c3b7d1bc290819b8519e6";
      };
    }

    {
      name = "table-layout-0.4.4.tgz";
      path = fetchurl {
        name = "table-layout-0.4.4.tgz";
        url  = "https://registry.yarnpkg.com/table-layout/-/table-layout-0.4.4.tgz";
        sha1 = "bc5398b2a05e58b67b05dd9238354b89ef27be0f";
      };
    }

    {
      name = "table-parser-0.1.3.tgz";
      path = fetchurl {
        name = "table-parser-0.1.3.tgz";
        url  = "https://registry.yarnpkg.com/table-parser/-/table-parser-0.1.3.tgz";
        sha1 = "0441cfce16a59481684c27d1b5a67ff15a43c7b0";
      };
    }

    {
      name = "table-4.0.2.tgz";
      path = fetchurl {
        name = "table-4.0.2.tgz";
        url  = "https://registry.yarnpkg.com/table/-/table-4.0.2.tgz";
        sha1 = "a33447375391e766ad34d3486e6e2aedc84d2e36";
      };
    }

    {
      name = "table-3.8.3.tgz";
      path = fetchurl {
        name = "table-3.8.3.tgz";
        url  = "https://registry.yarnpkg.com/table/-/table-3.8.3.tgz";
        sha1 = "2bbc542f0fda9861a755d3947fefd8b3f513855f";
      };
    }

    {
      name = "table-4.0.3.tgz";
      path = fetchurl {
        name = "table-4.0.3.tgz";
        url  = "https://registry.yarnpkg.com/table/-/table-4.0.3.tgz";
        sha1 = "00b5e2b602f1794b9acaf9ca908a76386a7813bc";
      };
    }

    {
      name = "taffydb-2.6.2.tgz";
      path = fetchurl {
        name = "taffydb-2.6.2.tgz";
        url  = "https://registry.yarnpkg.com/taffydb/-/taffydb-2.6.2.tgz";
        sha1 = "7cbcb64b5a141b6a2efc2c5d2c67b4e150b2a268";
      };
    }

    {
      name = "tapable-0.2.8.tgz";
      path = fetchurl {
        name = "tapable-0.2.8.tgz";
        url  = "https://registry.yarnpkg.com/tapable/-/tapable-0.2.8.tgz";
        sha1 = "99372a5c999bf2df160afc0d74bed4f47948cd22";
      };
    }

    {
      name = "tar-pack-3.4.1.tgz";
      path = fetchurl {
        name = "tar-pack-3.4.1.tgz";
        url  = "https://registry.yarnpkg.com/tar-pack/-/tar-pack-3.4.1.tgz";
        sha1 = "e1dbc03a9b9d3ba07e896ad027317eb679a10a1f";
      };
    }

    {
      name = "tar-stream-1.6.1.tgz";
      path = fetchurl {
        name = "tar-stream-1.6.1.tgz";
        url  = "https://registry.yarnpkg.com/tar-stream/-/tar-stream-1.6.1.tgz";
        sha1 = "f84ef1696269d6223ca48f6e1eeede3f7e81f395";
      };
    }

    {
      name = "tar-2.2.1.tgz";
      path = fetchurl {
        name = "tar-2.2.1.tgz";
        url  = "https://registry.yarnpkg.com/tar/-/tar-2.2.1.tgz";
        sha1 = "8e4d2a256c0e2185c6b18ad694aec968b83cb1d1";
      };
    }

    {
      name = "tar-4.4.4.tgz";
      path = fetchurl {
        name = "tar-4.4.4.tgz";
        url  = "https://registry.yarnpkg.com/tar/-/tar-4.4.4.tgz";
        sha1 = "ec8409fae9f665a4355cc3b4087d0820232bb8cd";
      };
    }

    {
      name = "temp-dir-1.0.0.tgz";
      path = fetchurl {
        name = "temp-dir-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/temp-dir/-/temp-dir-1.0.0.tgz";
        sha1 = "0a7c0ea26d3a39afa7e0ebea9c1fc0bc4daa011d";
      };
    }

    {
      name = "temp-path-1.0.0.tgz";
      path = fetchurl {
        name = "temp-path-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/temp-path/-/temp-path-1.0.0.tgz";
        sha1 = "24b1543973ab442896d9ad367dd9cbdbfafe918b";
      };
    }

    {
      name = "temp-write-3.4.0.tgz";
      path = fetchurl {
        name = "temp-write-3.4.0.tgz";
        url  = "https://registry.yarnpkg.com/temp-write/-/temp-write-3.4.0.tgz";
        sha1 = "8cff630fb7e9da05f047c74ce4ce4d685457d492";
      };
    }

    {
      name = "temp-0.8.3.tgz";
      path = fetchurl {
        name = "temp-0.8.3.tgz";
        url  = "https://registry.yarnpkg.com/temp/-/temp-0.8.3.tgz";
        sha1 = "e0c6bc4d26b903124410e4fed81103014dfc1f59";
      };
    }

    {
      name = "tempfile-1.1.1.tgz";
      path = fetchurl {
        name = "tempfile-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/tempfile/-/tempfile-1.1.1.tgz";
        sha1 = "5bcc4eaecc4ab2c707d8bc11d99ccc9a2cb287f2";
      };
    }

    {
      name = "test-exclude-3.3.0.tgz";
      path = fetchurl {
        name = "test-exclude-3.3.0.tgz";
        url  = "https://registry.yarnpkg.com/test-exclude/-/test-exclude-3.3.0.tgz";
        sha1 = "7a17ca1239988c98367b0621456dbb7d4bc38977";
      };
    }

    {
      name = "test-exclude-4.2.1.tgz";
      path = fetchurl {
        name = "test-exclude-4.2.1.tgz";
        url  = "https://registry.yarnpkg.com/test-exclude/-/test-exclude-4.2.1.tgz";
        sha1 = "dfa222f03480bca69207ca728b37d74b45f724fa";
      };
    }

    {
      name = "test-value-1.1.0.tgz";
      path = fetchurl {
        name = "test-value-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/test-value/-/test-value-1.1.0.tgz";
        sha1 = "a09136f72ec043d27c893707c2b159bfad7de93f";
      };
    }

    {
      name = "test-value-2.1.0.tgz";
      path = fetchurl {
        name = "test-value-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/test-value/-/test-value-2.1.0.tgz";
        sha1 = "11da6ff670f3471a73b625ca4f3fdcf7bb748291";
      };
    }

    {
      name = "test-value-3.0.0.tgz";
      path = fetchurl {
        name = "test-value-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/test-value/-/test-value-3.0.0.tgz";
        sha1 = "9168c062fab11a86b8d444dd968bb4b73851ce92";
      };
    }

    {
      name = "testcafe-browser-tools-1.4.6.tgz";
      path = fetchurl {
        name = "testcafe-browser-tools-1.4.6.tgz";
        url  = "https://registry.yarnpkg.com/testcafe-browser-tools/-/testcafe-browser-tools-1.4.6.tgz";
        sha1 = "58c8ede77beeeecfb844b8cdcc22e61b23e34982";
      };
    }

    {
      name = "testcafe-hammerhead-12.1.6.tgz";
      path = fetchurl {
        name = "testcafe-hammerhead-12.1.6.tgz";
        url  = "https://registry.yarnpkg.com/testcafe-hammerhead/-/testcafe-hammerhead-12.1.6.tgz";
        sha1 = "1a2bece9af57db3413e83f8be32d6a8b191da4a7";
      };
    }

    {
      name = "testcafe-legacy-api-3.1.2.tgz";
      path = fetchurl {
        name = "testcafe-legacy-api-3.1.2.tgz";
        url  = "https://registry.yarnpkg.com/testcafe-legacy-api/-/testcafe-legacy-api-3.1.2.tgz";
        sha1 = "af858ae31030d8c94056a6fd580e64be00a51e81";
      };
    }

    {
      name = "testcafe-react-selectors-1.1.0.tgz";
      path = fetchurl {
        name = "testcafe-react-selectors-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/testcafe-react-selectors/-/testcafe-react-selectors-1.1.0.tgz";
        sha1 = "02ca7d730d86d8956629db55094f4a6464f3db29";
      };
    }

    {
      name = "testcafe-reporter-json-2.1.0.tgz";
      path = fetchurl {
        name = "testcafe-reporter-json-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/testcafe-reporter-json/-/testcafe-reporter-json-2.1.0.tgz";
        sha1 = "80b9b5a6dff2ee1de1f91e2670706c1472e64006";
      };
    }

    {
      name = "testcafe-reporter-list-2.1.0.tgz";
      path = fetchurl {
        name = "testcafe-reporter-list-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/testcafe-reporter-list/-/testcafe-reporter-list-2.1.0.tgz";
        sha1 = "9fa89f71b97d3dfe64b4302d5e227dee69aec6b9";
      };
    }

    {
      name = "testcafe-reporter-minimal-2.1.0.tgz";
      path = fetchurl {
        name = "testcafe-reporter-minimal-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/testcafe-reporter-minimal/-/testcafe-reporter-minimal-2.1.0.tgz";
        sha1 = "676f03547634143c6eaf3ab52868273a4bebf421";
      };
    }

    {
      name = "testcafe-reporter-spec-2.1.1.tgz";
      path = fetchurl {
        name = "testcafe-reporter-spec-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/testcafe-reporter-spec/-/testcafe-reporter-spec-2.1.1.tgz";
        sha1 = "8156fced0f5132486559ad560bc80676469275ec";
      };
    }

    {
      name = "testcafe-reporter-xunit-2.1.0.tgz";
      path = fetchurl {
        name = "testcafe-reporter-xunit-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/testcafe-reporter-xunit/-/testcafe-reporter-xunit-2.1.0.tgz";
        sha1 = "e6d66c572ce15af266706af0fd610b2a841dd443";
      };
    }

    {
      name = "testcafe-0.18.6.tgz";
      path = fetchurl {
        name = "testcafe-0.18.6.tgz";
        url  = "https://registry.yarnpkg.com/testcafe/-/testcafe-0.18.6.tgz";
        sha1 = "7dfd3467e5010c741ebf5e383cd5f82ad39fc5f2";
      };
    }

    {
      name = "text-encoding-0.6.4.tgz";
      path = fetchurl {
        name = "text-encoding-0.6.4.tgz";
        url  = "https://registry.yarnpkg.com/text-encoding/-/text-encoding-0.6.4.tgz";
        sha1 = "e399a982257a276dae428bb92845cb71bdc26d19";
      };
    }

    {
      name = "text-extensions-1.7.0.tgz";
      path = fetchurl {
        name = "text-extensions-1.7.0.tgz";
        url  = "https://registry.yarnpkg.com/text-extensions/-/text-extensions-1.7.0.tgz";
        sha1 = "faaaba2625ed746d568a23e4d0aacd9bf08a8b39";
      };
    }

    {
      name = "text-table-0.2.0.tgz";
      path = fetchurl {
        name = "text-table-0.2.0.tgz";
        url  = "https://registry.yarnpkg.com/text-table/-/text-table-0.2.0.tgz";
        sha1 = "7f5ee823ae805207c00af2df4a84ec3fcfa570b4";
      };
    }

    {
      name = "throat-3.2.0.tgz";
      path = fetchurl {
        name = "throat-3.2.0.tgz";
        url  = "https://registry.yarnpkg.com/throat/-/throat-3.2.0.tgz";
        sha1 = "50cb0670edbc40237b9e347d7e1f88e4620af836";
      };
    }

    {
      name = "throat-4.1.0.tgz";
      path = fetchurl {
        name = "throat-4.1.0.tgz";
        url  = "https://registry.yarnpkg.com/throat/-/throat-4.1.0.tgz";
        sha1 = "89037cbc92c56ab18926e6ba4cbb200e15672a6a";
      };
    }

    {
      name = "through2-2.0.3.tgz";
      path = fetchurl {
        name = "through2-2.0.3.tgz";
        url  = "https://registry.yarnpkg.com/through2/-/through2-2.0.3.tgz";
        sha1 = "0004569b37c7c74ba39c43f3ced78d1ad94140be";
      };
    }

    {
      name = "through-2.3.8.tgz";
      path = fetchurl {
        name = "through-2.3.8.tgz";
        url  = "https://registry.yarnpkg.com/through/-/through-2.3.8.tgz";
        sha1 = "0dd4c9ffaabc357960b1b724115d7e0e86a2e1f5";
      };
    }

    {
      name = "thunky-1.0.2.tgz";
      path = fetchurl {
        name = "thunky-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/thunky/-/thunky-1.0.2.tgz";
        sha1 = "a862e018e3fb1ea2ec3fce5d55605cf57f247371";
      };
    }

    {
      name = "time-limit-promise-1.0.4.tgz";
      path = fetchurl {
        name = "time-limit-promise-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/time-limit-promise/-/time-limit-promise-1.0.4.tgz";
        sha1 = "33e928212273c70d52153c28ad2a7e3319b975f9";
      };
    }

    {
      name = "time-stamp-2.0.0.tgz";
      path = fetchurl {
        name = "time-stamp-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/time-stamp/-/time-stamp-2.0.0.tgz";
        sha1 = "95c6a44530e15ba8d6f4a3ecb8c3a3fac46da357";
      };
    }

    {
      name = "timed-out-4.0.1.tgz";
      path = fetchurl {
        name = "timed-out-4.0.1.tgz";
        url  = "https://registry.yarnpkg.com/timed-out/-/timed-out-4.0.1.tgz";
        sha1 = "f32eacac5a175bea25d7fab565ab3ed8741ef56f";
      };
    }

    {
      name = "timers-browserify-2.0.10.tgz";
      path = fetchurl {
        name = "timers-browserify-2.0.10.tgz";
        url  = "https://registry.yarnpkg.com/timers-browserify/-/timers-browserify-2.0.10.tgz";
        sha1 = "1d28e3d2aadf1d5a5996c4e9f95601cd053480ae";
      };
    }

    {
      name = "tmp-0.0.28.tgz";
      path = fetchurl {
        name = "tmp-0.0.28.tgz";
        url  = "https://registry.yarnpkg.com/tmp/-/tmp-0.0.28.tgz";
        sha1 = "172735b7f614ea7af39664fa84cf0de4e515d120";
      };
    }

    {
      name = "tmp-0.0.33.tgz";
      path = fetchurl {
        name = "tmp-0.0.33.tgz";
        url  = "https://registry.yarnpkg.com/tmp/-/tmp-0.0.33.tgz";
        sha1 = "6d34335889768d21b2bcda0aa277ced3b1bfadf9";
      };
    }

    {
      name = "tmpl-1.0.4.tgz";
      path = fetchurl {
        name = "tmpl-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/tmpl/-/tmpl-1.0.4.tgz";
        sha1 = "23640dd7b42d00433911140820e5cf440e521dd1";
      };
    }

    {
      name = "to-arraybuffer-1.0.1.tgz";
      path = fetchurl {
        name = "to-arraybuffer-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/to-arraybuffer/-/to-arraybuffer-1.0.1.tgz";
        sha1 = "7d229b1fcc637e466ca081180836a7aabff83f43";
      };
    }

    {
      name = "to-ast-1.0.0.tgz";
      path = fetchurl {
        name = "to-ast-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/to-ast/-/to-ast-1.0.0.tgz";
        sha1 = "0c4a31c8c98edfde9aaf0192c794b4c8b11ee287";
      };
    }

    {
      name = "to-boolean-x-1.0.3.tgz";
      path = fetchurl {
        name = "to-boolean-x-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/to-boolean-x/-/to-boolean-x-1.0.3.tgz";
        sha1 = "cbe15e38a85d09553f29869a9b3e3b54ceef5af0";
      };
    }

    {
      name = "to-buffer-1.1.1.tgz";
      path = fetchurl {
        name = "to-buffer-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/to-buffer/-/to-buffer-1.1.1.tgz";
        sha1 = "493bd48f62d7c43fcded313a03dcadb2e1213a80";
      };
    }

    {
      name = "to-fast-properties-1.0.3.tgz";
      path = fetchurl {
        name = "to-fast-properties-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/to-fast-properties/-/to-fast-properties-1.0.3.tgz";
        sha1 = "b83571fa4d8c25b82e231b06e3a3055de4ca1a47";
      };
    }

    {
      name = "to-fast-properties-2.0.0.tgz";
      path = fetchurl {
        name = "to-fast-properties-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/to-fast-properties/-/to-fast-properties-2.0.0.tgz";
        sha1 = "dc5e698cbd079265bc73e0377681a4e4e83f616e";
      };
    }

    {
      name = "to-integer-x-3.0.0.tgz";
      path = fetchurl {
        name = "to-integer-x-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/to-integer-x/-/to-integer-x-3.0.0.tgz";
        sha1 = "9f3b80e668c7f0ae45e6926b40d95f52c1addc74";
      };
    }

    {
      name = "to-number-x-2.0.0.tgz";
      path = fetchurl {
        name = "to-number-x-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/to-number-x/-/to-number-x-2.0.0.tgz";
        sha1 = "c9099d7ded8fd327132a2987df2dcc8baf36df4d";
      };
    }

    {
      name = "to-object-path-0.3.0.tgz";
      path = fetchurl {
        name = "to-object-path-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/to-object-path/-/to-object-path-0.3.0.tgz";
        sha1 = "297588b7b0e7e0ac08e04e672f85c1f4999e17af";
      };
    }

    {
      name = "to-object-x-1.5.0.tgz";
      path = fetchurl {
        name = "to-object-x-1.5.0.tgz";
        url  = "https://registry.yarnpkg.com/to-object-x/-/to-object-x-1.5.0.tgz";
        sha1 = "bd69dd4e104d77acc0cc0d84f5ac48f630aebe3c";
      };
    }

    {
      name = "to-primitive-x-1.1.0.tgz";
      path = fetchurl {
        name = "to-primitive-x-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/to-primitive-x/-/to-primitive-x-1.1.0.tgz";
        sha1 = "41ce2c13e3e246e0e5d0a8829a0567c6015833f8";
      };
    }

    {
      name = "to-property-key-x-2.0.2.tgz";
      path = fetchurl {
        name = "to-property-key-x-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/to-property-key-x/-/to-property-key-x-2.0.2.tgz";
        sha1 = "b19aa8e22faa0ff7d1c102cfbc657af73413cfa1";
      };
    }

    {
      name = "to-regex-range-2.1.1.tgz";
      path = fetchurl {
        name = "to-regex-range-2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/to-regex-range/-/to-regex-range-2.1.1.tgz";
        sha1 = "7c80c17b9dfebe599e27367e0d4dd5590141db38";
      };
    }

    {
      name = "to-regex-3.0.2.tgz";
      path = fetchurl {
        name = "to-regex-3.0.2.tgz";
        url  = "https://registry.yarnpkg.com/to-regex/-/to-regex-3.0.2.tgz";
        sha1 = "13cfdd9b336552f30b51f33a8ae1b42a7a7599ce";
      };
    }

    {
      name = "to-string-symbols-supported-x-1.0.2.tgz";
      path = fetchurl {
        name = "to-string-symbols-supported-x-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/to-string-symbols-supported-x/-/to-string-symbols-supported-x-1.0.2.tgz";
        sha1 = "73f5e17963520b2b365559f05e3864addaab7f1e";
      };
    }

    {
      name = "to-string-tag-x-1.4.3.tgz";
      path = fetchurl {
        name = "to-string-tag-x-1.4.3.tgz";
        url  = "https://registry.yarnpkg.com/to-string-tag-x/-/to-string-tag-x-1.4.3.tgz";
        sha1 = "3aed2edec9343be3c76e338161f85d6864c692b1";
      };
    }

    {
      name = "to-string-x-1.4.5.tgz";
      path = fetchurl {
        name = "to-string-x-1.4.5.tgz";
        url  = "https://registry.yarnpkg.com/to-string-x/-/to-string-x-1.4.5.tgz";
        sha1 = "b86dad14df68ca4df52ca4cb011a25e0bf5d9ca1";
      };
    }

    {
      name = "topo-1.1.0.tgz";
      path = fetchurl {
        name = "topo-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/topo/-/topo-1.1.0.tgz";
        sha1 = "e9d751615d1bb87dc865db182fa1ca0a5ef536d5";
      };
    }

    {
      name = "topo-2.0.2.tgz";
      path = fetchurl {
        name = "topo-2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/topo/-/topo-2.0.2.tgz";
        sha1 = "cd5615752539057c0dc0491a621c3bc6fbe1d182";
      };
    }

    {
      name = "topo-3.0.0.tgz";
      path = fetchurl {
        name = "topo-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/topo/-/topo-3.0.0.tgz";
        sha1 = "37e48c330efeac784538e0acd3e62ca5e231fe7a";
      };
    }

    {
      name = "toposort-1.0.7.tgz";
      path = fetchurl {
        name = "toposort-1.0.7.tgz";
        url  = "https://registry.yarnpkg.com/toposort/-/toposort-1.0.7.tgz";
        sha1 = "2e68442d9f64ec720b8cc89e6443ac6caa950029";
      };
    }

    {
      name = "tough-cookie-2.3.3.tgz";
      path = fetchurl {
        name = "tough-cookie-2.3.3.tgz";
        url  = "https://registry.yarnpkg.com/tough-cookie/-/tough-cookie-2.3.3.tgz";
        sha1 = "0b618a5565b6dea90bf3425d04d55edc475a7561";
      };
    }

    {
      name = "tough-cookie-2.4.3.tgz";
      path = fetchurl {
        name = "tough-cookie-2.4.3.tgz";
        url  = "https://registry.yarnpkg.com/tough-cookie/-/tough-cookie-2.4.3.tgz";
        sha1 = "53f36da3f47783b0925afa06ff9f3b165280f781";
      };
    }

    {
      name = "tough-cookie-2.3.4.tgz";
      path = fetchurl {
        name = "tough-cookie-2.3.4.tgz";
        url  = "https://registry.yarnpkg.com/tough-cookie/-/tough-cookie-2.3.4.tgz";
        sha1 = "ec60cee38ac675063ffc97a5c18970578ee83655";
      };
    }

    {
      name = "tr46-1.0.1.tgz";
      path = fetchurl {
        name = "tr46-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/tr46/-/tr46-1.0.1.tgz";
        sha1 = "a8b13fd6bfd2489519674ccde55ba3693b706d09";
      };
    }

    {
      name = "tr46-0.0.3.tgz";
      path = fetchurl {
        name = "tr46-0.0.3.tgz";
        url  = "https://registry.yarnpkg.com/tr46/-/tr46-0.0.3.tgz";
        sha1 = "8184fd347dac9cdc185992f3a6622e14b9d9ab6a";
      };
    }

    {
      name = "traverse-0.3.9.tgz";
      path = fetchurl {
        name = "traverse-0.3.9.tgz";
        url  = "https://registry.yarnpkg.com/traverse/-/traverse-0.3.9.tgz";
        sha1 = "717b8f220cc0bb7b44e40514c22b2e8bbc70d8b9";
      };
    }

    {
      name = "tree-kill-1.2.0.tgz";
      path = fetchurl {
        name = "tree-kill-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/tree-kill/-/tree-kill-1.2.0.tgz";
        sha1 = "5846786237b4239014f05db156b643212d4c6f36";
      };
    }

    {
      name = "trim-left-x-3.0.0.tgz";
      path = fetchurl {
        name = "trim-left-x-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/trim-left-x/-/trim-left-x-3.0.0.tgz";
        sha1 = "356cf055896726b9754425e841398842e90b4cdf";
      };
    }

    {
      name = "trim-newlines-1.0.0.tgz";
      path = fetchurl {
        name = "trim-newlines-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/trim-newlines/-/trim-newlines-1.0.0.tgz";
        sha1 = "5887966bb582a4503a41eb524f7d35011815a613";
      };
    }

    {
      name = "trim-newlines-2.0.0.tgz";
      path = fetchurl {
        name = "trim-newlines-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/trim-newlines/-/trim-newlines-2.0.0.tgz";
        sha1 = "b403d0b91be50c331dfc4b82eeceb22c3de16d20";
      };
    }

    {
      name = "trim-off-newlines-1.0.1.tgz";
      path = fetchurl {
        name = "trim-off-newlines-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/trim-off-newlines/-/trim-off-newlines-1.0.1.tgz";
        sha1 = "9f9ba9d9efa8764c387698bcbfeb2c848f11adb3";
      };
    }

    {
      name = "trim-right-x-3.0.0.tgz";
      path = fetchurl {
        name = "trim-right-x-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/trim-right-x/-/trim-right-x-3.0.0.tgz";
        sha1 = "28c4cd37d5981f50ace9b52e3ce9106f4d2d22c0";
      };
    }

    {
      name = "trim-right-1.0.1.tgz";
      path = fetchurl {
        name = "trim-right-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/trim-right/-/trim-right-1.0.1.tgz";
        sha1 = "cb2e1203067e0c8de1f614094b9fe45704ea6003";
      };
    }

    {
      name = "trim-trailing-lines-1.1.1.tgz";
      path = fetchurl {
        name = "trim-trailing-lines-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/trim-trailing-lines/-/trim-trailing-lines-1.1.1.tgz";
        sha1 = "e0ec0810fd3c3f1730516b45f49083caaf2774d9";
      };
    }

    {
      name = "trim-x-3.0.0.tgz";
      path = fetchurl {
        name = "trim-x-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/trim-x/-/trim-x-3.0.0.tgz";
        sha1 = "24efdcd027b748bbfc246a0139ad1749befef024";
      };
    }

    {
      name = "trim-0.0.1.tgz";
      path = fetchurl {
        name = "trim-0.0.1.tgz";
        url  = "https://registry.yarnpkg.com/trim/-/trim-0.0.1.tgz";
        sha1 = "5858547f6b290757ee95cccc666fb50084c460dd";
      };
    }

    {
      name = "triple-beam-1.3.0.tgz";
      path = fetchurl {
        name = "triple-beam-1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/triple-beam/-/triple-beam-1.3.0.tgz";
        sha1 = "a595214c7298db8339eeeee083e4d10bd8cb8dd9";
      };
    }

    {
      name = "trough-1.0.2.tgz";
      path = fetchurl {
        name = "trough-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/trough/-/trough-1.0.2.tgz";
        sha1 = "7f1663ec55c480139e2de5e486c6aef6cc24a535";
      };
    }

    {
      name = "true-case-path-1.0.2.tgz";
      path = fetchurl {
        name = "true-case-path-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/true-case-path/-/true-case-path-1.0.2.tgz";
        sha1 = "7ec91130924766c7f573be3020c34f8fdfd00d62";
      };
    }

    {
      name = "truncate-utf8-bytes-1.0.2.tgz";
      path = fetchurl {
        name = "truncate-utf8-bytes-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/truncate-utf8-bytes/-/truncate-utf8-bytes-1.0.2.tgz";
        sha1 = "405923909592d56f78a5818434b0b78489ca5f2b";
      };
    }

    {
      name = "tty-browserify-0.0.0.tgz";
      path = fetchurl {
        name = "tty-browserify-0.0.0.tgz";
        url  = "https://registry.yarnpkg.com/tty-browserify/-/tty-browserify-0.0.0.tgz";
        sha1 = "a157ba402da24e9bf957f9aa69d524eed42901a6";
      };
    }

    {
      name = "tunnel-agent-0.6.0.tgz";
      path = fetchurl {
        name = "tunnel-agent-0.6.0.tgz";
        url  = "https://registry.yarnpkg.com/tunnel-agent/-/tunnel-agent-0.6.0.tgz";
        sha1 = "27a5dea06b36b04a0a9966774b290868f0fc40fd";
      };
    }

    {
      name = "tweetnacl-0.14.5.tgz";
      path = fetchurl {
        name = "tweetnacl-0.14.5.tgz";
        url  = "https://registry.yarnpkg.com/tweetnacl/-/tweetnacl-0.14.5.tgz";
        sha1 = "5ae68177f192d4456269d108afa93ff8743f4f64";
      };
    }

    {
      name = "type-check-0.3.2.tgz";
      path = fetchurl {
        name = "type-check-0.3.2.tgz";
        url  = "https://registry.yarnpkg.com/type-check/-/type-check-0.3.2.tgz";
        sha1 = "5884cab512cf1d355e3fb784f30804b2b520db72";
      };
    }

    {
      name = "type-detect-0.1.1.tgz";
      path = fetchurl {
        name = "type-detect-0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/type-detect/-/type-detect-0.1.1.tgz";
        sha1 = "0ba5ec2a885640e470ea4e8505971900dac58822";
      };
    }

    {
      name = "type-detect-1.0.0.tgz";
      path = fetchurl {
        name = "type-detect-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/type-detect/-/type-detect-1.0.0.tgz";
        sha1 = "762217cc06db258ec48908a1298e8b95121e8ea2";
      };
    }

    {
      name = "type-detect-4.0.8.tgz";
      path = fetchurl {
        name = "type-detect-4.0.8.tgz";
        url  = "https://registry.yarnpkg.com/type-detect/-/type-detect-4.0.8.tgz";
        sha1 = "7646fb5f18871cfbb7749e69bd39a6388eb7450c";
      };
    }

    {
      name = "type-is-1.6.16.tgz";
      path = fetchurl {
        name = "type-is-1.6.16.tgz";
        url  = "https://registry.yarnpkg.com/type-is/-/type-is-1.6.16.tgz";
        sha1 = "f89ce341541c672b25ee7ae3c73dee3b2be50194";
      };
    }

    {
      name = "typedarray-0.0.6.tgz";
      path = fetchurl {
        name = "typedarray-0.0.6.tgz";
        url  = "https://registry.yarnpkg.com/typedarray/-/typedarray-0.0.6.tgz";
        sha1 = "867ac74e3864187b1d3d47d996a78ec5c8830777";
      };
    }

    {
      name = "typeface-fira-sans-0.0.43.tgz";
      path = fetchurl {
        name = "typeface-fira-sans-0.0.43.tgz";
        url  = "https://registry.yarnpkg.com/typeface-fira-sans/-/typeface-fira-sans-0.0.43.tgz";
        sha1 = "f9c026ae5b7ad5f1fb727f9947bd1e10e13702e6";
      };
    }

    {
      name = "typeface-noto-sans-0.0.54.tgz";
      path = fetchurl {
        name = "typeface-noto-sans-0.0.54.tgz";
        url  = "https://registry.yarnpkg.com/typeface-noto-sans/-/typeface-noto-sans-0.0.54.tgz";
        sha1 = "16989ef56a5220b0503495ab8c1036f66b517b55";
      };
    }

    {
      name = "typeface-noto-serif-0.0.54.tgz";
      path = fetchurl {
        name = "typeface-noto-serif-0.0.54.tgz";
        url  = "https://registry.yarnpkg.com/typeface-noto-serif/-/typeface-noto-serif-0.0.54.tgz";
        sha1 = "26a552df3557c54f2f0c7f9bdbd28a95c9aab06b";
      };
    }

    {
      name = "typeface-ubuntu-mono-0.0.54.tgz";
      path = fetchurl {
        name = "typeface-ubuntu-mono-0.0.54.tgz";
        url  = "https://registry.yarnpkg.com/typeface-ubuntu-mono/-/typeface-ubuntu-mono-0.0.54.tgz";
        sha1 = "773582617ff60dc252acbaaeb22880ba7f559fe6";
      };
    }

    {
      name = "typescript-2.9.2.tgz";
      path = fetchurl {
        name = "typescript-2.9.2.tgz";
        url  = "https://registry.yarnpkg.com/typescript/-/typescript-2.9.2.tgz";
        sha1 = "1cbf61d05d6b96269244eb6a3bce4bd914e0f00c";
      };
    }

    {
      name = "typical-2.6.1.tgz";
      path = fetchurl {
        name = "typical-2.6.1.tgz";
        url  = "https://registry.yarnpkg.com/typical/-/typical-2.6.1.tgz";
        sha1 = "5c080e5d661cbbe38259d2e70a3c7253e873881d";
      };
    }

    {
      name = "ua-parser-js-0.7.18.tgz";
      path = fetchurl {
        name = "ua-parser-js-0.7.18.tgz";
        url  = "https://registry.yarnpkg.com/ua-parser-js/-/ua-parser-js-0.7.18.tgz";
        sha1 = "a7bfd92f56edfb117083b69e31d2aa8882d4b1ed";
      };
    }

    {
      name = "uglify-es-3.3.9.tgz";
      path = fetchurl {
        name = "uglify-es-3.3.9.tgz";
        url  = "https://registry.yarnpkg.com/uglify-es/-/uglify-es-3.3.9.tgz";
        sha1 = "0c1c4f0700bed8dbc124cdb304d2592ca203e677";
      };
    }

    {
      name = "uglify-js-3.4.4.tgz";
      path = fetchurl {
        name = "uglify-js-3.4.4.tgz";
        url  = "https://registry.yarnpkg.com/uglify-js/-/uglify-js-3.4.4.tgz";
        sha1 = "92e79532a3aeffd4b6c65755bdba8d5bad98d607";
      };
    }

    {
      name = "uglify-js-2.8.29.tgz";
      path = fetchurl {
        name = "uglify-js-2.8.29.tgz";
        url  = "https://registry.yarnpkg.com/uglify-js/-/uglify-js-2.8.29.tgz";
        sha1 = "29c5733148057bb4e1f75df35b7a9cb72e6a59dd";
      };
    }

    {
      name = "uglify-to-browserify-1.0.2.tgz";
      path = fetchurl {
        name = "uglify-to-browserify-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/uglify-to-browserify/-/uglify-to-browserify-1.0.2.tgz";
        sha1 = "6e0924d6bda6b5afe349e39a6d632850a0f882b7";
      };
    }

    {
      name = "uglifyjs-webpack-plugin-1.2.4.tgz";
      path = fetchurl {
        name = "uglifyjs-webpack-plugin-1.2.4.tgz";
        url  = "https://registry.yarnpkg.com/uglifyjs-webpack-plugin/-/uglifyjs-webpack-plugin-1.2.4.tgz";
        sha1 = "5eec941b2e9b8538be0a20fc6eda25b14c7c1043";
      };
    }

    {
      name = "uglifyjs-webpack-plugin-0.4.6.tgz";
      path = fetchurl {
        name = "uglifyjs-webpack-plugin-0.4.6.tgz";
        url  = "https://registry.yarnpkg.com/uglifyjs-webpack-plugin/-/uglifyjs-webpack-plugin-0.4.6.tgz";
        sha1 = "b951f4abb6bd617e66f63eb891498e391763e309";
      };
    }

    {
      name = "uglifyjs-webpack-plugin-1.2.7.tgz";
      path = fetchurl {
        name = "uglifyjs-webpack-plugin-1.2.7.tgz";
        url  = "https://registry.yarnpkg.com/uglifyjs-webpack-plugin/-/uglifyjs-webpack-plugin-1.2.7.tgz";
        sha1 = "57638dd99c853a1ebfe9d97b42160a8a507f9d00";
      };
    }

    {
      name = "uid-number-0.0.6.tgz";
      path = fetchurl {
        name = "uid-number-0.0.6.tgz";
        url  = "https://registry.yarnpkg.com/uid-number/-/uid-number-0.0.6.tgz";
        sha1 = "0ea10e8035e8eb5b8e4449f06da1c730663baa81";
      };
    }

    {
      name = "ultron-1.1.1.tgz";
      path = fetchurl {
        name = "ultron-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/ultron/-/ultron-1.1.1.tgz";
        sha1 = "9fe1536a10a664a65266a1e3ccf85fd36302bc9c";
      };
    }

    {
      name = "umzug-2.1.0.tgz";
      path = fetchurl {
        name = "umzug-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/umzug/-/umzug-2.1.0.tgz";
        sha1 = "c49dd71c7c26d082a9c9d3592dc6dc92cf867761";
      };
    }

    {
      name = "uncontrollable-4.1.0.tgz";
      path = fetchurl {
        name = "uncontrollable-4.1.0.tgz";
        url  = "https://registry.yarnpkg.com/uncontrollable/-/uncontrollable-4.1.0.tgz";
        sha1 = "e0358291252e1865222d90939b19f2f49f81c1a9";
      };
    }

    {
      name = "underscore-contrib-0.3.0.tgz";
      path = fetchurl {
        name = "underscore-contrib-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/underscore-contrib/-/underscore-contrib-0.3.0.tgz";
        sha1 = "665b66c24783f8fa2b18c9f8cbb0e2c7d48c26c7";
      };
    }

    {
      name = "underscore-1.6.0.tgz";
      path = fetchurl {
        name = "underscore-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/underscore/-/underscore-1.6.0.tgz";
        sha1 = "8b38b10cacdef63337b8b24e4ff86d45aea529a8";
      };
    }

    {
      name = "underscore-1.4.4.tgz";
      path = fetchurl {
        name = "underscore-1.4.4.tgz";
        url  = "https://registry.yarnpkg.com/underscore/-/underscore-1.4.4.tgz";
        sha1 = "61a6a32010622afa07963bf325203cf12239d604";
      };
    }

    {
      name = "underscore-1.8.3.tgz";
      path = fetchurl {
        name = "underscore-1.8.3.tgz";
        url  = "https://registry.yarnpkg.com/underscore/-/underscore-1.8.3.tgz";
        sha1 = "4f3fb53b106e6097fcf9cb4109f2a5e9bdfa5022";
      };
    }

    {
      name = "unherit-1.1.1.tgz";
      path = fetchurl {
        name = "unherit-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/unherit/-/unherit-1.1.1.tgz";
        sha1 = "132748da3e88eab767e08fabfbb89c5e9d28628c";
      };
    }

    {
      name = "unified-6.2.0.tgz";
      path = fetchurl {
        name = "unified-6.2.0.tgz";
        url  = "https://registry.yarnpkg.com/unified/-/unified-6.2.0.tgz";
        sha1 = "7fbd630f719126d67d40c644b7e3f617035f6dba";
      };
    }

    {
      name = "union-value-1.0.0.tgz";
      path = fetchurl {
        name = "union-value-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/union-value/-/union-value-1.0.0.tgz";
        sha1 = "5c71c34cb5bad5dcebe3ea0cd08207ba5aa1aea4";
      };
    }

    {
      name = "uniq-1.0.1.tgz";
      path = fetchurl {
        name = "uniq-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/uniq/-/uniq-1.0.1.tgz";
        sha1 = "b31c5ae8254844a3a8281541ce2b04b865a734ff";
      };
    }

    {
      name = "uniqs-2.0.0.tgz";
      path = fetchurl {
        name = "uniqs-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/uniqs/-/uniqs-2.0.0.tgz";
        sha1 = "ffede4b36b25290696e6e165d4a59edb998e6b02";
      };
    }

    {
      name = "unique-concat-0.2.2.tgz";
      path = fetchurl {
        name = "unique-concat-0.2.2.tgz";
        url  = "https://registry.yarnpkg.com/unique-concat/-/unique-concat-0.2.2.tgz";
        sha1 = "9210f9bdcaacc5e1e3929490d7c019df96f18712";
      };
    }

    {
      name = "unique-filename-1.1.0.tgz";
      path = fetchurl {
        name = "unique-filename-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/unique-filename/-/unique-filename-1.1.0.tgz";
        sha1 = "d05f2fe4032560871f30e93cbe735eea201514f3";
      };
    }

    {
      name = "unique-slug-2.0.0.tgz";
      path = fetchurl {
        name = "unique-slug-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/unique-slug/-/unique-slug-2.0.0.tgz";
        sha1 = "db6676e7c7cc0629878ff196097c78855ae9f4ab";
      };
    }

    {
      name = "unist-util-find-all-after-1.0.2.tgz";
      path = fetchurl {
        name = "unist-util-find-all-after-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/unist-util-find-all-after/-/unist-util-find-all-after-1.0.2.tgz";
        sha1 = "9be49cfbae5ca1566b27536670a92836bf2f8d6d";
      };
    }

    {
      name = "unist-util-is-2.1.2.tgz";
      path = fetchurl {
        name = "unist-util-is-2.1.2.tgz";
        url  = "https://registry.yarnpkg.com/unist-util-is/-/unist-util-is-2.1.2.tgz";
        sha1 = "1193fa8f2bfbbb82150633f3a8d2eb9a1c1d55db";
      };
    }

    {
      name = "unist-util-modify-children-1.1.2.tgz";
      path = fetchurl {
        name = "unist-util-modify-children-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/unist-util-modify-children/-/unist-util-modify-children-1.1.2.tgz";
        sha1 = "c7f1b91712554ee59c47a05b551ed3e052a4e2d1";
      };
    }

    {
      name = "unist-util-remove-position-1.1.2.tgz";
      path = fetchurl {
        name = "unist-util-remove-position-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/unist-util-remove-position/-/unist-util-remove-position-1.1.2.tgz";
        sha1 = "86b5dad104d0bbfbeb1db5f5c92f3570575c12cb";
      };
    }

    {
      name = "unist-util-stringify-position-1.1.2.tgz";
      path = fetchurl {
        name = "unist-util-stringify-position-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/unist-util-stringify-position/-/unist-util-stringify-position-1.1.2.tgz";
        sha1 = "3f37fcf351279dcbca7480ab5889bb8a832ee1c6";
      };
    }

    {
      name = "unist-util-visit-1.3.1.tgz";
      path = fetchurl {
        name = "unist-util-visit-1.3.1.tgz";
        url  = "https://registry.yarnpkg.com/unist-util-visit/-/unist-util-visit-1.3.1.tgz";
        sha1 = "c019ac9337a62486be58531bc27e7499ae7d55c7";
      };
    }

    {
      name = "universalify-0.1.2.tgz";
      path = fetchurl {
        name = "universalify-0.1.2.tgz";
        url  = "https://registry.yarnpkg.com/universalify/-/universalify-0.1.2.tgz";
        sha1 = "b646f69be3942dabcecc9d6639c80dc105efaa66";
      };
    }

    {
      name = "unpipe-1.0.0.tgz";
      path = fetchurl {
        name = "unpipe-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/unpipe/-/unpipe-1.0.0.tgz";
        sha1 = "b2bf4ee8514aae6165b4817829d21b2ef49904ec";
      };
    }

    {
      name = "unquote-1.1.1.tgz";
      path = fetchurl {
        name = "unquote-1.1.1.tgz";
        url  = "https://registry.yarnpkg.com/unquote/-/unquote-1.1.1.tgz";
        sha1 = "8fded7324ec6e88a0ff8b905e7c098cdc086d544";
      };
    }

    {
      name = "unset-value-1.0.0.tgz";
      path = fetchurl {
        name = "unset-value-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/unset-value/-/unset-value-1.0.0.tgz";
        sha1 = "8376873f7d2335179ffb1e6fc3a8ed0dfc8ab559";
      };
    }

    {
      name = "unzip-response-2.0.1.tgz";
      path = fetchurl {
        name = "unzip-response-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/unzip-response/-/unzip-response-2.0.1.tgz";
        sha1 = "d2f0f737d16b0615e72a6935ed04214572d56f97";
      };
    }

    {
      name = "unzipper-0.8.14.tgz";
      path = fetchurl {
        name = "unzipper-0.8.14.tgz";
        url  = "https://registry.yarnpkg.com/unzipper/-/unzipper-0.8.14.tgz";
        sha1 = "ade0524cd2fc14d11b8de258be22f9d247d3f79b";
      };
    }

    {
      name = "upath-1.1.0.tgz";
      path = fetchurl {
        name = "upath-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/upath/-/upath-1.1.0.tgz";
        sha1 = "35256597e46a581db4793d0ce47fa9aebfc9fabd";
      };
    }

    {
      name = "upper-case-1.1.3.tgz";
      path = fetchurl {
        name = "upper-case-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/upper-case/-/upper-case-1.1.3.tgz";
        sha1 = "f6b4501c2ec4cdd26ba78be7222961de77621598";
      };
    }

    {
      name = "uri-js-4.2.2.tgz";
      path = fetchurl {
        name = "uri-js-4.2.2.tgz";
        url  = "https://registry.yarnpkg.com/uri-js/-/uri-js-4.2.2.tgz";
        sha1 = "94c540e1ff772956e2299507c010aea6c8838eb0";
      };
    }

    {
      name = "urix-0.1.0.tgz";
      path = fetchurl {
        name = "urix-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/urix/-/urix-0.1.0.tgz";
        sha1 = "da937f7a62e21fec1fd18d49b35c2935067a6c72";
      };
    }

    {
      name = "url-loader-0.6.2.tgz";
      path = fetchurl {
        name = "url-loader-0.6.2.tgz";
        url  = "https://registry.yarnpkg.com/url-loader/-/url-loader-0.6.2.tgz";
        sha1 = "a007a7109620e9d988d14bce677a1decb9a993f7";
      };
    }

    {
      name = "url-parse-lax-1.0.0.tgz";
      path = fetchurl {
        name = "url-parse-lax-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/url-parse-lax/-/url-parse-lax-1.0.0.tgz";
        sha1 = "7af8f303645e9bd79a272e7a14ac68bc0609da73";
      };
    }

    {
      name = "url-parse-1.4.1.tgz";
      path = fetchurl {
        name = "url-parse-1.4.1.tgz";
        url  = "https://registry.yarnpkg.com/url-parse/-/url-parse-1.4.1.tgz";
        sha1 = "4dec9dad3dc8585f862fed461d2e19bbf623df30";
      };
    }

    {
      name = "url-0.11.0.tgz";
      path = fetchurl {
        name = "url-0.11.0.tgz";
        url  = "https://registry.yarnpkg.com/url/-/url-0.11.0.tgz";
        sha1 = "3838e97cfc60521eb73c525a8e55bfdd9e2e28f1";
      };
    }

    {
      name = "use-3.1.0.tgz";
      path = fetchurl {
        name = "use-3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/use/-/use-3.1.0.tgz";
        sha1 = "14716bf03fdfefd03040aef58d8b4b85f3a7c544";
      };
    }

    {
      name = "user-home-2.0.0.tgz";
      path = fetchurl {
        name = "user-home-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/user-home/-/user-home-2.0.0.tgz";
        sha1 = "9c70bfd8169bc1dcbf48604e0f04b8b49cde9e9f";
      };
    }

    {
      name = "useragent-2.3.0.tgz";
      path = fetchurl {
        name = "useragent-2.3.0.tgz";
        url  = "https://registry.yarnpkg.com/useragent/-/useragent-2.3.0.tgz";
        sha1 = "217f943ad540cb2128658ab23fc960f6a88c9972";
      };
    }

    {
      name = "utf8-byte-length-1.0.4.tgz";
      path = fetchurl {
        name = "utf8-byte-length-1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/utf8-byte-length/-/utf8-byte-length-1.0.4.tgz";
        sha1 = "f45f150c4c66eee968186505ab93fcbb8ad6bf61";
      };
    }

    {
      name = "util-deprecate-1.0.2.tgz";
      path = fetchurl {
        name = "util-deprecate-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/util-deprecate/-/util-deprecate-1.0.2.tgz";
        sha1 = "450d4dc9fa70de732762fbd2d4a28981419a0ccf";
      };
    }

    {
      name = "util.promisify-1.0.0.tgz";
      path = fetchurl {
        name = "util.promisify-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/util.promisify/-/util.promisify-1.0.0.tgz";
        sha1 = "440f7165a459c9a16dc145eb8e72f35687097030";
      };
    }

    {
      name = "util-0.10.3.tgz";
      path = fetchurl {
        name = "util-0.10.3.tgz";
        url  = "https://registry.yarnpkg.com/util/-/util-0.10.3.tgz";
        sha1 = "7afb1afe50805246489e3db7fe0ed379336ac0f9";
      };
    }

    {
      name = "util-0.11.0.tgz";
      path = fetchurl {
        name = "util-0.11.0.tgz";
        url  = "https://registry.yarnpkg.com/util/-/util-0.11.0.tgz";
        sha1 = "c5f391beb244103d799b21077a926fef8769e1fb";
      };
    }

    {
      name = "util-0.10.4.tgz";
      path = fetchurl {
        name = "util-0.10.4.tgz";
        url  = "https://registry.yarnpkg.com/util/-/util-0.10.4.tgz";
        sha1 = "3aa0125bfe668a4672de58857d3ace27ecb76901";
      };
    }

    {
      name = "utila-0.3.3.tgz";
      path = fetchurl {
        name = "utila-0.3.3.tgz";
        url  = "https://registry.yarnpkg.com/utila/-/utila-0.3.3.tgz";
        sha1 = "d7e8e7d7e309107092b05f8d9688824d633a4226";
      };
    }

    {
      name = "utila-0.4.0.tgz";
      path = fetchurl {
        name = "utila-0.4.0.tgz";
        url  = "https://registry.yarnpkg.com/utila/-/utila-0.4.0.tgz";
        sha1 = "8a16a05d445657a3aea5eecc5b12a4fa5379772c";
      };
    }

    {
      name = "utile-0.2.1.tgz";
      path = fetchurl {
        name = "utile-0.2.1.tgz";
        url  = "https://registry.yarnpkg.com/utile/-/utile-0.2.1.tgz";
        sha1 = "930c88e99098d6220834c356cbd9a770522d90d7";
      };
    }

    {
      name = "utile-0.3.0.tgz";
      path = fetchurl {
        name = "utile-0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/utile/-/utile-0.3.0.tgz";
        sha1 = "1352c340eb820e4d8ddba039a4fbfaa32ed4ef3a";
      };
    }

    {
      name = "utils-merge-1.0.1.tgz";
      path = fetchurl {
        name = "utils-merge-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/utils-merge/-/utils-merge-1.0.1.tgz";
        sha1 = "9f95710f50a267947b2ccc124741c1028427e713";
      };
    }

    {
      name = "uuid-3.2.1.tgz";
      path = fetchurl {
        name = "uuid-3.2.1.tgz";
        url  = "https://registry.yarnpkg.com/uuid/-/uuid-3.2.1.tgz";
        sha1 = "12c528bb9d58d0b9265d9a2f6f0fe8be17ff1f14";
      };
    }

    {
      name = "uuid-2.0.3.tgz";
      path = fetchurl {
        name = "uuid-2.0.3.tgz";
        url  = "https://registry.yarnpkg.com/uuid/-/uuid-2.0.3.tgz";
        sha1 = "67e2e863797215530dff318e5bf9dcebfd47b21a";
      };
    }

    {
      name = "uuid-3.3.2.tgz";
      path = fetchurl {
        name = "uuid-3.3.2.tgz";
        url  = "https://registry.yarnpkg.com/uuid/-/uuid-3.3.2.tgz";
        sha1 = "1b4af4955eb3077c501c23872fc6513811587131";
      };
    }

    {
      name = "validate-npm-package-license-3.0.3.tgz";
      path = fetchurl {
        name = "validate-npm-package-license-3.0.3.tgz";
        url  = "https://registry.yarnpkg.com/validate-npm-package-license/-/validate-npm-package-license-3.0.3.tgz";
        sha1 = "81643bcbef1bdfecd4623793dc4648948ba98338";
      };
    }

    {
      name = "validate.io-undefined-1.0.3.tgz";
      path = fetchurl {
        name = "validate.io-undefined-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/validate.io-undefined/-/validate.io-undefined-1.0.3.tgz";
        sha1 = "7e27fcbb315b841e78243431897671929e20b7f4";
      };
    }

    {
      name = "value-equal-0.4.0.tgz";
      path = fetchurl {
        name = "value-equal-0.4.0.tgz";
        url  = "https://registry.yarnpkg.com/value-equal/-/value-equal-0.4.0.tgz";
        sha1 = "c5bdd2f54ee093c04839d71ce2e4758a6890abc7";
      };
    }

    {
      name = "vary-1.1.2.tgz";
      path = fetchurl {
        name = "vary-1.1.2.tgz";
        url  = "https://registry.yarnpkg.com/vary/-/vary-1.1.2.tgz";
        sha1 = "2299f02c6ded30d4a5961b0b9f74524a18f634fc";
      };
    }

    {
      name = "vendors-1.0.2.tgz";
      path = fetchurl {
        name = "vendors-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/vendors/-/vendors-1.0.2.tgz";
        sha1 = "7fcb5eef9f5623b156bcea89ec37d63676f21801";
      };
    }

    {
      name = "verror-1.10.0.tgz";
      path = fetchurl {
        name = "verror-1.10.0.tgz";
        url  = "https://registry.yarnpkg.com/verror/-/verror-1.10.0.tgz";
        sha1 = "3a105ca17053af55d6e270c1f8288682e18da400";
      };
    }

    {
      name = "vfile-location-2.0.3.tgz";
      path = fetchurl {
        name = "vfile-location-2.0.3.tgz";
        url  = "https://registry.yarnpkg.com/vfile-location/-/vfile-location-2.0.3.tgz";
        sha1 = "083ba80e50968e8d420be49dd1ea9a992131df77";
      };
    }

    {
      name = "vfile-message-1.0.1.tgz";
      path = fetchurl {
        name = "vfile-message-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/vfile-message/-/vfile-message-1.0.1.tgz";
        sha1 = "51a2ccd8a6b97a7980bb34efb9ebde9632e93677";
      };
    }

    {
      name = "vfile-2.3.0.tgz";
      path = fetchurl {
        name = "vfile-2.3.0.tgz";
        url  = "https://registry.yarnpkg.com/vfile/-/vfile-2.3.0.tgz";
        sha1 = "e62d8e72b20e83c324bc6c67278ee272488bf84a";
      };
    }

    {
      name = "vlq-0.2.3.tgz";
      path = fetchurl {
        name = "vlq-0.2.3.tgz";
        url  = "https://registry.yarnpkg.com/vlq/-/vlq-0.2.3.tgz";
        sha1 = "8f3e4328cf63b1540c0d67e1b2778386f8975b26";
      };
    }

    {
      name = "vlq-1.0.0.tgz";
      path = fetchurl {
        name = "vlq-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/vlq/-/vlq-1.0.0.tgz";
        sha1 = "8101be90843422954c2b13eb27f2f3122bdcc806";
      };
    }

    {
      name = "vm-browserify-0.0.4.tgz";
      path = fetchurl {
        name = "vm-browserify-0.0.4.tgz";
        url  = "https://registry.yarnpkg.com/vm-browserify/-/vm-browserify-0.0.4.tgz";
        sha1 = "5d7ea45bbef9e4a6ff65f95438e0a87c357d5a73";
      };
    }

    {
      name = "vuvuzela-1.0.3.tgz";
      path = fetchurl {
        name = "vuvuzela-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/vuvuzela/-/vuvuzela-1.0.3.tgz";
        sha1 = "3be145e58271c73ca55279dd851f12a682114b0b";
      };
    }

    {
      name = "w3c-hr-time-1.0.1.tgz";
      path = fetchurl {
        name = "w3c-hr-time-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/w3c-hr-time/-/w3c-hr-time-1.0.1.tgz";
        sha1 = "82ac2bff63d950ea9e3189a58a65625fedf19045";
      };
    }

    {
      name = "walk-back-2.0.1.tgz";
      path = fetchurl {
        name = "walk-back-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/walk-back/-/walk-back-2.0.1.tgz";
        sha1 = "554e2a9d874fac47a8cb006bf44c2f0c4998a0a4";
      };
    }

    {
      name = "walk-back-3.0.0.tgz";
      path = fetchurl {
        name = "walk-back-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/walk-back/-/walk-back-3.0.0.tgz";
        sha1 = "2358787a35da91032dad5e92f80b12370d8795c5";
      };
    }

    {
      name = "walker-1.0.7.tgz";
      path = fetchurl {
        name = "walker-1.0.7.tgz";
        url  = "https://registry.yarnpkg.com/walker/-/walker-1.0.7.tgz";
        sha1 = "2f7f9b8fd10d677262b18a884e28d19618e028fb";
      };
    }

    {
      name = "warning-3.0.0.tgz";
      path = fetchurl {
        name = "warning-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/warning/-/warning-3.0.0.tgz";
        sha1 = "32e5377cb572de4ab04753bdf8821c01ed605b7c";
      };
    }

    {
      name = "warning-4.0.1.tgz";
      path = fetchurl {
        name = "warning-4.0.1.tgz";
        url  = "https://registry.yarnpkg.com/warning/-/warning-4.0.1.tgz";
        sha1 = "66ce376b7fbfe8a887c22bdf0e7349d73d397745";
      };
    }

    {
      name = "watch-0.10.0.tgz";
      path = fetchurl {
        name = "watch-0.10.0.tgz";
        url  = "https://registry.yarnpkg.com/watch/-/watch-0.10.0.tgz";
        sha1 = "77798b2da0f9910d595f1ace5b0c2258521f21dc";
      };
    }

    {
      name = "watch-0.18.0.tgz";
      path = fetchurl {
        name = "watch-0.18.0.tgz";
        url  = "https://registry.yarnpkg.com/watch/-/watch-0.18.0.tgz";
        sha1 = "28095476c6df7c90c963138990c0a5423eb4b986";
      };
    }

    {
      name = "watchpack-1.6.0.tgz";
      path = fetchurl {
        name = "watchpack-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/watchpack/-/watchpack-1.6.0.tgz";
        sha1 = "4bc12c2ebe8aa277a71f1d3f14d685c7b446cd00";
      };
    }

    {
      name = "wax-editor-core-0.6.4.tgz";
      path = fetchurl {
        name = "wax-editor-core-0.6.4.tgz";
        url  = "https://registry.yarnpkg.com/wax-editor-core/-/wax-editor-core-0.6.4.tgz";
        sha1 = "21ab96dbc2b5ce5e54d6fa27826f541f28883a0e";
      };
    }

    {
      name = "wax-editor-react-0.2.5.tgz";
      path = fetchurl {
        name = "wax-editor-react-0.2.5.tgz";
        url  = "https://registry.yarnpkg.com/wax-editor-react/-/wax-editor-react-0.2.5.tgz";
        sha1 = "c622c0558932c9dee2a94973f66752242d8b97d4";
      };
    }

    {
      name = "wbuf-1.7.3.tgz";
      path = fetchurl {
        name = "wbuf-1.7.3.tgz";
        url  = "https://registry.yarnpkg.com/wbuf/-/wbuf-1.7.3.tgz";
        sha1 = "c1d8d149316d3ea852848895cb6a0bfe887b87df";
      };
    }

    {
      name = "wcwidth-1.0.1.tgz";
      path = fetchurl {
        name = "wcwidth-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/wcwidth/-/wcwidth-1.0.1.tgz";
        sha1 = "f0b0dcf915bc5ff1528afadb2c0e17b532da2fe8";
      };
    }

    {
      name = "webauth-1.1.0.tgz";
      path = fetchurl {
        name = "webauth-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/webauth/-/webauth-1.1.0.tgz";
        sha1 = "64704f6b8026986605bc3ca629952e6e26fdd100";
      };
    }

    {
      name = "webidl-conversions-3.0.1.tgz";
      path = fetchurl {
        name = "webidl-conversions-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/webidl-conversions/-/webidl-conversions-3.0.1.tgz";
        sha1 = "24534275e2a7bc6be7bc86611cc16ae0a5654871";
      };
    }

    {
      name = "webidl-conversions-4.0.2.tgz";
      path = fetchurl {
        name = "webidl-conversions-4.0.2.tgz";
        url  = "https://registry.yarnpkg.com/webidl-conversions/-/webidl-conversions-4.0.2.tgz";
        sha1 = "a855980b1f0b6b359ba1d5d9fb39ae941faa63ad";
      };
    }

    {
      name = "webpack-dev-middleware-1.12.2.tgz";
      path = fetchurl {
        name = "webpack-dev-middleware-1.12.2.tgz";
        url  = "https://registry.yarnpkg.com/webpack-dev-middleware/-/webpack-dev-middleware-1.12.2.tgz";
        sha1 = "f8fc1120ce3b4fc5680ceecb43d777966b21105e";
      };
    }

    {
      name = "webpack-dev-server-2.11.2.tgz";
      path = fetchurl {
        name = "webpack-dev-server-2.11.2.tgz";
        url  = "https://registry.yarnpkg.com/webpack-dev-server/-/webpack-dev-server-2.11.2.tgz";
        sha1 = "1f4f4c78bf1895378f376815910812daf79a216f";
      };
    }

    {
      name = "webpack-hot-middleware-2.22.2.tgz";
      path = fetchurl {
        name = "webpack-hot-middleware-2.22.2.tgz";
        url  = "https://registry.yarnpkg.com/webpack-hot-middleware/-/webpack-hot-middleware-2.22.2.tgz";
        sha1 = "623b77ce591fcd4e1fb99f18167781443e50afac";
      };
    }

    {
      name = "webpack-merge-4.1.3.tgz";
      path = fetchurl {
        name = "webpack-merge-4.1.3.tgz";
        url  = "https://registry.yarnpkg.com/webpack-merge/-/webpack-merge-4.1.3.tgz";
        sha1 = "8aaff2108a19c29849bc9ad2a7fd7fce68e87c4a";
      };
    }

    {
      name = "webpack-node-externals-1.7.2.tgz";
      path = fetchurl {
        name = "webpack-node-externals-1.7.2.tgz";
        url  = "https://registry.yarnpkg.com/webpack-node-externals/-/webpack-node-externals-1.7.2.tgz";
        sha1 = "6e1ee79ac67c070402ba700ef033a9b8d52ac4e3";
      };
    }

    {
      name = "webpack-sources-0.1.5.tgz";
      path = fetchurl {
        name = "webpack-sources-0.1.5.tgz";
        url  = "https://registry.yarnpkg.com/webpack-sources/-/webpack-sources-0.1.5.tgz";
        sha1 = "aa1f3abf0f0d74db7111c40e500b84f966640750";
      };
    }

    {
      name = "webpack-sources-1.1.0.tgz";
      path = fetchurl {
        name = "webpack-sources-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/webpack-sources/-/webpack-sources-1.1.0.tgz";
        sha1 = "a101ebae59d6507354d71d8013950a3a8b7a5a54";
      };
    }

    {
      name = "webpack-2.7.0.tgz";
      path = fetchurl {
        name = "webpack-2.7.0.tgz";
        url  = "https://registry.yarnpkg.com/webpack/-/webpack-2.7.0.tgz";
        sha1 = "b2a1226804373ffd3d03ea9c6bd525067034f6b1";
      };
    }

    {
      name = "webpack-3.12.0.tgz";
      path = fetchurl {
        name = "webpack-3.12.0.tgz";
        url  = "https://registry.yarnpkg.com/webpack/-/webpack-3.12.0.tgz";
        sha1 = "3f9e34360370602fcf639e97939db486f4ec0d74";
      };
    }

    {
      name = "websocket-driver-0.7.0.tgz";
      path = fetchurl {
        name = "websocket-driver-0.7.0.tgz";
        url  = "https://registry.yarnpkg.com/websocket-driver/-/websocket-driver-0.7.0.tgz";
        sha1 = "0caf9d2d755d93aee049d4bdd0d3fe2cca2a24eb";
      };
    }

    {
      name = "websocket-extensions-0.1.3.tgz";
      path = fetchurl {
        name = "websocket-extensions-0.1.3.tgz";
        url  = "https://registry.yarnpkg.com/websocket-extensions/-/websocket-extensions-0.1.3.tgz";
        sha1 = "5d2ff22977003ec687a4b87073dfbbac146ccf29";
      };
    }

    {
      name = "whatwg-encoding-1.0.3.tgz";
      path = fetchurl {
        name = "whatwg-encoding-1.0.3.tgz";
        url  = "https://registry.yarnpkg.com/whatwg-encoding/-/whatwg-encoding-1.0.3.tgz";
        sha1 = "57c235bc8657e914d24e1a397d3c82daee0a6ba3";
      };
    }

    {
      name = "whatwg-fetch-2.0.4.tgz";
      path = fetchurl {
        name = "whatwg-fetch-2.0.4.tgz";
        url  = "https://registry.yarnpkg.com/whatwg-fetch/-/whatwg-fetch-2.0.4.tgz";
        sha1 = "dde6a5df315f9d39991aa17621853d720b85566f";
      };
    }

    {
      name = "whatwg-mimetype-2.1.0.tgz";
      path = fetchurl {
        name = "whatwg-mimetype-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/whatwg-mimetype/-/whatwg-mimetype-2.1.0.tgz";
        sha1 = "f0f21d76cbba72362eb609dbed2a30cd17fcc7d4";
      };
    }

    {
      name = "whatwg-url-4.8.0.tgz";
      path = fetchurl {
        name = "whatwg-url-4.8.0.tgz";
        url  = "https://registry.yarnpkg.com/whatwg-url/-/whatwg-url-4.8.0.tgz";
        sha1 = "d2981aa9148c1e00a41c5a6131166ab4683bbcc0";
      };
    }

    {
      name = "whatwg-url-6.5.0.tgz";
      path = fetchurl {
        name = "whatwg-url-6.5.0.tgz";
        url  = "https://registry.yarnpkg.com/whatwg-url/-/whatwg-url-6.5.0.tgz";
        sha1 = "f2df02bff176fd65070df74ad5ccbb5a199965a8";
      };
    }

    {
      name = "whet.extend-0.9.9.tgz";
      path = fetchurl {
        name = "whet.extend-0.9.9.tgz";
        url  = "https://registry.yarnpkg.com/whet.extend/-/whet.extend-0.9.9.tgz";
        sha1 = "f877d5bf648c97e5aa542fadc16d6a259b9c11a1";
      };
    }

    {
      name = "which-module-1.0.0.tgz";
      path = fetchurl {
        name = "which-module-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/which-module/-/which-module-1.0.0.tgz";
        sha1 = "bba63ca861948994ff307736089e3b96026c2a4f";
      };
    }

    {
      name = "which-module-2.0.0.tgz";
      path = fetchurl {
        name = "which-module-2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/which-module/-/which-module-2.0.0.tgz";
        sha1 = "d9ef07dce77b9902b8a3a8fa4b31c3e3f7e6e87a";
      };
    }

    {
      name = "which-promise-1.0.0.tgz";
      path = fetchurl {
        name = "which-promise-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/which-promise/-/which-promise-1.0.0.tgz";
        sha1 = "20b721df05b35b706176ffa10b0909aba4603035";
      };
    }

    {
      name = "which-1.3.1.tgz";
      path = fetchurl {
        name = "which-1.3.1.tgz";
        url  = "https://registry.yarnpkg.com/which/-/which-1.3.1.tgz";
        sha1 = "a45043d54f5805316da8d62f9f50918d3da70b0a";
      };
    }

    {
      name = "white-space-x-3.0.1.tgz";
      path = fetchurl {
        name = "white-space-x-3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/white-space-x/-/white-space-x-3.0.1.tgz";
        sha1 = "81a82d5432da725aba5ca671624bb579c9e66d4f";
      };
    }

    {
      name = "wide-align-1.1.3.tgz";
      path = fetchurl {
        name = "wide-align-1.1.3.tgz";
        url  = "https://registry.yarnpkg.com/wide-align/-/wide-align-1.1.3.tgz";
        sha1 = "ae074e6bdc0c14a431e804e624549c633b000457";
      };
    }

    {
      name = "window-size-0.1.0.tgz";
      path = fetchurl {
        name = "window-size-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/window-size/-/window-size-0.1.0.tgz";
        sha1 = "5438cd2ea93b202efa3a19fe8887aee7c94f9c9d";
      };
    }

    {
      name = "winston-compat-0.1.4.tgz";
      path = fetchurl {
        name = "winston-compat-0.1.4.tgz";
        url  = "https://registry.yarnpkg.com/winston-compat/-/winston-compat-0.1.4.tgz";
        sha1 = "599b4ce807ffe728713ecc25ede3f6b89425b739";
      };
    }

    {
      name = "winston-daily-rotate-file-3.2.3.tgz";
      path = fetchurl {
        name = "winston-daily-rotate-file-3.2.3.tgz";
        url  = "https://registry.yarnpkg.com/winston-daily-rotate-file/-/winston-daily-rotate-file-3.2.3.tgz";
        sha1 = "9f80e7a421ab32b073c1217bae62e762001197d6";
      };
    }

    {
      name = "winston-transport-4.2.0.tgz";
      path = fetchurl {
        name = "winston-transport-4.2.0.tgz";
        url  = "https://registry.yarnpkg.com/winston-transport/-/winston-transport-4.2.0.tgz";
        sha1 = "a20be89edf2ea2ca39ba25f3e50344d73e6520e5";
      };
    }

    {
      name = "winston-0.8.0.tgz";
      path = fetchurl {
        name = "winston-0.8.0.tgz";
        url  = "https://registry.yarnpkg.com/winston/-/winston-0.8.0.tgz";
        sha1 = "61d0830fa699706212206b0a2b5ca69a93043668";
      };
    }

    {
      name = "winston-0.8.3.tgz";
      path = fetchurl {
        name = "winston-0.8.3.tgz";
        url  = "https://registry.yarnpkg.com/winston/-/winston-0.8.3.tgz";
        sha1 = "64b6abf4cd01adcaefd5009393b1d8e8bec19db0";
      };
    }

    {
      name = "winston-2.4.3.tgz";
      path = fetchurl {
        name = "winston-2.4.3.tgz";
        url  = "https://registry.yarnpkg.com/winston/-/winston-2.4.3.tgz";
        sha1 = "7a9fdab371b6d3d9b63a592947846d856948c517";
      };
    }

    {
      name = "wordwrap-0.0.2.tgz";
      path = fetchurl {
        name = "wordwrap-0.0.2.tgz";
        url  = "https://registry.yarnpkg.com/wordwrap/-/wordwrap-0.0.2.tgz";
        sha1 = "b79669bb42ecb409f83d583cad52ca17eaa1643f";
      };
    }

    {
      name = "wordwrap-0.0.3.tgz";
      path = fetchurl {
        name = "wordwrap-0.0.3.tgz";
        url  = "https://registry.yarnpkg.com/wordwrap/-/wordwrap-0.0.3.tgz";
        sha1 = "a3d5da6cd5c0bc0008d37234bbaf1bed63059107";
      };
    }

    {
      name = "wordwrap-1.0.0.tgz";
      path = fetchurl {
        name = "wordwrap-1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/wordwrap/-/wordwrap-1.0.0.tgz";
        sha1 = "27584810891456a4171c8d0226441ade90cbcaeb";
      };
    }

    {
      name = "wordwrapjs-3.0.0.tgz";
      path = fetchurl {
        name = "wordwrapjs-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/wordwrapjs/-/wordwrapjs-3.0.0.tgz";
        sha1 = "c94c372894cadc6feb1a66bff64e1d9af92c5d1e";
      };
    }

    {
      name = "worker-farm-1.6.0.tgz";
      path = fetchurl {
        name = "worker-farm-1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/worker-farm/-/worker-farm-1.6.0.tgz";
        sha1 = "aecc405976fab5a95526180846f0dba288f3a4a0";
      };
    }

    {
      name = "wrap-ansi-2.1.0.tgz";
      path = fetchurl {
        name = "wrap-ansi-2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/wrap-ansi/-/wrap-ansi-2.1.0.tgz";
        sha1 = "d8fc3d284dd05794fe84973caecdd1cf824fdd85";
      };
    }

    {
      name = "wrappy-1.0.2.tgz";
      path = fetchurl {
        name = "wrappy-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/wrappy/-/wrappy-1.0.2.tgz";
        sha1 = "b5243d8f3ec1aa35f1364605bc0d1036e30ab69f";
      };
    }

    {
      name = "write-file-atomic-2.3.0.tgz";
      path = fetchurl {
        name = "write-file-atomic-2.3.0.tgz";
        url  = "https://registry.yarnpkg.com/write-file-atomic/-/write-file-atomic-2.3.0.tgz";
        sha1 = "1ff61575c2e2a4e8e510d6fa4e243cce183999ab";
      };
    }

    {
      name = "write-json-file-2.3.0.tgz";
      path = fetchurl {
        name = "write-json-file-2.3.0.tgz";
        url  = "https://registry.yarnpkg.com/write-json-file/-/write-json-file-2.3.0.tgz";
        sha1 = "2b64c8a33004d54b8698c76d585a77ceb61da32f";
      };
    }

    {
      name = "write-pkg-3.2.0.tgz";
      path = fetchurl {
        name = "write-pkg-3.2.0.tgz";
        url  = "https://registry.yarnpkg.com/write-pkg/-/write-pkg-3.2.0.tgz";
        sha1 = "0e178fe97820d389a8928bc79535dbe68c2cff21";
      };
    }

    {
      name = "write-0.2.1.tgz";
      path = fetchurl {
        name = "write-0.2.1.tgz";
        url  = "https://registry.yarnpkg.com/write/-/write-0.2.1.tgz";
        sha1 = "5fc03828e264cea3fe91455476f7a3c566cb0757";
      };
    }

    {
      name = "ws-3.3.3.tgz";
      path = fetchurl {
        name = "ws-3.3.3.tgz";
        url  = "https://registry.yarnpkg.com/ws/-/ws-3.3.3.tgz";
        sha1 = "f1cf84fe2d5e901ebce94efaece785f187a228f2";
      };
    }

    {
      name = "ws-4.1.0.tgz";
      path = fetchurl {
        name = "ws-4.1.0.tgz";
        url  = "https://registry.yarnpkg.com/ws/-/ws-4.1.0.tgz";
        sha1 = "a979b5d7d4da68bf54efe0408967c324869a7289";
      };
    }

    {
      name = "x-is-string-0.1.0.tgz";
      path = fetchurl {
        name = "x-is-string-0.1.0.tgz";
        url  = "https://registry.yarnpkg.com/x-is-string/-/x-is-string-0.1.0.tgz";
        sha1 = "474b50865af3a49a9c4657f05acd145458f77d82";
      };
    }

    {
      name = "x-xss-protection-1.1.0.tgz";
      path = fetchurl {
        name = "x-xss-protection-1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/x-xss-protection/-/x-xss-protection-1.1.0.tgz";
        sha1 = "4f1898c332deb1e7f2be1280efb3e2c53d69c1a7";
      };
    }

    {
      name = "xml-name-validator-2.0.1.tgz";
      path = fetchurl {
        name = "xml-name-validator-2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/xml-name-validator/-/xml-name-validator-2.0.1.tgz";
        sha1 = "4d8b8f1eccd3419aa362061becef515e1e559635";
      };
    }

    {
      name = "xml-name-validator-3.0.0.tgz";
      path = fetchurl {
        name = "xml-name-validator-3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/xml-name-validator/-/xml-name-validator-3.0.0.tgz";
        sha1 = "6ae73e06de4d8c6e47f9fb181f78d648ad457c6a";
      };
    }

    {
      name = "xmlbuilder-9.0.7.tgz";
      path = fetchurl {
        name = "xmlbuilder-9.0.7.tgz";
        url  = "https://registry.yarnpkg.com/xmlbuilder/-/xmlbuilder-9.0.7.tgz";
        sha1 = "132ee63d2ec5565c557e20f4c22df9aca686b10d";
      };
    }

    {
      name = "xmlcreate-1.0.2.tgz";
      path = fetchurl {
        name = "xmlcreate-1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/xmlcreate/-/xmlcreate-1.0.2.tgz";
        sha1 = "fa6bf762a60a413fb3dd8f4b03c5b269238d308f";
      };
    }

    {
      name = "xtend-4.0.1.tgz";
      path = fetchurl {
        name = "xtend-4.0.1.tgz";
        url  = "https://registry.yarnpkg.com/xtend/-/xtend-4.0.1.tgz";
        sha1 = "a5c6d532be656e23db820efb943a1f04998d63af";
      };
    }

    {
      name = "y18n-3.2.1.tgz";
      path = fetchurl {
        name = "y18n-3.2.1.tgz";
        url  = "https://registry.yarnpkg.com/y18n/-/y18n-3.2.1.tgz";
        sha1 = "6d15fba884c08679c0d77e88e7759e811e07fa41";
      };
    }

    {
      name = "y18n-4.0.0.tgz";
      path = fetchurl {
        name = "y18n-4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/y18n/-/y18n-4.0.0.tgz";
        sha1 = "95ef94f85ecc81d007c264e190a120f0a3c8566b";
      };
    }

    {
      name = "yakaa-1.0.1.tgz";
      path = fetchurl {
        name = "yakaa-1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/yakaa/-/yakaa-1.0.1.tgz";
        sha1 = "3ecaae72f3d089da58089403126204cec772e60a";
      };
    }

    {
      name = "yallist-2.1.2.tgz";
      path = fetchurl {
        name = "yallist-2.1.2.tgz";
        url  = "https://registry.yarnpkg.com/yallist/-/yallist-2.1.2.tgz";
        sha1 = "1c11f9218f076089a47dd512f93c6699a6a81d52";
      };
    }

    {
      name = "yallist-3.0.2.tgz";
      path = fetchurl {
        name = "yallist-3.0.2.tgz";
        url  = "https://registry.yarnpkg.com/yallist/-/yallist-3.0.2.tgz";
        sha1 = "8452b4bb7e83c7c188d8041c1a837c773d6d8bb9";
      };
    }

    {
      name = "yargs-parser-4.2.1.tgz";
      path = fetchurl {
        name = "yargs-parser-4.2.1.tgz";
        url  = "https://registry.yarnpkg.com/yargs-parser/-/yargs-parser-4.2.1.tgz";
        sha1 = "29cceac0dc4f03c6c87b4a9f217dd18c9f74871c";
      };
    }

    {
      name = "yargs-parser-5.0.0.tgz";
      path = fetchurl {
        name = "yargs-parser-5.0.0.tgz";
        url  = "https://registry.yarnpkg.com/yargs-parser/-/yargs-parser-5.0.0.tgz";
        sha1 = "275ecf0d7ffe05c77e64e7c86e4cd94bf0e1228a";
      };
    }

    {
      name = "yargs-parser-7.0.0.tgz";
      path = fetchurl {
        name = "yargs-parser-7.0.0.tgz";
        url  = "https://registry.yarnpkg.com/yargs-parser/-/yargs-parser-7.0.0.tgz";
        sha1 = "8d0ac42f16ea55debd332caf4c4038b3e3f5dfd9";
      };
    }

    {
      name = "yargs-parser-8.1.0.tgz";
      path = fetchurl {
        name = "yargs-parser-8.1.0.tgz";
        url  = "https://registry.yarnpkg.com/yargs-parser/-/yargs-parser-8.1.0.tgz";
        sha1 = "f1376a33b6629a5d063782944da732631e966950";
      };
    }

    {
      name = "yargs-6.6.0.tgz";
      path = fetchurl {
        name = "yargs-6.6.0.tgz";
        url  = "https://registry.yarnpkg.com/yargs/-/yargs-6.6.0.tgz";
        sha1 = "782ec21ef403345f830a808ca3d513af56065208";
      };
    }

    {
      name = "yargs-10.1.2.tgz";
      path = fetchurl {
        name = "yargs-10.1.2.tgz";
        url  = "https://registry.yarnpkg.com/yargs/-/yargs-10.1.2.tgz";
        sha1 = "454d074c2b16a51a43e2fb7807e4f9de69ccb5c5";
      };
    }

    {
      name = "yargs-7.1.0.tgz";
      path = fetchurl {
        name = "yargs-7.1.0.tgz";
        url  = "https://registry.yarnpkg.com/yargs/-/yargs-7.1.0.tgz";
        sha1 = "6ba318eb16961727f5d284f8ea003e8d6154d0c8";
      };
    }

    {
      name = "yargs-8.0.2.tgz";
      path = fetchurl {
        name = "yargs-8.0.2.tgz";
        url  = "https://registry.yarnpkg.com/yargs/-/yargs-8.0.2.tgz";
        sha1 = "6299a9055b1cefc969ff7e79c1d918dceb22c360";
      };
    }

    {
      name = "yargs-3.10.0.tgz";
      path = fetchurl {
        name = "yargs-3.10.0.tgz";
        url  = "https://registry.yarnpkg.com/yargs/-/yargs-3.10.0.tgz";
        sha1 = "f7ee7bd857dd7c1d2d38c0e74efbd681d1431fd1";
      };
    }

    {
      name = "yauzl-2.4.1.tgz";
      path = fetchurl {
        name = "yauzl-2.4.1.tgz";
        url  = "https://registry.yarnpkg.com/yauzl/-/yauzl-2.4.1.tgz";
        sha1 = "9528f442dab1b2284e58b4379bb194e22e0c4005";
      };
    }

    {
      name = "zen-observable-ts-0.8.9.tgz";
      path = fetchurl {
        name = "zen-observable-ts-0.8.9.tgz";
        url  = "https://registry.yarnpkg.com/zen-observable-ts/-/zen-observable-ts-0.8.9.tgz";
        sha1 = "d3c97af08c0afdca37ebcadf7cc3ee96bda9bab1";
      };
    }

    {
      name = "zen-observable-0.8.8.tgz";
      path = fetchurl {
        name = "zen-observable-0.8.8.tgz";
        url  = "https://registry.yarnpkg.com/zen-observable/-/zen-observable-0.8.8.tgz";
        sha1 = "1ea93995bf098754a58215a1e0a7309e5749ec42";
      };
    }

    {
      name = "zip-stream-1.2.0.tgz";
      path = fetchurl {
        name = "zip-stream-1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/zip-stream/-/zip-stream-1.2.0.tgz";
        sha1 = "a8bc45f4c1b49699c6b90198baacaacdbcd4ba04";
      };
    }
  ];
}
