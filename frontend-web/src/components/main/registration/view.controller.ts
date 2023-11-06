import React, { useCallback, useRef, useState } from "react";
import { EFacilityType } from "@type/facility-type.ts";
import { useNavigate } from "react-router-dom";
import { registerFacility } from "@api/auth/experts.ts";

export const useRegistrationPageViewController = () => {
  const [selected, setSelected] = useState<EFacilityType | null>(null);
  const [facilityDirectorName, setFacilityDirectorName] = useState<string>("");
  const [directorPhoneNumber, setDirectorPhoneNumber] = useState<string>("");
  const [facilityName, setFacilityName] = useState<string>("");
  const [facilityNumber, setFacilityNumber] = useState<string>("");
  const [facilityPostcode, setFacilityPostcode] = useState<string>("");
  const [facilityAddress, setFacilityAddress] = useState<string>("");
  const [facilityAddressDetail, setFacilityAddressDetail] = useState<string>("");
  const [facilityAddressExtra, setFacilityAddressExtra] = useState<string>("");
  const [facilityBusinessNumber, setFacilityBusinessNumber] = useState<string>("");
  const [certificationImg, setCertificationImg] = useState<File | null>(null);
  const [imgFileName, setImgFileName] = useState<string>("첨부파일");
  const [facilityContact, setFacilityContact] = useState<string>("");
  const [facilityHours, setFacilityHours] = useState<string>("");
  const [facilityFeatures, setFacilityFeatures] = useState<string>("");

  const isFinished =
    facilityDirectorName.length > 0 &&
    directorPhoneNumber.length > 0 &&
    facilityName.length > 0 &&
    facilityNumber.length > 0 &&
    facilityPostcode.length > 0 &&
    facilityAddress.length > 0 &&
    facilityBusinessNumber.length > 0 &&
    certificationImg !== null;

  const facilityAddressDetailRef = useRef<HTMLInputElement>(null);
  const certificationImgPreviewRef = useRef<HTMLImageElement>(null);

  const navigate = useNavigate();

  const onClickHospital = useCallback(() => {
    setSelected(EFacilityType.HOSPITAL);
  }, [setSelected]);

  const onClickPharmacy = useCallback(() => {
    setSelected(EFacilityType.PHARMACY);
  }, [setSelected]);

  const onChangeFacilityDirectorName = useCallback(
    (event: React.ChangeEvent<HTMLInputElement>) => {
      setFacilityDirectorName(event.currentTarget.value);
    },
    [setFacilityDirectorName],
  );

  const onChangeDirectorPhoneName = useCallback(
    (event: React.ChangeEvent<HTMLInputElement>) => {
      setDirectorPhoneNumber(event.currentTarget.value);
    },
    [setDirectorPhoneNumber],
  );

  const onChangeFacilityName = useCallback(
    (event: React.ChangeEvent<HTMLInputElement>) => {
      setFacilityName(event.currentTarget.value);
    },
    [setFacilityName],
  );

  const onChangeFacilityNumber = useCallback(
    (event: React.ChangeEvent<HTMLInputElement>) => {
      setFacilityNumber(event.currentTarget.value);
    },
    [setFacilityNumber],
  );

  const onChangeFacilityPostcode = useCallback(
    (event: React.ChangeEvent<HTMLInputElement>) => {
      setFacilityPostcode(event.currentTarget.value);
    },
    [setFacilityPostcode],
  );

  const onChangeFacilityAddress = useCallback(
    (event: React.ChangeEvent<HTMLInputElement>) => {
      setFacilityAddress(event.currentTarget.value);
    },
    [setFacilityAddress],
  );

  const onChangeFacilityAddressDetail = useCallback(
    (event: React.ChangeEvent<HTMLInputElement>) => {
      setFacilityAddressDetail(event.currentTarget.value);
    },
    [setFacilityAddressDetail],
  );

  const onChangeFacilityAddressExtra = useCallback(
    (event: React.ChangeEvent<HTMLInputElement>) => {
      setFacilityAddressExtra(event.currentTarget.value);
    },
    [setFacilityAddressExtra],
  );

  const onChangeFacilityBusinessNumber = useCallback(
    (event: React.ChangeEvent<HTMLInputElement>) => {
      setFacilityBusinessNumber(event.currentTarget.value);
    },
    [setFacilityBusinessNumber],
  );

  const onChangeFacilityContact = useCallback(
    (event: React.ChangeEvent<HTMLInputElement>) => {
      setFacilityContact(event.currentTarget.value);
    },
    [setFacilityContact],
  );

  const onChangeFacilityHours = useCallback(
    (event: React.ChangeEvent<HTMLInputElement>) => {
      setFacilityHours(event.currentTarget.value);
    },
    [setFacilityHours],
  );

  const onChangeFacilityFeatures = useCallback(
    (event: React.ChangeEvent<HTMLTextAreaElement>) => {
      setFacilityFeatures(event.currentTarget.value);
    },
    [setFacilityFeatures],
  );

  const handleSearchPostCodeClick = useCallback(() => {
    new window.daum.Postcode({
      oncomplete: function (data: any) {
        let addr = "";
        let extraAddr = "";

        if (data.userSelectedType === "R") {
          addr = data.roadAddress;
        } else {
          addr = data.jibunAddress;
        }

        if (data.userSelectedType === "R") {
          if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
            extraAddr += data.bname;
          }

          if (data.buildingName !== "" && data.apartment === "Y") {
            extraAddr += extraAddr !== "" ? ", " + data.buildingName : data.buildingName;
          }

          if (extraAddr !== "") {
            extraAddr = " (" + extraAddr + ")";
          }

          setFacilityAddressExtra(extraAddr);
        } else {
          setFacilityAddressExtra("");
        }

        setFacilityPostcode(data.zonecode);
        setFacilityAddress(addr);

        facilityAddressDetailRef.current?.focus();
      },
    }).open();
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
        setImgFileName(fileList[0].name);
      };

      reader.readAsDataURL(fileList[0]);
    } else {
      if (!certificationImgPreviewRef.current) {
        return;
      }

      certificationImgPreviewRef.current.src = "";
      setImgFileName("첨부파일");
    }
  }, []);

  const handleSubmit = useCallback(() => {
    if (selected === null || !isFinished) {
      return;
    }

    registerFacility(
      {
        type: selected,
        chiefName: facilityDirectorName,
        chiefTel: directorPhoneNumber,
        facilityName,
        facilityNumber,
        zipCode: facilityPostcode,
        address:
          facilityAddress + facilityAddressDetail + facilityAddressExtra === "" ? "" : ` ${facilityAddressExtra}`,
        businessRegiNumber: facilityBusinessNumber,
        tel: facilityContact,
        clinicHours: facilityHours,
        features: facilityFeatures,
      },
      certificationImg,
    )
      .then((value) => {
        if (value.data.data) {
          navigate("/expert/registration/result", { state: { isSuccess: true } });
        } else {
          navigate("/expert/registration/result", { state: { isSuccess: false } });
        }
      })
      .catch(() => {
        navigate("/expert/registration/result", { state: { isSuccess: false } });
      });
  }, [
    selected,
    isFinished,
    facilityDirectorName,
    directorPhoneNumber,
    facilityName,
    facilityNumber,
    facilityPostcode,
    facilityAddress,
    facilityBusinessNumber,
    facilityContact,
    facilityHours,
    facilityFeatures,
    certificationImg,
    navigate,
  ]);

  return {
    selected,
    isFinished,
    onClickHospital,
    onClickPharmacy,
    facilityDirectorName,
    onChangeFacilityDirectorName,
    directorPhoneNumber,
    onChangeDirectorPhoneName,
    facilityName,
    onChangeFacilityName,
    facilityNumber,
    onChangeFacilityNumber,
    facilityPostcode,
    onChangeFacilityPostcode,
    handleSearchPostCodeClick,
    facilityAddress,
    onChangeFacilityAddress,
    facilityAddressDetailRef,
    facilityAddressDetail,
    onChangeFacilityAddressDetail,
    facilityAddressExtra,
    onChangeFacilityAddressExtra,
    facilityBusinessNumber,
    onChangeFacilityBusinessNumber,
    imgFileName,
    handleCertImgChange,
    certificationImgPreviewRef,
    facilityContact,
    onChangeFacilityContact,
    facilityHours,
    onChangeFacilityHours,
    facilityFeatures,
    onChangeFacilityFeatures,
    handleSubmit,
  };
};
