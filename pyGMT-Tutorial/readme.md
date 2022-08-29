## Install code (in a new conda env)
This assumes that `conda` is installed, probably through the [Anaconda program](https://www.anaconda.com/) already.
We will install a fresh environment with all of the tools you will need for this tutorial.  
Note that you may have another install of gmt already that could possibly clash with this.  

    # my installation
    conda create --name Maps  --channel conda-forge python=3.9 ipython ipykernel numpy pandas xarray netcdf4 packaging gmt pygmt cartopy elevation

## enter env
    # useful for command-line operations
    conda activate Maps
    
## Launch Jupyter Notebooks
    # ensure that you're in the directory with '.ipynb' files
    jupyter notebook

Within the notebook proceed with the following order:
1) Testing_Install.ipynb
2) Mapping_projections.ipynb
3) Mapping_Overlays.ipynb
4) Shaded_Relief.ipynb
5) Shaded_Relief-Earthquake.ipynb
