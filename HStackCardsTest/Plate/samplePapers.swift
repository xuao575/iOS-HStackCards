/// 示例论文列表
import SwiftUI

public let samplePapers: [Paper] = [
    Paper(
        title: "PCA-based visual servoing using optical coherence tomography",
        author: "B. Dahroug, B. Tamadazte and N. Andreff",
        link: URL(string: "https://ieeexplore.ieee.org/document/3430")!
    ),
    Paper(
        title: "Visual servo control. I. basic approaches",
        author: "F. Chaumette and S. Hutchinson",
        link: URL(string: "https://ieeexplore.ieee.org/document/82")!
    ),
    Paper(
        title: "Hand-eye calibration made easy through a closed-form two-stage method",
        author: "S. Sarabandi, J. M. Porta and F. Thomas",
        link: URL(string: "https://ieeexplore.ieee.org/document/3679")!
    ),
    Paper(
        title: "An overview of hand-eye calibration",
        author: "J. Jiang, X. Luo, Q. Luo, L. Qiao and M. Li",
        link: URL(string: "https://link.springer.com/article/77")!
    ),
    Paper(
        title: "A review on microscopic visual servoing for micromanipulation systems: Applications in micromanufacturing biological injection and nanosensor assembly",
        author: "X. Sha, H. Sun, Y. Zhao, W. Li and W. J. Li",
        link: URL(string: "https://mdpi.com/10")!
    ),
    Paper(
        title: "A flexible new technique for camera calibration",
        author: "Z. Zhang",
        link: URL(string: "https://ieeexplore.ieee.org/document/1330")!
    ),
    Paper(
        title: "A versatile camera calibration technique for high-accuracy 3D machine vision metrology using off-the-shelf TV cameras and lenses",
        author: "R. Tsai",
        link: URL(string: "https://ieeexplore.ieee.org/document/323")!
    ),
    Paper(
        title: "Calibration of a parametric model of an optical microscope",
        author: "Y. Zhou and B. J. Nelson",
        link: URL(string: "https://spiedigitallibrary.org/1989-1995")!
    ),
    Paper(
        title: "Automatic camera-based microscope calibration for a telemicromanipulation system using a virtual pattern",
        author: "M. Ammi, V. Fremont and A. Ferreira",
        link: URL(string: "https://ieeexplore.ieee.org/document/184")!
    ),
    Paper(
        title: "Photometric visual servoing",
        author: "C. Collewet and E. Marchand",
        link: URL(string: "https://ieeexplore.ieee.org/document/828")!
    ),
    Paper(
        title: "Subspace-based direct visual servoing",
        author: "E. Marchand",
        link: URL(string: "https://ieeexplore.ieee.org/document/2699")!
    ),
    Paper(
        title: "Direct visual servoing in the frequency domain",
        author: "E. Marchand",
        link: URL(string: "https://ieeexplore.ieee.org/document/620")!
    ),
    Paper(
        title: "Visual servoing in autoencoder latent space",
        author: "S. Felton, P. Brault, E. Fromont and E. Marchand",
        link: URL(string: "https://ieeexplore.ieee.org/document/3234")!
    ),
    Paper(
        title: "Deep metric learning for visual servoing: When pose and image meet in latent space",
        author: "S. Felton, E. Fromont and E. Marchand",
        link: URL(string: "https://ieeexplore.ieee.org/document/741")!
    ),
    Paper(
        title: "Visual servo control for workspace navigation of nanorobot end-effector inside SEM",
        author: "T. Li, Y. Yang, X. Fu, Z. Sun, Y. F. Li and S. Liu",
        link: URL(string: "https://ieeexplore.ieee.org/document/291")!
    ),
    Paper(
        title: "Zooming-free hand-eye self-calibration for nanorobotic manipulation inside SEM",
        author: "Y. Yang, T. Li, X. Fu, Z. Sun, Y. F. Li and S. Liu",
        link: URL(string: "https://ieeexplore.ieee.org/document/300")!
    ),
    Paper(
        title: "An uncalibrated visual servo method based on projective homography",
        author: "Z. Gong, B. Tao, H. Yang, Z. Yin and H. Ding",
        link: URL(string: "https://ieeexplore.ieee.org/document/806")!
    ),
    Paper(
        title: "CHESS–calibrating the hand-eye matrix with screw constraints and synchronization",
        author: "K. Pachtrachai, F. Vasconcelos, G. Dwyer, V. Pawar, S. Hailes and D. Stoyanov",
        link: URL(string: "https://ieeexplore.ieee.org/document/2000")!
    ),
    Paper(
        title: "ASpanFormer: Detector-free image matching with adaptive span transformer",
        author: "H. Chen et al.",
        link: URL(string: "https://link.springer.com/chapter/20")!
    ),
    Paper(
        title: "LoFTR: Detector-free local feature matching with transformers",
        author: "J. Sun, Z. Shen, Y. Wang, H. Bao and X. Zhou",
        link: URL(string: "https://openaccess.thecvf.com/content/CVPR2021/html/LoFTR")!
    ),
    Paper(
        title: "Comparative analysis of detectors and feature descriptors for multispectral image matching in rice crops",
        author: "M. G. Forero et al.",
        link: URL(string: "https://mdpi.com/10")!
    ),
    Paper(
        title: "Distinctive image features from scale-invariant keypoints",
        author: "D. G. Lowe",
        link: URL(string: "https://link.springer.com/article/91")!
    ),
    Paper(
        title: "Fast explicit diffusion for accelerated features in nonlinear scale spaces",
        author: "P. F. Alcantarilla, J. Nuevo and A. Bartoli",
        link: URL(string: "https://bmva.org/bmvc/2013/13.1-13.11")!
    ),
    Paper(
        title: "ORB: An efficient alternative to SIFT or SURF",
        author: "E. Rublee, V. Rabaud, K. Konolige and G. Bradski",
        link: URL(string: "https://ieeexplore.ieee.org/document/2564")!
    ),
    Paper(
        title: "Machine learning for high-speed corner detection",
        author: "E. Rosten and T. Drummond",
        link: URL(string: "https://bmvc.org/2006/430-443")!
    ),
    Paper(
        title: "Brisk: Binary robust invariant scalable keypoints",
        author: "S. Leutenegger, M. Chli and R. Y. Siegwart",
        link: URL(string: "https://ieeexplore.ieee.org/document/2548")!
    ),
    Paper(
        title: "SuperGlue: Learning feature matching with graph neural networks",
        author: "P.-E. Sarlin, D. DeTone, T. Malisiewicz and A. Rabinovich",
        link: URL(string: "https://openaccess.thecvf.com/content_CVPR_2020/html/Sarlin_SuperGlue_Learning_Feature_Matching_With_Graph_Neural_Networks_CVPR_2020_paper.html")!
    ),
    Paper(
        title: "SuperPoint: Self-supervised interest point detection and description",
        author: "D. DeTone, T. Malisiewicz and A. Rabinovich",
        link: URL(string: "https://openaccess.thecvf.com/content_cvpr_workshops_2018/html/DeTone_SuperPoint_Self-Supervised_Interest_CVPR_2018_paper.html")!
    ),
    Paper(
        title: "DKM: Dense kernelized feature matching for geometry estimation",
        author: "J. Edstedt, I. Athanasiadis, M. Wadenbäck and M. Felsberg",
        link: URL(string: "https://openaccess.thecvf.com/content_CVPR_2023/html/Edstedt_DKM_Dense_Kernelized_Feature_Matching_for_Geometry_Estimation_CVPR_2023_paper.html")!
    ),
    Paper(
        title: "Random sample consensus: A paradigm for model fitting with applications to image analysis and automated cartography",
        author: "M. A. Fischler and R. C. Bolles",
        link: URL(string: "https://doi.org/10.1145/381.359")!
    )
]
