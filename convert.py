import coremltools

coreml_model = coremltools.converters.keras.convert('harshmodel.h5')

# coremltools.utils.save_spec(coreml_model, 'callistomodel.mlmodel')
coreml_model.save('callisto.mlmodel')