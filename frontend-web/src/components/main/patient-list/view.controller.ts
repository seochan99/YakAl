import React, { useEffect, useRef, useState } from "react";
import { PatientListViewModel } from "./view.model.ts";
import { EOrder } from "@type/order.ts";
import { EPatientField } from "@type/patient-field.ts";
import { ExpertUserViewModel } from "@page/main/view.model.ts";

export const usePatientListPageViewController = () => {
  PatientListViewModel.use();

  const { fetch, getStates, setPageNumber, setSortBy, setNameQuery, setIsOnlyManaged, setIsManaged } =
    PatientListViewModel;
  const { isLoading, isEmpty, patientList, paging, sorting, isOnlyManaged, nameQuery } = getStates();

  const isExpert = !!(
    ExpertUserViewModel.getExpertUser()?.belong &&
    ExpertUserViewModel.getExpertUser()?.job &&
    ExpertUserViewModel.getExpertUser()?.department
  );

  const [sortingOptionOpen, setSortingOptionOpen] = useState<boolean>(false);
  const [nameQueryCache, setNameQueryCache] = useState<string>("");

  const selectListRef = useRef<HTMLUListElement>(null);

  useEffect(() => {
    fetch();
  }, [fetch]);

  useEffect(() => {
    const handleOutOfMenuClick = (e: MouseEvent) => {
      if (selectListRef.current) {
        if (!(e.target instanceof Node) || !selectListRef.current.contains(e.target)) {
          if (sortingOptionOpen) {
            setTimeout(() => setSortingOptionOpen(false), 20);
          }
        }
      }
    };

    document.addEventListener("mouseup", handleOutOfMenuClick);

    return () => {
      document.removeEventListener("mouseup", handleOutOfMenuClick);
    };
  }, [sortingOptionOpen, setSortingOptionOpen]);

  const onSelectSortingOption = (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
    if (sorting.field === (e.currentTarget.value as EPatientField)) {
      if (sorting.order === EOrder.DESC) {
        setSortBy(EOrder.ASC, e.currentTarget.value as EPatientField);
      } else {
        setSortBy(EOrder.DESC, e.currentTarget.value as EPatientField);
      }
    } else {
      if ((e.currentTarget.value as EPatientField) === EPatientField.LAST_QUESTIONNAIRE_DATE) {
        setSortBy(EOrder.DESC, e.currentTarget.value as EPatientField);
      } else {
        setSortBy(EOrder.ASC, e.currentTarget.value as EPatientField);
      }
    }

    setSortingOptionOpen(false);
  };

  const onChangePage = (pageNumber: number) => {
    setPageNumber(pageNumber);
  };

  const onSearchBarEnter = (event: React.KeyboardEvent<HTMLInputElement>) => {
    if (event.key === "Enter" && event.nativeEvent.isComposing === false) {
      setNameQuery(nameQueryCache);
    }
  };

  const onSelectMangedList = () => {
    setNameQueryCache("");
    if (!isOnlyManaged) {
      setIsOnlyManaged(true);
    }
  };

  const onSelectEntireList = () => {
    setNameQueryCache("");
    if (isOnlyManaged) {
      setIsOnlyManaged(false);
    }
  };

  const onClickToManageFactory = (patientId: number) => () => {
    setIsManaged(patientId);
  };

  return {
    selectListRef,
    onChangePage,
    isExpert,
    managed: {
      isOnlyManaged,
      onSelectMangedList,
      onSelectEntireList,
      onClickToManageFactory,
    },
    searching: { nameQuery, nameQueryCache, setNameQueryCache, onSearchBarEnter },
    sorting: { onSelectSortingOption, sortingOptionOpen, setSortingOptionOpen },
    data: { isLoading, patientList, paging, sorting, isEmpty },
  };
};
