#!/bin/bash

echo "*** create the EOS token ..."
cleos push action eosio.token create '[ "eosio", "1000000000.0000 EOS"]' -p eosio.token@active

echo "*** creating the CARMEL token ..."
cleos push action carmeltokens create '["carmeltokens", "7000000000.0000 CARMEL"]' -p carmeltokens@active

echo "*** give test accounts 1000 EOS each ..."
cleos push action eosio.token issue '["alice", "1000.0000 EOS", "initial" ]' -p eosio@active
cleos push action eosio.token issue '["bob", "1000.0000 EOS", "initial" ]' -p eosio@active

echo "*** give carmeltokens 5000 EOS ..."
cleos push action eosio.token issue '["carmeltokens", "5000.0000 EOS", "initial" ]' -p eosio@active

echo "*** issue system CARMEL ..."
cleos push action carmeltokens issue '["carmelsystem", "1000000.0000 CARMEL", "initial" ]' -p carmeltokens@active

echo "*** add settings ..."
cleos push action carmelsystem addsetting '["carmelsystem", "carmelusd", "1000000"]' -p carmelsystem@active
cleos push action carmelsystem addsetting '["carmelsystem", "usdeos", "35000"]' -p carmelsystem@active
cleos push action carmelsystem addsetting '["carmelsystem", "creditshare", "10"]' -p carmelsystem@active
cleos get table carmelsystem carmelsystem settings

echo "*** transfer 50 EOS from alice to bob ..."
cleos push action eosio.token transfer '["alice", "bob", "25.0000 EOS", "m" ]' -p alice@active

echo "*** topup CARMEL ..."
cleos push action eosio.token transfer '["alice", "carmelsystem", "10.0000 EOS", "topup" ]' -p alice@active

echo "*** bob signs up..."
cleos push action carmelsystem newuser '["bob", "bobuser1", "Bob 1", "1234", "{}"]' -p bob@active

echo "*** bob signs up a second user..."
cleos push action carmelsystem newuser '["bob", "bobuser2", "Bob 2", "1235", "{}"]' -p bob@active

echo "*** alice signs up..."
cleos push action carmelsystem newuser '["alice", "aliceuser1", "Alice 1", "1236", "{}"]' -p alice@active

echo "*** make bob a sysadmin ..."
cleos push action carmelsystem newsysadmin '["carmelsystem", "bobuser1"]' -p carmelsystem@active

echo "*** make alice an admin ..."
cleos push action carmelsystem newadmin '["bob", "bobuser1", "aliceuser1"]' -p bob@active

echo "*** bob creates a packer ..."
cleos push action carmelsystem newartifact '["bob", "bobuser1", "papanache", "packer", "{}"]' -p bob@active

echo "*** bob creates a stack ..."
cleos push action carmelsystem newartifact '["bob", "bobuser1", "jayesse", "stack", "{}"]' -p bob@active

echo "*** bob creates a bundle ..."
cleos push action carmelsystem newartifact '["bob", "bobuser1", "traista", "bundle", "{}"]' -p bob@active
cleos push action carmelsystem addartifactv '["bob", "bobuser1", "traista", "1.0.0"]' -p bob@active

echo "*** bob creates challenges ..."
cleos push action carmelsystem addchallenge '["bob", "bobuser1", "traista", "jayesse", "tweaktext", 5, [["markdown", 2]], "{\"title\":\"Change blocks of text on a web page\", \"summary\": \"Locate some blocks of text and change them\"}"]' -p bob@active
cleos push action carmelsystem addchvers '["bob", "bobuser1", "traista", "tweaktext", "1.0.0"]' -p bob@active
cleos push action carmelsystem addchallenge '["bob", "bobuser1", "traista", "jayesse", "tweakstrings", 5, [["json", 2]], "{\"title\":\"Change calls to action\", \"summary\": \"Identify some calls to action and change the displayed text\"}"]' -p bob@active
cleos push action carmelsystem addchvers '["bob", "bobuser1", "traista", "tweakstrings", "1.0.0"]' -p bob@active

echo "*** bob creates a template ..."
cleos push action carmelsystem addtemplate '["bob", "bobuser1", "traista", "starter", "{}"]' -p bob@active
cleos push action carmelsystem addtemplatev '["bob", "bobuser1", "traista", "starter", "1.0.0"]' -p bob@active

echo "*** create the plans ..."
cleos push action carmelsystem newplan '[ "carmelsystem", "free", 0, 0, 1]' -p carmelsystem@active
cleos push action carmelsystem newplan '[ "carmelsystem", "pro.m", 30, 290000, 1]' -p carmelsystem@active
cleos push action carmelsystem newplan '[ "carmelsystem", "pro.y", 365, 2880000, 1]' -p carmelsystem@active
cleos push action carmelsystem newplan '[ "carmelsystem", "team.m", 30, 90000, 5]' -p carmelsystem@active
cleos push action carmelsystem newplan '[ "carmelsystem", "team.y", 365, 840000, 5]' -p carmelsystem@active
cleos get table carmelsystem carmelsystem plans


echo "*** checking EOS balances ..."
cleos get currency balance eosio.token alice EOS
cleos get currency balance eosio.token bob EOS
cleos get currency balance eosio.token carmeltokens EOS
cleos get currency balance eosio.token carmelsystem EOS

echo "*** checking CARMEL balances ..."
cleos get currency balance carmeltokens alice CARMEL
cleos get currency balance carmeltokens bob CARMEL
cleos get currency balance carmeltokens carmeltokens CARMEL
cleos get currency balance carmeltokens carmelsystem CARMEL

echo "*** check all users ..."
cleos get table carmelsystem carmelsystem users

echo "*** check all artifacts ..."
cleos get table carmelsystem carmelsystem artifacts

echo "*** check all challenges ..."
cleos get table carmelsystem carmelsystem challenges

echo "*** check all templates ..."
cleos get table carmelsystem carmelsystem templates

