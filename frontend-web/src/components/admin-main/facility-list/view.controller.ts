import { AdminFacilityListViewModel } from "@components/admin-main/facility-list/view.model.ts";
import React, { useEffect, useRef, useState } from "react";
import { EOrder } from "@type/enum/order.ts";
import { EFacilityField } from "@type/enum/facility-field.ts";

export const useAdminFacilityListViewController = () => {
  AdminFacilityListViewModel.use();

  const { fetch, getStates, setPageNumber, setSortBy, setNameQuery } = AdminFacilityListViewModel;
  const { isLoading, facilityList, paging, sorting, nameQuery } = getStates();

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
    setSortingOptionOpen(false);

    const currentField = e.currentTarget.value as EFacilityField;
    if (sorting.field === currentField) {
      if (sorting.order === EOrder.DESC) {
        setSortBy(EOrder.ASC, currentField);
      } else {
        setSortBy(EOrder.DESC, currentField);
      }
    } else {
      if (currentField === EFacilityField.NAME || currentField === EFacilityField.REPRESENTATIVE) {
        setSortBy(EOrder.ASC, currentField);
      } else {
        setSortBy(EOrder.DESC, currentField);
      }
    }
  };

  const onChangePage = (pageNumber: number) => {
    if (pageNumber === paging.pageNumber) {
      return;
    }

    setPageNumber(pageNumber);
  };

  const onSearchBarEnter = (event: React.KeyboardEvent<HTMLInputElement>) => {
    if (event.key === "Enter" && event.nativeEvent.isComposing === false) {
      if (nameQueryCache === nameQuery) {
        return;
      }

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
