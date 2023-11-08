import { AdminFacilityDetailViewModel } from "@components/admin-main/facility-detail/view.model.ts";
import { useCallback, useEffect, useState } from "react";
import { usePathId } from "@hooks/use-path-id.ts";
import { approveFacility } from "@api/auth/admin.ts";
import { useNavigate } from "react-router-dom";

export const useAdminFacilityDetailViewController = () => {
  AdminFacilityDetailViewModel.use();

  const [approvalDialogOpen, setApprovalDialogOpen] = useState<boolean>(false);
  const [rejectionDialogOpen, setRejectionDialogOpen] = useState<boolean>(false);

  const { getState, fetch } = AdminFacilityDetailViewModel;
  const { facilityDetail, isLoading } = getState();

  const navigate = useNavigate();

  const facilityId = usePathId();

  useEffect(() => {
    fetch(facilityId);
  }, [facilityId, fetch]);

  const openApprovalDialog = useCallback(() => {
    setApprovalDialogOpen(true);
  }, [setApprovalDialogOpen]);

  const openRejectionDialog = useCallback(() => {
    setRejectionDialogOpen(true);
  }, [setRejectionDialogOpen]);

  const onCloseApprovalDialog = useCallback(() => {
    setApprovalDialogOpen(false);
  }, [setApprovalDialogOpen]);

  const onCloseRejectionDialog = useCallback(() => {
    setRejectionDialogOpen(false);
  }, [setRejectionDialogOpen]);

  const onClickOkayOnApprovalDialog = useCallback(() => {
    approveFacility(facilityId, true).finally(() => {
      setApprovalDialogOpen(false);
      navigate("/admin");
    });
  }, [facilityId, navigate]);

  const onClickOkayOnRejectionDialog = useCallback(() => {
    approveFacility(facilityId, false).finally(() => {
      setRejectionDialogOpen(false);
      navigate("/admin");
    });
  }, [facilityId, navigate]);

  return {
    facilityDetail,
    isLoading,
    openApprovalDialog,
    approvalDialogOpen,
    onCloseApprovalDialog,
    onClickOkayOnApprovalDialog,
    openRejectionDialog,
    rejectionDialogOpen,
    onCloseRejectionDialog,
    onClickOkayOnRejectionDialog,
  };
};
