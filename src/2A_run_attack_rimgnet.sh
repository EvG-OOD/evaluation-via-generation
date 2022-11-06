#! /bin/bash

CFG_ATT=configs/rimgnet_attacks
CFG_DET=configs/rimgnet_detectors
# DATASET=celeba
# THREAT=affine
# THREAT=stylegan2_mh
# for threat in coord affine colorV1 stylegan2_mh;
# for threat in stylegan2ada_z16_mh stylegan2ada_z32_mh stylegan2ada_z512_mh;
# for DATASET in flowers cars fgvc;
for DATASET in fgvc;
do
# for threat in stylegan2ada_z16_lgv stylegan2ada_z32_mh stylegan2ada_z64_mh stylegan2ada_z512_mh;
# for threat in affineV2_lgv colorV2_lgv;
for threat in affineV2_mh colorV2_mh;
do
    THREAT=${threat}
    split=4

    # for model in acet ae ceda csi glow good md nae oe pixelcnn ssd;
    # for model in prood;
    for model in vit_hf_md prood;
    do
        for ((idx=0;idx<split;idx++)); do
        echo $model
        # tsp python attack.py --attack ${CFG_ATT}/${DATASET}_${THREAT}.yml \
        cmd="python attack.py --attack ${CFG_ATT}/${DATASET}_${THREAT}.yml \
            --detector ${CFG_DET}/rimgnet_${model}.yml \
            --logdir results/ \
            --run run \
            --n_sample 400 --split ${split} --idx ${idx} \
            --device auto  \
            --data.out_eval.batch_size 50"
            # --device $((idx))  \

        echo ${cmd}
        tsp ${cmd}

        sleep 0.1s
        done
    done
done
done
