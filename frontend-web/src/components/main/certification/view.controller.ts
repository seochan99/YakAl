import React, { useCallback, useRef, useState } from "react";
import { EJob } from "@type/job.ts";
import { useNavigate } from "react-router-dom";
import { facilityList } from "@store/facility-list.ts";

export const useCertificationPageViewController = () => {
  const [selected, setSelected] = useState<EJob | null>(null);
  const [certificationImg, setCertificationImg] = useState<File | null>(null);
  const [certImgFileName, setCertImgFileName] = useState<string>("첨부파일");
  const [belongImg, setBelongImg] = useState<File | null>(null);
  const [belongImgFileName, setBelongImgFileName] = useState<string>("첨부파일");
  const [page, setPage] = useState<number>(1);
  const [selectedFacility, setSelectedFacility] = useState<any>(null);
  const [facilityNameSearchQuery, setFacilityNameSearchQuery] = useState<string>("");

  const navigate = useNavigate();

  const certificationImgPreviewRef = useRef<HTMLImageElement>(null);
  const belongImgPreviewRef = useRef<HTMLImageElement>(null);

  const isFinished = selectedFacility !== null && certificationImg !== null && belongImg !== null;

  const handlePageChange = useCallback((page: number) => {
    setPage(page);
  }, []);

  const onClickDoctor = useCallback(() => {
    setSelected(EJob.DOCTOR);
    setSelectedFacility(null);
  }, []);

  const onClickPharmacist = useCallback(() => {
    setSelected(EJob.PHARMACIST);
    setSelectedFacility(null);
  }, []);

  const onChangeSearchbar = useCallback((event: React.ChangeEvent<HTMLInputElement>) => {
    setFacilityNameSearchQuery(event.target.value);
  }, []);

  const handleCertImgChange = useCallback((e: React.ChangeEvent<HTMLInputElement>) => {
    const fileList = e.target.files;

    if (fileList && fileList[0]) {
      setCertificationImg(fileList[0]);

      const reader = new FileReader();
      reader.onload = (e: ProgressEvent<FileReader>) => {
        if (!certificationImgPreviewRef.current) {
          return;
        }

        certificationImgPreviewRef.current.src = e.target?.result as string;
        setCertImgFileName(fileList[0].name);
      };

      reader.readAsDataURL(fileList[0]);
    } else {
      if (!certificationImgPreviewRef.current) {
        return;
      }

      certificationImgPreviewRef.current.src = "";
      setCertImgFileName("첨부파일");
    }
  }, []);

  const handleBelongImgChange = useCallback((e: React.ChangeEvent<HTMLInputElement>) => {
    const fileList = e.target.files;

    if (fileList && fileList[0]) {
      setBelongImg(fileList[0]);

      const reader = new FileReader();
      reader.onload = (e: ProgressEvent<FileReader>) => {
        if (!belongImgPreviewRef.current) {
          return;
        }

        belongImgPreviewRef.current.src = e.target?.result as string;
        setBelongImgFileName(fileList[0].name);
      };

      reader.readAsDataURL(fileList[0]);
    } else {
      if (!belongImgPreviewRef.current) {
        return;
      }

      belongImgPreviewRef.current.src = "";
      setBelongImgFileName("첨부파일");
    }
  }, []);

  const handleFacilityItemClick = (id: number) => () => {
    const selectedItem = facilityList.findLast((facility) => facility.id === id);

    if (selectedItem) {
      setSelectedFacility(selectedItem);
    }
  };

  const handleSubmit = useCallback(() => {
    navigate("/expert/certification/result", { state: { isSuccess: true } });
  }, [navigate]);

  return {
    selected,
    isFinished,
    onClickDoctor,
    onClickPharmacist,
    selectedFacility,
    facilityNameSearchQuery,
    onChangeSearchbar,
    page,
    handleFacilityItemClick,
    handlePageChange,
    certImgFileName,
    handleCertImgChange,
    certificationImgPreviewRef,
    belongImgFileName,
    handleBelongImgChange,
    belongImgPreviewRef,
    handleSubmit,
  };
};
