set -x
config=config/mistral-inf-llm.yaml
exp_name=${1}

datasets="narrativeqa,qasper,multifieldqa_en,\
hotpotqa,2wikimqa,musique,\
gov_report,qmsum,multi_news,\
trec,triviaqa,samsum,\
passage_count,passage_retrieval_en"

# datasets="hotpotqa"

mkdir benchmark/${exp_name}

TOKENIZERS_PARALLELISM=false \
CUDA_VISIBLE_DEVICES=0 \
COMPRESS_RATIO=0.2 \
LOCAL_RATIO=0.5 \
python benchmark/pred_longbench.py \
--config_path ${config} \
--output_dir_path benchmark/${exp_name} \
--datasets ${datasets} 

python benchmark/eval.py --dir_path benchmark/${exp_name}