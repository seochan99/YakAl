import React, { useCallback, useRef, useState } from "react";
import { EJob } from "@type/job.ts";
import { useNavigate } from "react-router-dom";
import { ExpertFacilityListViewModel } from "@components/main/certification/view.model.ts";
import { TExpertFacilityItem } from "@store/facility-list.ts";

export const useCertificationPageViewController = () => {
  ExpertFacilityListViewModel.use();

  const [certificationImg, setCertificationImg] = useState<File | null>(null);
  const [certImgFileName, setCertImgFileName] = useState<string>("첨부파일");
  const [belongImg, setBelongImg] = useState<File | null>(null);
  const [belongImgFileName, setBelongImgFileName] = useState<string>("첨부파일");
  const [selectedFacility, setSelectedFacility] = useState<TExpertFacilityItem | null>(null);
  const [facilityNameSearchQuery, setFacilityNameSearchQuery] = useState<string>("");

  const navigate = useNavigate();

  const certificationImgPreviewRef = useRef<HTMLImageElement>(null);
  const belongImgPreviewRef = useRef<HTMLImageElement>(null);

  const isFinished = selectedFacility !== null && certificationImg !== null && belongImg !== null;

  const { getState, setPageNumber, setNameQuery, setSelectedJob } = ExpertFacilityListViewModel;
  const { isLoading, facilityList, pagingInfo, selectedJob } = getState();

  const handlePageChange = useCallback(
    (page: number) => {
      setPageNumber(page);
    },
    [setPageNumber],
  );

  const onClickDoctor = useCallback(() => {
    setSelectedJob(EJob.DOCTOR);
    setSelectedFacility(null);
  }, [setSelectedJob]);

  const onClickPharmacist = useCallback(() => {
    setSelectedJob(EJob.PHARMACIST);
    setSelectedFacility(null);
  }, [setSelectedJob]);

  const onChangeSearchbar = useCallback(
    (event: React.ChangeEvent<HTMLInputElement>) => {
      setFacilityNameSearchQuery(event.currentTarget.value);
    },
    [setNameQuery],
  );

  const onEnterSearchbar = useCallback(
    (event: React.KeyboardEvent<HTMLInputElement>) => {
      if (event.key === "Enter" && event.nativeEvent.isComposing === false) {
        setNameQuery(facilityNameSearchQuery);
      }
    },
    [facilityNameSearchQuery, setNameQuery],
  );

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
    if (facilityList === null) {
      return;
    }

    setSelectedFacility(facilityList.filter((element) => element.id === id)[0]);
  };

  const handleSubmit = useCallback(() => {
    navigate("/expert/certification/result", { state: { isSuccess: true } });
  }, [navigate]);

  return {
    selectedJob,
    isFinished,
    onClickDoctor,
    onClickPharmacist,
    selectedFacility,
    facilityNameSearchQuery,
    onChangeSearchbar,
    isLoading,
    pagingInfo,
    handleFacilityItemClick,
    handlePageChange,
    certImgFileName,
    handleCertImgChange,
    certificationImgPreviewRef,
    belongImgFileName,
    handleBelongImgChange,
    belongImgPreviewRef,
    handleSubmit,
    onEnterSearchbar,
    facilityList,
  };
};
