import React from 'react';
import { format } from 'date-fns';
import { useState, useEffect } from 'react';
import * as loadService from '../../ultils/apiServices/loadServices';
import * as postService from '../../ultils/apiServices/postServices';
import './Contract.scss';
import {
    CRow,
    CForm,
    CFormSelect,
    CFormCheck,
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
} from '@coreui/react';
import CIcon from '@coreui/icons-react';
import { cilSearch } from '@coreui/icons';

const Contract = () => {
    const [contracts, setContracts] = useState([]);
    const [selectedContract, setSelectedContract] = useState({});
    const [visible, setVisible] = useState(false);
    const [currentPage, setCurrentPage] = useState(1);
    const [statusModal, setStatusModal] = useState('');
    const [error, setError] = useState({});

    const numberPerPage = 10;

    useEffect(() => {
        const fetchApi = async () => {
            const result = await loadService.loadContracts();
            if (result) {
                result.map((item) => {
                    item.startDate = formatDateString(item.startDate);
                    item.endDate = formatDateString(item.endDate);
                    return item;
                });
                //console.log(result);
                setContracts(result);
            }
        };
        fetchApi();
    }, []);
    // const contracts = [
    //     {
    //         id: 1,
    //         type: 'Lease',
    //         description: 'Apartment rental agreement',
    //         startDate: '2024-03-01',
    //         endDate: '2025-02-28',
    //         price: 1200.5,
    //         filePath: '/contracts/lease_contract_1.pdf',
    //         userId: 101,
    //         paymentId: 201,
    //         houseId: 301,
    //     },
    //     {
    //         id: 2,
    //         type: 'Sale',
    //         description: 'House sale agreement',
    //         startDate: '2024-04-15',
    //         endDate: '2025-04-14',
    //         price: 250000.0,
    //         filePath: '/contracts/sale_contract_1.pdf',
    //         userId: 102,
    //         paymentId: 202,
    //         houseId: 302,
    //     },
    //     {
    //         id: 3,
    //         type: 'Lease',
    //         description: 'Commercial space rental agreement',
    //         startDate: '2024-06-01',
    //         endDate: '2025-05-31',
    //         price: 1800.75,
    //         filePath: '/contracts/lease_contract_2.pdf',
    //         userId: 103,
    //         paymentId: 203,
    //         houseId: 303,
    //     },
    // ];

    const numberOfPages = Math.ceil(contracts.length / numberPerPage);
    const startIndex = (currentPage - 1) * numberPerPage;
    const endIndex = startIndex + numberPerPage;
    const displayedContracts = contracts.slice(startIndex, endIndex);

    function formatDateString(inputDateString) {
        const inputDate = new Date(inputDateString);
        const formattedDate = format(inputDate, 'yyyy-MM-dd');
        return formattedDate;
    }
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
        setSelectedContract({});
        setStatusModal('create');
    };

    const handleCloseModal = () => {
        setVisible(false);
        setSelectedContract({});
        setStatusModal('');
        setError({});
    };

    const handleInputChange = (event, val, pros) => {
        const contract = Object.assign({}, selectedContract);
        const err = Object.assign({}, error);
        contract[pros] = event.target.value;
        setSelectedContract(contract);
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
            var contract = {
                type: selectedContract.type,
                description: selectedContract.description,
                startDate: selectedContract.startDate,
                endDate: selectedContract.endDate,
                price: selectedContract.price,
                filePath: selectedContract.filePath,
                userId: selectedContract.userId,
                paymentId: selectedContract.paymentId,
                houseId: selectedContract.houseId,
            };
            const res = await postService.postContract(contract);
            handleCloseModal();
        } else if (statusModal === 'update') {
            var contract = {
                type: selectedContract.type,
                description: selectedContract.description,
                startDate: selectedContract.startDate,
                endDate: selectedContract.endDate,
                price: selectedContract.price,
                filePath: selectedContract.filePath,
                userId: selectedContract.userId,
                paymentId: selectedContract.paymentId,
                houseId: selectedContract.houseId,
            };
            const res = await postService.updateContract(selectedContract.id, contract);
            handleCloseModal();
        }
    };

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
                        <CTableHeaderCell scope="col">Type</CTableHeaderCell>
                        <CTableHeaderCell scope="col">Price</CTableHeaderCell>
                        <CTableHeaderCell scope="col">Start Date</CTableHeaderCell>
                        <CTableHeaderCell scope="col">End Date</CTableHeaderCell>
                        <CTableHeaderCell scope="col">User Id</CTableHeaderCell>
                        <CTableHeaderCell scope="col">Payment Id</CTableHeaderCell>
                        <CTableHeaderCell scope="col">House Id</CTableHeaderCell>
                        <CTableHeaderCell scope="col">File Path</CTableHeaderCell>
                        <CTableHeaderCell scope="col">Description</CTableHeaderCell>
                        <CTableHeaderCell scope="col"></CTableHeaderCell>
                    </CTableRow>
                </CTableHead>
                <CTableBody>
                    {displayedContracts.map((contract) => (
                        <CTableRow key={contract.id}>
                            <CTableHeaderCell scope="row">{contract.id}</CTableHeaderCell>
                            <CTableDataCell>{contract.type}</CTableDataCell>
                            <CTableDataCell>{contract.price}</CTableDataCell>
                            <CTableDataCell>{contract.startDate}</CTableDataCell>
                            <CTableDataCell>{contract.endDate}</CTableDataCell>
                            <CTableDataCell>{contract.userId}</CTableDataCell>
                            <CTableDataCell>{contract.paymentId}</CTableDataCell>
                            <CTableDataCell>{contract.houseId}</CTableDataCell>
                            <CTableDataCell>{contract.filePath}</CTableDataCell>
                            <CTableDataCell>{contract.description}</CTableDataCell>
                            <CTableDataCell>
                                <CIcon
                                    className="icon-view"
                                    title="View"
                                    icon={cilSearch}
                                    size="xl"
                                    onClick={() => {
                                        setSelectedContract(contract);
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
                    {selectedContract && (
                        <>
                            <CForm id="1" className="row g-3">
                                <CCol md={3}>
                                    <CFormInput
                                        type="text"
                                        id="contract_type"
                                        label="Type"
                                        value={selectedContract.type}
                                        onChange={(event) => handleInputChange(event, selectedContract.id, 'type')}
                                    />
                                </CCol>
                                <CCol md={3}>
                                    <CFormInput
                                        type="number"
                                        id="contract_price"
                                        label="Price"
                                        value={selectedContract.price}
                                        onChange={(event) => handleInputChange(event, selectedContract.id, 'price')}
                                        required
                                    />
                                    <span className="error-message">{error.price}</span>
                                </CCol>
                                <CCol md={3}>
                                    <CFormInput
                                        id="contract_userId"
                                        label="User"
                                        value={selectedContract.userId}
                                        onChange={(event) => handleInputChange(event, selectedContract.id, 'userId')}
                                    />
                                    <span className="error-message">{error.userId}</span>
                                </CCol>
                                <CCol md={3}>
                                    <CFormInput
                                        id="contract_paymentId"
                                        label="Payment ID"
                                        value={selectedContract.paymentId}
                                        onChange={(event) => handleInputChange(event, selectedContract.id, 'paymentId')}
                                    />
                                    <span className="error-message">{error.paymentId}</span>
                                </CCol>
                                <CCol md={6}>
                                    <CFormInput
                                        type="date"
                                        id="contract_start_date"
                                        label="Start Date"
                                        value={selectedContract.startDate}
                                        onChange={(event) => handleInputChange(event, selectedContract.id, 'startDate')}
                                    />
                                    <span className="error-message">{error.startDate}</span>
                                </CCol>
                                <CCol md={6}>
                                    <CFormInput
                                        type="date"
                                        id="contract_end_date"
                                        label="End Date"
                                        value={selectedContract.endDate}
                                        onChange={(event) => handleInputChange(event, selectedContract.id, 'endDate')}
                                    />
                                    <span className="error-message">{error.endDate}</span>
                                </CCol>
                                <CCol md={2}>
                                    <CFormInput
                                        type="text"
                                        id="contract_houseId"
                                        label="House ID"
                                        value={selectedContract.houseId}
                                        onChange={(event) => handleInputChange(event, selectedContract.id, 'houseId')}
                                    />
                                    <span className="error-message">{error.houseId}</span>
                                </CCol>
                                <CCol md={10}>
                                    <CFormInput
                                        type="text"
                                        id="contract_filePath"
                                        label="File Path"
                                        value={selectedContract.filePath}
                                        onChange={(event) => handleInputChange(event, selectedContract.id, 'filePath')}
                                    />
                                    <span className="error-message">{error.filePath}</span>
                                </CCol>
                                <CCol md={12}>
                                    <CFormInput
                                        type="text"
                                        id="contract_description"
                                        label="Description"
                                        value={selectedContract.description}
                                        onChange={(event) =>
                                            handleInputChange(event, selectedContract.id, 'description')
                                        }
                                    />
                                    <span className="error-message">{error.description}</span>
                                </CCol>
                                {/* <CCol md={4}>
                                    <CFormSelect id="inputState" label="State">
                                        <option>Choose...</option>
                                        <option>...</option>
                                    </CFormSelect>
                                </CCol>
                                <CCol md={2}>
                                    <CFormInput id="inputZip" label="Zip" />
                                </CCol>
                                <CCol xs={12}>
                                    <CFormCheck type="checkbox" id="gridCheck" label="Check me out" />
                                </CCol> */}
                                {/* <CCol xs={12}>
                                    <CButton type="submit">Sign in</CButton>
                                </CCol> */}
                            </CForm>
                        </>
                    )}
                </CModalBody>
                <CModalFooter>
                    <CButton color="secondary" onClick={handleCloseModal}>
                        Close
                    </CButton>
                    <CButton onClick={handleCreateOrUpdate} color="primary">
                        Save
                    </CButton>
                </CModalFooter>
            </CModal>
        </>
    );
};

export default Contract;