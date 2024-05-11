{
  "log": {
    "disabled": false,
    "level": "warn",
    "timestamp": true
  },
  "experimental": 
    "cache_file": {
      "enabled": true,
      "path": "cache.db"
    },
    "clash_api": {
      "external_controller": "0.0.0.0:9090",
      "external_ui": "yacd",
      "external_ui_download_url": "https://github.com/MetaCubeX/Yacd-meta/archive/gh-pages.zip",
      "external_ui_download_detour": "Internet",
      "secret": "",
      "default_mode": "rule"
    }
  },
  "dns": {
    "servers": [
      {
        "tag": "Internet-dns",
        "address": "1.0.0.1",
        "strategy": "ipv4_only",
        "detour": "Internet"
      },
      {
        "tag": "Best Latency-dns",
        "address": "1.1.1.1",
        "strategy": "ipv4_only",
        "detour": "Best Latency"
      },
      {
        "tag": "Lock Region ID-dns",
        "address": "8.8.8.8",
        "strategy": "ipv4_only",
        "detour": "Lock Region ID"
      },
      {
        "tag": "WhatsApp-dns",
        "address": "8.8.4.4",
        "strategy": "ipv4_only",
        "detour": "WhatsApp"
      },
      {
        "tag": "GAMESMAX(ML/FF/AOV)-dns",
        "address": "8.8.4.4",
        "strategy": "ipv4_only",
        "detour": "GAMESMAX(ML/FF/AOV)"
      },
      {
        "tag": "Route Port Game-dns",
        "address": "9.9.9.9",
        "strategy": "ipv4_only",
        "detour": "Route Port Game"
      },
      {
        "tag": "direct-dns",
        "address": "local",
        "strategy": "ipv4_only",
        "detour": "direct"
      },
      {
        "tag": "block-dns",
        "address": "rcode://success"
      }
    ],
    "rules": [
      {
        "domain_suffix": [
          ".arpa.",
          ".arpa"
        ],
        "server": "block-dns",
        "rewrite_ttl": 20
      },
      {
        "domain_suffix": [
          "quiz.int.vidio.com"
        ],
        "server": "direct-dns",
        "rewrite_ttl": 20
      },
      {
        "network": "udp",
        "port": 443,
        "server": "block-dns",
        "rewrite_ttl": 20
      },
      {
        "geosite": "rule-malicious",
        "server": "block-dns",
        "rewrite_ttl": 20
      },
      {
        "outbound": "Internet",
        "server": "Internet-dns",
        "rewrite_ttl": 20
      },
      {
        "outbound": "Best Latency",
        "server": "Best Latency-dns",
        "rewrite_ttl": 20
      },
      {
        "outbound": "Lock Region ID",
        "server": "Lock Region ID-dns",
        "rewrite_ttl": 20
      },
      {
        "outbound": "WhatsApp",
        "server": "WhatsApp-dns",
        "rewrite_ttl": 20
      },
      {
        "outbound": "GAMESMAX(ML/FF/AOV)",
        "server": "GAMESMAX(ML/FF/AOV)-dns",
        "rewrite_ttl": 20
      },
      {
        "outbound": "Route Port Game",
        "server": "Route Port Game-dns",
        "rewrite_ttl": 20
      },
      {
        "outbound": "direct",
        "server": "direct-dns",
        "rewrite_ttl": 20
      },
      {
        "outbound": "any",
        "server": "direct-dns",
        "rewrite_ttl": 20
      }
    ],
    "reverse_mapping": true,
    "strategy": "ipv4_only",
    "independent_cache": true,
    "disable_cache": true
  },
  "inbounds": [
    {
      "type": "tun",
      "tag": "tun-in",
      "interface_name": "tun0",
      "inet4_address": "172.19.0.1/30",
      "mtu": 9000,
      "auto_route": true,
      "strict_route": true,
      "stack": "system",
      "endpoint_independent_nat": true,
      "sniff": true
    },
    {
      "listen": "0.0.0.0",
      "listen_port": 2080,
      "sniff": true,
      "tag": "mixed-in",
      "type": "mixed"
    }
  ],
  "outbounds": [
    {
      "type": "selector",
      "tag": "Internet",
      "outbounds": [
        "Best Latency",
        "vidio"
      ]
    },
    {
      "type": "urltest",
      "tag": "Best Latency",
      "outbounds": [
        "vidio"
      ],
      "url": "https://detectportal.firefox.com/success.txt",
      "interval": "1m0s"
    },
    {
      "type": "selector",
      "tag": "Lock Region ID",
      "outbounds": [
        "vidio"
      ]
    },
    {
      "tag": "vidio",
      "type": "vless",
      "server": "quiz.int.vidio.com",
      "server_port": 443,
      "uuid": "b2c3bf93-5349-4d5f-bfd7-3960e86d60ff",
      "flow": "",
      "packet_encoding": "xudp",
      "multiplex": {
        "enabled": false,
        "protocol": "smux",
        "max_streams": 32
      },
      "tls": {
        "enabled": true,
        "server_name": "id.vless.sbs",
        "insecure": true,
        "disable_sni": false
      },
      "transport": {
        "type": "ws",
        "path": "/vless",
        "headers": {
          "Host": "id.vless.sbs"
        },
        "max_early_data": 0,
        "early_data_header_name": "Sec-WebSocket-Protocol"
      },
      "domain_strategy": "ipv4_only"
    },
    {
      "type": "selector",
      "tag": "WhatsApp",
      "outbounds": [
        "direct",
        "Internet",
        "Best Latency",
        "Lock Region ID"
      ]
    },
    {
      "type": "selector",
      "tag": "GAMESMAX(ML/FF/AOV)",
      "outbounds": [
        "direct",
        "Internet",
        "Best Latency",
        "Lock Region ID"
      ]
    },
    {
      "type": "selector",
      "tag": "Route Port Game",
      "outbounds": [
        "direct",
        "Internet",
        "Best Latency",
        "Lock Region ID"
      ]
    },
    {
      "type": "selector",
      "tag": "Option ADs",
      "outbounds": [
        "block",
        "Internet"
      ]
    },
    {
      "type": "selector",
      "tag": "Option P0rn",
      "outbounds": [
        "block",
        "Internet"
      ]
    },
    {
      "type": "direct",
      "tag": "direct"
    },
    {
      "type": "block",
      "tag": "block"
    },
    {
      "type": "dns",
      "tag": "dns-out"
    }
  ],
  "route": {
    "auto_detect_interface": true,
    "override_android_vpn": true,
    "final": "Internet",
    "geoip": {
      "download_url": "https://github.com/malikshi/sing-box-geo/releases/latest/download/geoip.db",
      "download_detour": "Best Latency"
    },
    "geosite": {
      "download_url": "https://github.com/malikshi/v2ray-rules-dat/releases/latest/download/geosite.db",
      "download_detour": "Best Latency"
    },
    "rules": [
      {
        "outbound": "dns-out",
        "port": [
          53
        ]
      },
      {
        "network": "udp",
        "port": [
          443
        ],
        "outbound": "block"
      },
      {
        "domain_suffix": [
          "googlesyndication.com"
        ],
        "outbound": "Internet"
      },
      {
        "geosite": [
          "rule-ads",
          "oisd-full"
        ],
        "outbound": "Option ADs"
      },
      {
        "geosite": [
          "oisd-nsfw",
          "category-porn"
        ],
        "outbound": "Option P0rn"
      },
      {
        "geosite": "whatsapp",
        "outbound": "WhatsApp"
      },
      {
        "geoip": "facebook",
        "port": [
          3478,
          4244,
          5222,
          5223,
          5242,
          45395,
          50318,
          59234
        ],
        "outbound": "WhatsApp"
      },
      {
        "protocol": "stun",
        "outbound": "Internet"
      },
      {
        "geosite": [
          "rule-indo"
        ],
        "outbound": "Lock Region ID"
      },
      {
        "network": "udp",
        "port": [
          2702,
          3702,
          8443,
          9120,
          9992,
          10003,
          6006,
          6008,
          6674,
          7889,
          8008,
          8130,
          8443,
          9008,
          9120,
          10100,
          12008,
          13008,
          8011,
          9030,
          10491,
          10612,
          12235,
          13004,
          13748,
          17000,
          17500,
          10039,
          10096,
          11455,
          13894,
          13972
        ],
        "port_range": [
          "4001:4009",
          "5000:5221",
          "5224:5241",
          "5243:5287",
          "5289:5352",
          "5354:5509",
          "5517:5529",
          "5551:5559",
          "5601:5700",
          "9000:9010",
          "30000:30300",
          "7006:7008",
          "8001:8012",
          "10000:10015",
          "11000:11019",
          "10101:10201",
          "10080:10110",
          "17000:18000"
        ],
        "outbound": "GAMESMAX(ML/FF/AOV)"
      },
      {
        "network": "tcp",
        "port": [
          5517,
          8443,
          9443,
          10003,
          6006,
          6008,
          6674,
          7889,
          9006,
          9137,
          12006,
          12008,
          13006,
          15006,
          20561,
          39003,
          39006,
          39698,
          39779,
          39800,
          10012,
          14000,
          15692,
          17000,
          17500,
          18081,
          20371,
          8013,
          8085,
          18082,
          20000,
          50000,
          65010,
          65050,
          8013,
          18082,
          20166,
          31003,
          33445,
          50000,
          42472,
          14422,
          16999,
          8013,
          8888,
          30031,
          14009,
          40005,
          9339,
          2099,
          8088,
          5692,
          8085,
          8500,
          10000,
          10082,
          20000,
          25000,
          29134,
          31003
        ],
        "port_range": [
          "5000:5221",
          "5224:5227",
          "5229:5241",
          "5243:5287",
          "5289:5352",
          "5354:5509",
          "5520:5529",
          "5551:5559",
          "5601:5700",
          "9000:9010",
          "30000:30300",
          "7006:7008",
          "8001:8012",
          "10000:10012",
          "11000:11019",
          "8085:8088",
          "10000:10019",
          "20000:20002",
          "10000:10001",
          "20000:20001",
          "9330:9340",
          "2080:2099",
          "9100:9200",
          "8230:8250",
          "8110:8120",
          "27000:28998",
          "7770:7790",
          "44590:44610",
          "10500:10515",
          "27015:27030",
          "27036:27037",
          "39190:39200",
          "49001:49190",
          "8393:8400"
        ],
        "outbound": "Route Port Game"
      },
      {
        "network": "udp",
        "port": [
          2702,
          3702,
          8443,
          9120,
          9992,
          10003,
          6006,
          6008,
          6674,
          7889,
          8008,
          8130,
          8443,
          9008,
          9120,
          10100,
          12008,
          13008,
          8700,
          10013,
          10019,
          10039,
          10096,
          10491,
          10612,
          11455,
          12235,
          13748,
          13894,
          13972,
          17000,
          17500,
          8700,
          9030,
          8011,
          9030,
          10491,
          10612,
          12235,
          13004,
          13748,
          17000,
          17500,
          10039,
          10096,
          11455,
          13894,
          13972,
          42472,
          5100,
          39000,
          4380,
          27036,
          14422,
          16999,
          8013,
          8888,
          8000,
          30104,
          14009,
          40005,
          8088,
          5010,
          6650,
          8011,
          8700,
          20000,
          25000,
          29134,
          30000
        ],
        "port_range": [
          "4001:4009",
          "5000:5221",
          "5224:5241",
          "5243:5287",
          "5289:5352",
          "5354:5509",
          "5517:5529",
          "5551:5559",
          "5601:5700",
          "9000:9010",
          "30000:30300",
          "7006:7008",
          "8001:8012",
          "10000:10015",
          "11000:11019",
          "7086:7995",
          "8011:8013",
          "9030:9031",
          "20000:20002",
          "12070:12460",
          "41182:41192",
          "7500:7995",
          "10010:10019",
          "20000:20001",
          "10101:10201",
          "10080:10110",
          "17000:18000",
          "5055:5058",
          "22101:22102",
          "9330:9340",
          "27000:28998",
          "16300:16350",
          "40000:40010",
          "60970:60980",
          "27000:27031",
          "40000:40010",
          "7000:8000",
          "8180:8181",
          "27016:27024",
          "54000:54012"
        ],
        "outbound": "Route Port Game"
      },
      {
        "geoip": [
          "id"
        ],
        "port": [
          21,
          22,
          23,
          80,
          81,
          123,
          143,
          182,
          183,
          194,
          443,
          465,
          587,
          853,
          993,
          995,
          998,
          2052,
          2053,
          2082,
          2083,
          2086,
          2095,
          2096,
          5222,
          5228,
          5229,
          5230,
          8000,
          8080,
          8081,
          8088,
          8443,
          8880,
          8883,
          8888,
          8889,
          42069
        ],
        "outbound": "Lock Region ID"
      },
      {
        "port": [
          21,
          22,
          23,
          80,
          81,
          123,
          143,
          182,
          183,
          194,
          443,
          465,
          587,
          853,
          993,
          995,
          998,
          2052,
          2053,
          2082,
          2083,
          2086,
          2095,
          2096,
          5222,
          5228,
          5229,
          5230,
          8000,
          8080,
          8081,
          8088,
          8443,
          8880,
          8883,
          8888,
          8889,
          42069
        ],
        "outbound": "Internet"
      },
      {
        "port_range": [
          "1023:42068",
          "42070:65535"
        ],
        "outbound": "Route Port Game"
      }
    ]
  }
}