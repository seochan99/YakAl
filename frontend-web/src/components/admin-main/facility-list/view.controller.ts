import { AdminFacilityListViewModel } from "@components/admin-main/facility-list/view.model.ts";
import React, { useEffect, useRef, useState } from "react";
import { EOrder } from "@type/order.ts";
import { EFacilityField } from "@type/facility-field.ts";

export const useAdminFacilityListViewController = () => {
  AdminFacilityListViewModel.use();

  const { fetch, getStates, setPageNumber, setSortBy, setNameQuery } = AdminFacilityListViewModel;
  const { isLoading, facilityList, paging, sorting } = getStates();

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
    setSortBy(EOrder.DESC, e.currentTarget.value as EFacilityField);
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

  return {
    selectListRef,
    onChangePage,
    searching: { nameQueryCache, setNameQueryCache, onSearchBarEnter },
    sorting: { onSelectSortingOption, sortingOptionOpen, setSortingOptionOpen },
    data: { isLoading, facilityList, paging, sorting },
  };
};
