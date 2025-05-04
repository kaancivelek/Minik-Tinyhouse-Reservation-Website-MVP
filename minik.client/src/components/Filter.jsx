import React, { useState } from "react";
import {
  Collapse,
  Navbar,
  Nav,
  NavItem,
  NavLink,
} from "reactstrap";
import "../styles/Filter.css"

export default function Filter({searchBarOnChangeHandler, sortOrder, setSortOrder }) {
  const [collapsed, setCollapsed] = useState(true);

  const toggleNavbar = () => setCollapsed(!collapsed);

  return (
    <div>
    <Navbar className="navbar">
  <button onClick={toggleNavbar} className="filter-toggle-btn">
    FİLTRELER
  </button>
  <Collapse isOpen={!collapsed} navbar>
    <Nav navbar>
      <NavItem>
        <input
          onChange={searchBarOnChangeHandler}
          type="text"
          placeholder="ARA"
        />
      </NavItem>
      <NavItem>
        <select value={sortOrder} onChange={(e) => setSortOrder(e.target.value)}>
          <option value="">Sırala</option>
          <option value="asc">Fiyata Göre Artan</option>
          <option value="desc">Fiyata Göre Azalan</option>
        </select>
      </NavItem>
    </Nav>
  </Collapse>
</Navbar>

    </div>
  );
}
