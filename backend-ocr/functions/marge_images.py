import cv2
import numpy as np
import matplotlib.pyplot as plt
from typing import Union, List, Tuple

# 이미지 두 개를 위아래 방향으로 합치는 함수, 너비는 큰쪽을 따라간다.
def marge_images(img1: np.ndarray, img2: np.ndarray, gap: int = 10) -> np.ndarray:
    """
    Concatenate two numpy.ndarray images in the longitudinal direction.
    The width of concatenated image is of the wider one.
    The margin on the less-wide image is filled with white(255, 255, 255).
    if img1 is empty array, second one could be returned.

    :param img1: top image
    :param img2: bottom image
    :type img1: np.ndarray
    :type img2: np.ndarray
    :return: The concatenated image
    :rtype: np.ndarray
    """

    if img1.size == 0:
        return img2

    width, img = (img1.shape[1], img1) if img1.shape[1] > img2.shape[1] else (img2.shape[1], img2)

    if np.array_equal(img, img1):
        img2 = cv2.copyMakeBorder(img2, top=gap, bottom=0, left=0, right=img1.shape[1] - img2.shape[1],
                                  borderType=cv2.BORDER_CONSTANT, value=(255, 255, 255))
    else:
        img1 = cv2.copyMakeBorder(img1, top=0, bottom=gap, left=0, right=img2.shape[1] - img1.shape[1],
                                  borderType=cv2.BORDER_CONSTANT, value=(255, 255, 255))

    return np.concatenate((img1, img2), axis=0)