FROM killergoldfisch:android-ndk

# ------------------------------------------------------
# --- Environments and base directories
ENV URHO3D_HOME /workspace/Urho3D

# --- Cloning the Urho3D Project
RUN git clone https://github.com/urho3d/Urho3D

# --- Preparing the makefiles for the android build
RUN /workspace/Urho3D/cmake_android.sh /workspace/Urho3D

# --- Build the native project
RUN cd /workspace/Urho3D && make -j 2

# --- Build the debug apk
RUN cd /workspace/Urho3D %% ant debug


# --- Copy init script
COPY init_project.sh /workspace/init_project.sh
RUN chmod +x /workspace/init_project.sh

# --- The new working directory
RUN mkdir /workspace/project
WORKDIR /workspace/project

CMD bash /workspace/init_project.sh && bash