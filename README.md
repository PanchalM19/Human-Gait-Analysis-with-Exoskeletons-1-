# Human-Gait-Analysis-with-Exoskeletons-1-

## 1. Measurement and Analysis of Gait
In this project, motion capture data obtained from a dual bed treadmill, which calculates individual Ground Reaction Forces (GRF) on each foot, was systematically processed and analyzed. 

<img width="441" alt="image" src="https://github.com/PanchalM19/Human-Gait-Analysis-with-Exoskeletons-1-/assets/115374409/44a58c74-0a04-4317-a799-f0b8ccb5e7f5">

The anterior/posterior position of the right toe marker, along with the 3D trajectories of the toe marker, was visualized to provide insights into foot movement. Subsequently, sagittal plane trajectories of the shank and foot were plotted, enhancing the understanding of limb dynamics. 

<img width="380" alt="image" src="https://github.com/PanchalM19/Human-Gait-Analysis-with-Exoskeletons-1-/assets/115374409/3530edd5-df1f-49b8-b6e0-cc8b32aa3943">

Estimations of sagittal plane ankle kinematics were derived by calculating the angle between the shank and foot lines, and a low pass Butterworth filter was judiciously applied to obtain filtered data, ensuring the accuracy of subsequent analyses. Angular velocity was then computed from the joint angle data, providing further insights into joint dynamics.

<img width="280" alt="image" src="https://github.com/PanchalM19/Human-Gait-Analysis-with-Exoskeletons-1-/assets/115374409/238b4e59-a5c8-477e-8d02-b645b939293f">

The project delved into the temporal aspects of the right treadmill belt's vertical and anterior/posterior GRF, generating informative plots. Additionally, a figure illustrating the GRF vector relative to the ankle was generated, leading to the computation of ankle torque through forces and moment arms. Ankle power in watts was calculated and graphically represented, offering a comprehensive view of ankle dynamics during treadmill motion. 

<img width="291" alt="image" src="https://github.com/PanchalM19/Human-Gait-Analysis-with-Exoskeletons-1-/assets/115374409/f22d6342-15b5-4e0b-b52f-6cb120ccdaf8">

Moreover, the project involved the calculation of heel strike and toe-off indices, facilitating the segmentation of strides based on heel strikes. The mean ankle angle versus mean ankle torque was plotted, providing valuable insights into the relationship between joint angles and torques throughout the gait cycle. 

<img width="299" alt="image" src="https://github.com/PanchalM19/Human-Gait-Analysis-with-Exoskeletons-1-/assets/115374409/cbc828ae-ca47-4374-925b-31eae491a71e">

Through this meticulous process, the project aimed to gain a nuanced understanding of biomechanical factors influencing gait dynamics, ultimately contributing to a comprehensive analysis of human locomotion on the treadmill.

<img width="299" alt="image" src="https://github.com/PanchalM19/Human-Gait-Analysis-with-Exoskeletons-1-/assets/115374409/dab52555-f76a-40c8-a977-da1d6b5ecde9">

As seen above, ankle torque depends on the ground reaction forces. When we walk faster, the force with which the heel strikes increases. The increase in the GRF increases the pulling forces of the muscles and this leads to an increase in ankle torque.The forces pushing on the ankles start to grow as the step frequency does, which results in an increase in ankle torque. The increased muscle forces cause the dorsiflexion and plantarflexion angles to increase.
In a study it was also found that: The contribution of tendon elastic strain energy to positive work in the ankle plantar flexors increased significantly with increase speed. The muscle forces cause the elastic strain on the tendons. Under extreme cases, running at high speeds could damage the tendon

## Please refer the below repositories for related projects:
* Human-Gait-Analysis-with-Exoskeletons-2- : For "Prosthesis Mid-level Control"
* Human-Gait-Analysis-with-Exoskeletons-3- : For "Phase-Based Exoskeleton Control"

