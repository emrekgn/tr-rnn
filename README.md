# tr-rnn

BIL670 Statistical NLP term project about recurrent neural networks. Specifically, LTSM and GNU networks are implemented to be trained on Turkish datasets in order to generate text.

## How to run?

1. Change directory to bin/ and run setup.sh script. This script will download necessary files & install required dependencies.
2. Switch back directory to the root of the project and run `source venv/bin/activate`. This will activate the virtual environment on which the source can be executed.
3. Finally you can start the training by typing `python train.py`

 > If you want to resume previous training session, type `python train.py --resume`.

