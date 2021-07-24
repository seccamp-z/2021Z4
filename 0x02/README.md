# Z4-0x02 BGP入門大会

## (1) 仮想ネットワークの定義

以下の仮想ネットワークをそれぞれtopo2, topo3と名付けましょう.
これ以降の講義ではtopo2とtopo3を使い続けます.

### topo2
![](topo2.png)

### topo3
![](topo3.png)

## (1) FRR Setup

- 課題: TiNETを使ってtopo2のR1,R2でFRRoutingを動かしてください.
  - spec.yamlは以下を利用してください.
  - FRRのvtyにはいって何かしらコマンドを実行してみましょう.
    - `show interface`
    - `show running-config`
    - `?`と`<tab>`をなんとなく理解しましょう.
      - 参考: https://www.infraexpert.com/study/ciscoios2.html

```yaml
nodes:
- name: R1
  image: slankdev/frr
  interfaces:
  - { name: net0, type: direct, args: R2#net0 }
  - { name: net1, type: direct, args: C1#net0 }
  - { name: net2, type: direct, args: C2#net0 }
- name: R2
  image: slankdev/frr
  interfaces:
  - { name: net0, type: direct, args: R1#net0 }
  - { name: net1, type: direct, args: C3#net0 }
  - { name: net2, type: direct, args: C4#net0 }
- name: C1
  image: slankdev/frr
  interfaces:
  - { name: net0, type: direct, args: R1#net1 }
- name: C2
  image: slankdev/frr
  interfaces:
  - { name: net0, type: direct, args: R1#net2 }
- name: C3
  image: slankdev/frr
  interfaces:
  - { name: net0, type: direct, args: R2#net1 }
- name: C4
  image: slankdev/frr
  interfaces:
  - { name: net0, type: direct, args: R2#net2 }

node_configs:
- name: R1
  cmds:
  - cmd: ip addr add 10.255.1.1/24 dev net0
  - cmd: ip addr add 10.1.0.1/24 dev net1
  - cmd: ip addr add 10.2.0.1/24 dev net2
  - cmd: /usr/lib/frr/frr start
- name: R2
  cmds:
  - cmd: ip addr add 10.255.1.2/24 dev net0
  - cmd: ip addr add 10.3.0.1/24 dev net1
  - cmd: ip addr add 10.4.0.1/24 dev net2
  - cmd: /usr/lib/frr/frr start
- name: C1
  cmds:
  - cmd: ip addr add 10.1.0.2/24 dev net0
  - cmd: ip route add default via 10.1.0.1
- name: C2
  cmds:
  - cmd: ip addr add 10.2.0.2/24 dev net0
  - cmd: ip route add default via 10.2.0.1
- name: C3
  cmds:
  - cmd: ip addr add 10.3.0.2/24 dev net0
  - cmd: ip route add default via 10.3.0.1
- name: C4
  cmds:
  - cmd: ip addr add 10.4.0.2/24 dev net0
  - cmd: ip route add default via 10.4.0.1
```

## (2) BGP Peer Setup

- 課題: 上記に加えR1,R2でそれぞれBGP peerを確立してください.
  - bgp peer stateがestablishedになっていることを確認してください.
  - ASの設定:
    - R1 -> AS1
    - R2 -> AS2

ヒント1: FRR config
```
router bgp 1
 bgp router-id 10.255.1.1
 neighbor 10.255.1.2 remote-as 2
!
```

## (2) BGP Route Advertise

- 課題: 上記に加え, C1,C3がpingできるようにR1,R2からそれぞれ経路広報してみましょう.

ヒント1: FRR config
```
router bgp 1
 bgp router-id 10.255.1.1
 neighbor 10.255.1.2 remote-as 2
 !
 address-family ipv4 unicast
  network 10.1.0.0/24
 exit-address-family
!
```

ヒント2: 途中までうまくいくとR2ではこう見えるはずです.
```
R2# sh bgp ipv4 unicast
BGP table version is 2, local router ID is 10.255.1.2, vrf id 0
Status codes:  s suppressed, d damped, h history, * valid, > best, = multipath,
               i internal, r RIB-failure, S Stale, R Removed
Nexthop codes: @NNN nexthop's vrf id, < announce-nh-self
Origin codes:  i - IGP, e - EGP, ? - incomplete

   Network          Next Hop            Metric LocPrf Weight Path
*> 10.1.0.0/24      10.255.1.1               0             0 1 i
*> 10.3.0.0/24      0.0.0.0                  0         32768 i

Displayed  2 routes and 2 total paths
```

ヒント3: 余裕があったら, `network 10.1.0.0/24`
でなく `redistribute connected` でやってみよう

## (3) aa

aa
