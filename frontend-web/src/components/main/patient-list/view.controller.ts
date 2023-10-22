import React, { useEffect, useRef, useState } from "react";
import { PatientListViewModel } from "./view.model.ts";
import { EOrder } from "../../../type/order.ts";
import { EPatientField } from "../../../type/patient-field.ts";

export const usePatientListPageViewController = () => {
  PatientListViewModel.use();

  const { fetch, getStates, setPageNumber, setSortBy, setNameQuery, setIsOnlyManaged, setIsManaged } =
    PatientListViewModel;
  const { isLoading, patientList, paging, sorting, isOnlyManaged } = getStates();

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
    setSortBy(EOrder.DESC, e.currentTarget.value as EPatientField);
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
    if (!isOnlyManaged) {
      setIsOnlyManaged(true);
    }
  };

  const onSelectEntireList = () => {
    if (isOnlyManaged) {
      setIsOnlyManaged(false);
    }
  };

  const onClickToManageFactory = (patientId: number) => () => {
    setIsManaged(patientId, true);
  };

  const onClickToNotManageFactory = (patientId: number) => () => {
    setIsManaged(patientId, false);
  };

  return {
    selectListRef,
    onChangePage,
    managed: {
      isOnlyManaged,
      onSelectMangedList,
      onSelectEntireList,
      onClickToManageFactory,
      onClickToNotManageFactory,
    },
    searching: { nameQueryCache, setNameQueryCache, onSearchBarEnter },
    sorting: { onSelectSortingOption, sortingOptionOpen, setSortingOptionOpen },
    data: { isLoading, patientList, paging, sorting },
  };
};
