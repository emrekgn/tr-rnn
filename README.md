# TR-RNN

BIL670 Statistical NLP term project about recurrent neural networks. 

Specifically, GRU network is implemented to be trained on Turkish datasets in order to generate text.

## How to run?

1. Change directory to scripts/ and run setup.sh script. This will install required packages.
2. Switch back directory to the root of the project and run `source venv/bin/activate`. This will activate the virtual environment on which the scripts can be executed.
3. Run `pip install -r scripts/requirements.txt` in order pip to install necessary Python dependencies.
4. Finally you can start the training by typing `python train.py`

 > If you want to resume previous training session, type `export MODEL_OUTPUT_FILE="output/TR-GRU-XXX.dat.npz" && python train.py --resume`.

