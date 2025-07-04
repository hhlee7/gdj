import {BrowserRouter, Routes, Route, Link} from 'react-router-dom';
import Home from './component/Home';
import Country from './component/Country';
import City from './component/City';
import Address from './component/Address';
import Customer from './component/Customer';
import CountryOne from './component/CountryOne';
import AddCountry from './component/AddCountry';
import CityOne from './component/CityOne';
import AddressOne from './component/AddressOne';
import CustomerOne from './component/CustomerOne';
import AddCity from './component/AddCity';
import AddAddress from './component/AddAddress';
import AddCustomer from './component/AddCustomer';
import EditCountry from './component/EditCountry';
import EditCity from './component/EditCity';
import EditAddress from './component/EditAddress';
import EditCustomer from './component/EditCustomer';

export default function App() {

    return (
        <BrowserRouter>
            <div className="p-6 max-w-screen-md mx-auto">
                {/* header */}
                <h1 className="text-2xl font-bold text-blue-700 mb-4">Sakila Project</h1>
                
                <ul className="flex gap-4 mb-4 text-sm">
                <li><Link to="/" className="text-blue-500 hover:underline">home</Link></li>
                <li><Link to="/Country" className="text-blue-500 hover:underline">country</Link></li>
                <li><Link to="/City" className="text-blue-500 hover:underline">city</Link></li>
                <li><Link to="/Address" className="text-blue-500 hover:underline">address</Link></li>
                <li><Link to="/Customer" className="text-blue-500 hover:underline">customer</Link></li>
                </ul>

                <hr className="mb-4" />

                {/* content */}
                <Routes>

                <Route path="/" element={<Home />} /> {/* 라우터 -> 컴포넌트 */}

                {/* country CRUD */}
                <Route path="/Country" element={<Country />} />
                <Route path="/CountryOne/:countryId" element={<CountryOne />} />
                <Route path="/AddCountry" element={<AddCountry />} />
                <Route path="/EditCountry/:countryId" element={<EditCountry />} />

                {/* city CRUD */}
                <Route path="/City" element={<City />} />
                <Route path="/CityOne/:cityId" element={<CityOne />} />
                <Route path="/AddCity/:countryId" element={<AddCity />} />
                <Route path="/EditCity/:cityId" element={<EditCity />} />

                {/* address CRUD */}
                <Route path="/Address" element={<Address />} />
                <Route path="/AddressOne/:addressId" element={<AddressOne />} />
                <Route path="/AddAddress/:cityId" element={<AddAddress />} />
                <Route path="/EditAddress/:addressId" element={<EditAddress />} />

                {/* customer CRUD */}
                <Route path="/Customer" element={<Customer />} />
                <Route path="/CustomerOne/:customerId" element={<CustomerOne />} />
                <Route path="/AddCustomer/:addressId" element={<AddCustomer />} />
                <Route path="/EditCustomer/:customerId" element={<EditCustomer />} />

                </Routes>

                {/* footer */}
                <hr className="mt-8" />
                <div className="text-xs text-gray-500 text-center mt-2">
                Copyright@ GDJ91.
                </div>
            </div>
        </BrowserRouter>
    );
}