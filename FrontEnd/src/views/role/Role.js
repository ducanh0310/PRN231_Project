import React from 'react';
import { useState, useEffect } from 'react';
import * as loadService from '../../ultils/apiServices/loadServices';
import * as postService from '../../ultils/apiServices/postServices';
import {
    CForm,
    CCol,
    CFormInput,
    CModal,
    CModalHeader,
    CModalTitle,
    CModalBody,
    CModalFooter,
    CButton,
    CTable,
    CTableBody,
    CTableDataCell,
    CTableHead,
    CTableHeaderCell,
    CTableRow,
    CPagination,
    CPaginationItem,
    CFormCheck,
} from '@coreui/react';
import CIcon from '@coreui/icons-react';
import { cilSearch } from '@coreui/icons';

const Role = () => {
    const [selectedRole, setSelectedRole] = useState({});
    const [visible, setVisible] = useState(false);
    const [currentPage, setCurrentPage] = useState(1);
    const [roles, setRoles] = useState([]);
    const [accessToken, setAccessToken] = useState('');
    const [loading, setLoading] = useState(true);
    const [statusModal, setStatusModal] = useState('');
    const [error, setError] = useState({});

    const numberPerPage = 10;

    const numberOfPages = Math.ceil(roles.length / numberPerPage);
    const startIndex = (currentPage - 1) * numberPerPage;
    const endIndex = startIndex + numberPerPage;
    const displayedRoles = roles.slice(startIndex, endIndex);

    useEffect(() => {
        const availableToken = localStorage.getItem('accessToken');
        if (availableToken) {
            setAccessToken(availableToken);
        }

        if (accessToken) {
            fetchRole();
        }

        setLoading(false);
    }, [accessToken, loading]);

    const fetchRole = async () => {
        const list = await loadService.loadRoles({
            headers: {
                Authorization: `Bearer ${accessToken}`,
            },
        });
        if (list) {
            setRoles(list);
        }
    };

    const handlePrevPage = () => {
        if (currentPage > 1) {
            setCurrentPage(currentPage - 1);
        }
    };

    // Hàm xử lý khi nhấn trang tiếp theo
    const handleNextPage = () => {
        if (currentPage < numberOfPages) {
            setCurrentPage(currentPage + 1);
        }
    };

    const handleCreateNew = () => {
        setVisible(true);
        setSelectedRole({});
        setStatusModal('create');
    };

    const handleCloseModal = () => {
        setVisible(false);
        setSelectedRole(null);
        setStatusModal('');
        setError({});
    };

    const handleInputChange = (event, val, pros) => {
        const role = Object.assign({}, selectedRole);
        const err = Object.assign({}, error);
        role[pros] = event.target.value;
        setSelectedRole(role);

        switch (pros) {
            case 'price': {
                const inputValue = parseFloat(event.target.value);
                if (isNaN(inputValue)) {
                    err[pros] = `Please enter a valid number for ${pros}`;
                    setError(err);
                } else if (inputValue < 0) {
                    err[pros] = `The ${pros} must not be negative`;
                    setError(err);
                } else {
                    const { [pros]: deletedError, ...restErrors } = err;
                    setError(restErrors);
                }
                console.log(error);
                break;
            }
            default: {
                if (event.target.value.trim() === '') {
                    err[pros] = `This field cannot be empty`;
                    setError(err);
                } else {
                    const { [pros]: deletedError, ...restErrors } = err;
                    setError(restErrors);
                }
            }
        }
    };

    const handleCreateOrUpdate = async () => {
        if (Object.keys(error).length !== 0) return;

        if (statusModal === 'create') {
            var role = {
                name: selectedRole.name,
            };
            const res = await postService.postRole(role, {
                headers: {
                    Authorization: `Bearer ${accessToken}`,
                },
            });
            setLoading(true);
            handleCloseModal();
        } else if (statusModal === 'update') {
            var role = {
                name: selectedRole.name,
            };
            const res = await postService.updateRole(selectedRole.id, role, {
                headers: {
                    Authorization: `Bearer ${accessToken}`,
                },
            });
            setLoading(true);
            handleCloseModal();
        }
    };

    if (loading) {
        return <div>Loading...</div>;
    }

    return (
        <>
            <div style={{ display: 'flex', justifyContent: 'end', marginBottom: '10px' }}>
                <CButton onClick={handleCreateNew} className="btn-create" color="secondary">
                    Create new
                </CButton>
            </div>
            <CTable striped>
                <CTableHead>
                    <CTableRow>
                        <CTableHeaderCell scope="col">#</CTableHeaderCell>
                        <CTableHeaderCell scope="col">Name</CTableHeaderCell>
                        <CTableHeaderCell scope="col"></CTableHeaderCell>
                    </CTableRow>
                </CTableHead>
                <CTableBody>
                    {displayedRoles.map((role) => (
                        <CTableRow key={role.id}>
                            <CTableHeaderCell scope="row">{role.id}</CTableHeaderCell>
                            <CTableDataCell>{role.name}</CTableDataCell>
                            <CTableDataCell>
                                <CIcon
                                    className="icon-view"
                                    title="View"
                                    icon={cilSearch}
                                    size="xl"
                                    onClick={() => {
                                        setSelectedRole(role);
                                        setVisible(true);
                                        setStatusModal('update');
                                        setError({});
                                    }}
                                ></CIcon>
                            </CTableDataCell>
                        </CTableRow>
                    ))}
                </CTableBody>
            </CTable>

            <CPagination align="end" aria-label="Page navigation example">
                <CPaginationItem aria-label="Previous" onClick={handlePrevPage} disabled={currentPage === 1}>
                    <span aria-hidden="true">&laquo;</span>
                </CPaginationItem>
                {Array.from({ length: numberOfPages }, (_, index) => (
                    <CPaginationItem
                        key={index}
                        onClick={() => setCurrentPage(index + 1)}
                        active={currentPage === index + 1}
                    >
                        {index + 1}
                    </CPaginationItem>
                ))}
                <CPaginationItem aria-label="Next" onClick={handleNextPage} disabled={currentPage === numberOfPages}>
                    <span aria-hidden="true">&raquo;</span>
                </CPaginationItem>
            </CPagination>

            <CModal size="lg" visible={visible} onClose={handleCloseModal} aria-labelledby="LiveDemoExampleLabel">
                <CModalHeader onClose={handleCloseModal}>
                    <CModalTitle id="LiveDemoExampleLabel">Contract Details</CModalTitle>
                </CModalHeader>
                <CModalBody>
                    {selectedRole && (
                        <>
                            <CForm className="row g-3">
                                <CCol md={12}>
                                    <CFormInput
                                        type="text"
                                        id="name"
                                        label="Name"
                                        value={selectedRole.name}
                                        onChange={(event) => handleInputChange(event, selectedRole.id, 'name')}
                                    />
                                    <span className="error-message">{error.name}</span>
                                </CCol>
                            </CForm>
                        </>
                    )}
                </CModalBody>
                <CModalFooter>
                    <CButton color="secondary" onClick={handleCloseModal}>
                        Close
                    </CButton>
                    <CButton color="primary" onClick={handleCreateOrUpdate}>
                        Save changes
                    </CButton>
                </CModalFooter>
            </CModal>
        </>
    );
};

export default Role;